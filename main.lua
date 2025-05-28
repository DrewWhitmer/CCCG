-- Drew Whitmer
-- CMPM 121 - CCCG
-- 5/20/2025

io.stdout:setvbuf("no")

CARD_OFFSET = 5

COLORS = {
  WHITE = {1, 1, 1},
  BLACK = {0, 0, 0}
}

function love.load()
  require "vector"
  require "card"
  require "grabber"
  require "lane"
  require "hand"
  
  love.window.setTitle("The Cards of Theseus")
  love.window.setMode(960, 640)
  love.graphics.setBackgroundColor(0, 0.7, 0.2, 1)
  
  cardTable = {}
  
  playerDeck = {}
  playerDeckPos = Vector(720, 500)
  enemyDeck = {}
  enemyDeckPos = Vector(720, 50)
  
  for i = 1, 20 do
    local card = CardClass:new(1, 1, 1, 1, CARD_STATES.IN_DECK, playerDeckPos)
    table.insert(playerDeck, card)
    table.insert(cardTable, card)
  end
  
  for i = 1, 20 do
    local card = CardClass:new(1, 1, 1, 1, CARD_STATES.IN_DECK, enemyDeckPos)
    table.insert(enemyDeck, card)
    table.insert(cardTable, card)
  end
  
  playerHand = HandClass:new(150, 540)
  enemyHand = HandClass:new(150, 10)
  
  for i = 1, 3 do
    drawCards()
  end
  
  grabber = GrabberClass:new()
  playerLaneTable = {LaneClass:new(150, 330), LaneClass:new(150 + LANE_WIDTH + 20, 330), LaneClass:new(150 + LANE_WIDTH * 2 + 40, 330)}
  enemyLaneTable = {LaneClass:new(150, 110), LaneClass:new(150 + LANE_WIDTH + 20, 110), LaneClass:new(150 + LANE_WIDTH * 2 + 40, 110)}
  
  revealQueue = {}
  
  turn = 1
  playerMana = turn
  enemyMana = turn
  
  playerPoints = 0
  enemyPoints = 0
end

function love.update()
  grabber:update()
  
  for _, card in ipairs(cardTable) do
    card:update()
  end
  
  playerHand:update()
  enemyHand:update()
  
end

function love.keypressed(key)
  nextTurn()
end


function love.draw()
  
  for _, lane in ipairs(playerLaneTable) do
    lane:draw()
  end
  
  for _, lane in ipairs(enemyLaneTable) do
    lane:draw()
  end
  
  for _, card in ipairs(cardTable) do
    card:draw()
  end
  
end

function love.mousepressed()
  grabbedCard = grabber:grab()
end

function love.mousereleased()
  grabber:release(grabbedCard)
end

function nextTurn()
  playRandomEnemyCard()
  
  --reveal all flipped cards
  for _, card in ipairs(revealQueue) do
    card.state = CARD_STATES.IN_PLAY
    card:onReveal()
  end
  
  --get the total power of a specific lane for player and enemy. If enemy power is greater, add it to enemy points, else add it to player points
  for index = 1, 3 do
    lanePower = playerLaneTable[index]:getTotalPower() - enemyLaneTable[index]:getTotalPower()
    if lanePower < 0 then
      enemyPoints = enemyPoints - lanePower
    else
      playerPoints = playerPoints + lanePower
    end
  end

  if lanePower < 0 then
    enemyPoints = enemyPoints - lanePower
  else
    playerPoints = playerPoints + lanePower
  end
  
  drawCards()
    
  turn = turn + 1
  playerMana = turn
  enemyMana = turn
end

function playRandomEnemyCard()
  --try to play a random card
  local randomIndex = math.random(#enemyHand.cards)
  local randomCard = enemyHand.cards[randomIndex]
  local randomLane = enemyLaneTable[math.random(3)]
  if randomCard.cost < enemyMana and #randomLane.cards < 4 then
    randomLane:addCard(randomCard)
    table.remove(enemyHand.cards, randomIndex)
    table.insert(revealQueue, randomCard)
    return
  end
  
  --if the card can not be played, cycle through every lane and every card trying to play a card
  for index, card in ipairs(enemyHand.cards) do
    for _, lane in ipairs(enemyLaneTable) do
      if card.cost <= enemyMana and #lane.cards < 4 then
        randomLane:addCard(card)
        table.remove(enemyHand.cards, index)
        table.insert(revealQueue, card)
        return
      end
    end
  end
  
end

--draw a card for both players
function drawCards()
  --we use the add card function for the player hand and not the enemy hand so that the state of the enemy's card does not change, keeping it uninteractable
  playerHand:addCard(playerDeck[1])
  table.remove(playerDeck, 1)
  table.insert(enemyHand.cards, enemyDeck[1])
  table.remove(enemyDeck, 1)
end
