-- Drew Whitmer
-- CMPM 121 - CCCG
-- 5/20/2025

io.stdout:setvbuf("no")
require "vector"

CARD_OFFSET = 5

COLORS = {
  WHITE = {1, 1, 1},
  BLACK = {0, 0, 0},
  BLUE = {0.1, 0.3, 0.9},
  GREY = {0.5, 0.5, 0.5},
  RED = {0.9, 0.1, 0.3},
  GREEN = {0, 0.7, 0.2},
}

ENEMY_DECK_POS = Vector(720, 50)
PLAYER_DECK_POS = Vector(720, 500)

LANE_OFFSET = 20
STARTING_LANE_X = 150
PLAYER_LANE_Y = 330
ENEMY_LANE_Y = 110

SUBMIT_BUTTON_POS = Vector(850, 320)
OUTER_SUBMIT_RAD = 50
INNER_SUBMIT_RAD = 45
SUBMIT_TEXT = "submit"

RETRY_BUTTON_POS = Vector(0, 500)
OUTER_RETRY_RAD = 50
INNER_RETRY_RAD = 45
RETRY_TEXT = "reset"

GAME_STATE_X = 0
GAME_STATE_Y = 320
GAME_STATE_OFFSET = 20

FONT_SIZE = 12
GAME_OVER_FONT_SIZE = 70

GAME_OVER_X = 280
GAME_OVER_Y = 0

function love.load()
  require "Cards/card"
  require "grabber"
  require "lane"
  require "hand"
  
  love.window.setTitle("The Cards of Theseus")
  love.window.setMode(960, 640)
  love.graphics.setBackgroundColor(COLORS.GREEN)
  
  cardTable = {}
  
  playerDeck = {}
  enemyDeck = {}
  
  --cards that go in each player's deck twice
  twoPerDeck = {
    WoodCowClass:new(Vector(0, 0)),
    PegasusClass:new(Vector(0, 0)),
    MinotaurClass:new(Vector(0, 0)),
    TitanClass:new(Vector(0, 0)),
    AresClass:new(Vector(0, 0)),
    PandoraClass:new(Vector(0, 0))
  }
  --cards that go in each player's deck once
  onePerDeck = {
    ArtemisClass:new(Vector(0, 0)),
    HeraClass:new(Vector(0, 0)),
    DemeterClass:new(Vector(0, 0)),
    HerculesClass:new(Vector(0, 0)),
    DionysusClass:new(Vector(0, 0)),
    MidasClass:new(Vector(0, 0)),
    AphroditeClass:new(Vector(0, 0)),
    HephClass:new(Vector(0, 0))
  }
  
  playerHand = HandClass:new(150, 540)
  enemyHand = HandClass:new(150, 10)
  
  
  grabber = GrabberClass:new()
  playerLaneTable = {
    LaneClass:new(STARTING_LANE_X, PLAYER_LANE_Y, playerHand), 
    LaneClass:new(STARTING_LANE_X + LANE_WIDTH + LANE_OFFSET, PLAYER_LANE_Y, playerHand), 
    LaneClass:new(STARTING_LANE_X + LANE_WIDTH * 2 + LANE_OFFSET * 2, PLAYER_LANE_Y, playerHand)
  }
  
  enemyLaneTable = {
    LaneClass:new(STARTING_LANE_X, ENEMY_LANE_Y, enemyHand), 
    LaneClass:new(STARTING_LANE_X + LANE_WIDTH + LANE_OFFSET, ENEMY_LANE_Y, enemyHand),
    LaneClass:new(STARTING_LANE_X + LANE_WIDTH * 2 + LANE_OFFSET * 2, ENEMY_LANE_Y, enemyHand)
  }
  
  gameOver = false
  
  reset()
end

function love.update()
  grabber:update()
  
  for _, card in ipairs(cardTable) do
    card:update()
  end
  
  playerHand:update()
  enemyHand:update()
  
end

function love.draw()
  
  love.graphics.setFont(love.graphics.setNewFont(FONT_SIZE))
  for _, lane in ipairs(playerLaneTable) do
    lane:draw()
  end
  
  for _, lane in ipairs(enemyLaneTable) do
    lane:draw()
  end
  
  for _, card in ipairs(cardTable) do
    card:draw()
  end
  
  --submit button
  love.graphics.setColor(COLORS.GREY)
  love.graphics.circle("fill", SUBMIT_BUTTON_POS.x + OUTER_SUBMIT_RAD, SUBMIT_BUTTON_POS.y + OUTER_SUBMIT_RAD, OUTER_SUBMIT_RAD)
  love.graphics.setColor(COLORS.BLUE)
  love.graphics.circle("fill", SUBMIT_BUTTON_POS.x + OUTER_SUBMIT_RAD, SUBMIT_BUTTON_POS.y + OUTER_SUBMIT_RAD, INNER_SUBMIT_RAD)
  love.graphics.setColor(COLORS.BLACK)
  love.graphics.print(SUBMIT_TEXT, SUBMIT_BUTTON_POS.x + OUTER_SUBMIT_RAD, SUBMIT_BUTTON_POS.y + INNER_SUBMIT_RAD, 0, 1, 1, love.graphics.getFont():getWidth(SUBMIT_TEXT)/2)
  
  --retry button
  love.graphics.setColor(COLORS.GREY)
  love.graphics.circle("fill", RETRY_BUTTON_POS.x + OUTER_RETRY_RAD, RETRY_BUTTON_POS.y + OUTER_RETRY_RAD, OUTER_RETRY_RAD)
  love.graphics.setColor(COLORS.RED)
  love.graphics.circle("fill", RETRY_BUTTON_POS.x + OUTER_RETRY_RAD, RETRY_BUTTON_POS.y + OUTER_RETRY_RAD, INNER_RETRY_RAD)
  love.graphics.setColor(COLORS.BLACK)
  love.graphics.print(RETRY_TEXT, RETRY_BUTTON_POS.x + OUTER_RETRY_RAD, RETRY_BUTTON_POS.y + INNER_RETRY_RAD, 0, 1, 1, love.graphics.getFont():getWidth(RETRY_TEXT)/2)
  
  --game state information
  love.graphics.print("Player points: " .. playerPoints, GAME_STATE_X, GAME_STATE_Y)
  love.graphics.print("AI points: " .. enemyPoints, GAME_STATE_X, GAME_STATE_Y + GAME_STATE_OFFSET)
  love.graphics.print("Player mana: " .. playerMana, GAME_STATE_X, GAME_STATE_Y + 2 * GAME_STATE_OFFSET)
  love.graphics.print("AI mana: " .. enemyMana, GAME_STATE_X, GAME_STATE_Y + 3 * GAME_STATE_OFFSET)
  
  if not gameOver then
    return
  end
  
  love.graphics.setFont(love.graphics.setNewFont(GAME_OVER_FONT_SIZE))
  if enemyPoints > playerPoints then
    love.graphics.print("You Lose", GAME_OVER_X, GAME_OVER_Y)
  else
    love.graphics.print("You Win!", GAME_OVER_X, GAME_OVER_Y)
  end
  
  
end

function love.mousepressed(x, y, button)
  grabbedCard = grabber:grab(button)
end

function love.mousereleased(x, y, button)
  grabber:release(grabbedCard, button)
end

function reset()
  
  --reset cards
  cardTable = {}
  playerDeck = {}
  enemyDeck = {}
  
  for _, card in ipairs(twoPerDeck) do
    local card1 = card:new(PLAYER_DECK_POS)
    local card2 = card:new(PLAYER_DECK_POS)
    table.insert(playerDeck, card1)
    table.insert(cardTable, card1)
    table.insert(playerDeck, card2)
    table.insert(cardTable, card2)
  end
  
  for _, card in ipairs(twoPerDeck) do
    local card1 = card:new(ENEMY_DECK_POS)
    local card2 = card:new(ENEMY_DECK_POS)
    table.insert(enemyDeck, card1)
    table.insert(cardTable, card1)
    table.insert(enemyDeck, card2)
    table.insert(cardTable, card2)
  end
  
  for _, card in ipairs(onePerDeck) do
    local card1 = card:new(PLAYER_DECK_POS)
    local card2 = card:new(ENEMY_DECK_POS)
    table.insert(playerDeck, card1)
    table.insert(cardTable, card1)
    table.insert(enemyDeck, card2)
    table.insert(cardTable, card2)
  end
  
  math.randomseed(os.time())
  --Modern Fisher-Yates
  local cardCount = #playerDeck
  for i = 1, cardCount do
    local randIndex = math.random(cardCount)
    local temp = playerDeck[randIndex]
    playerDeck[randIndex] = playerDeck[cardCount]
    playerDeck[cardCount] = temp
    cardCount = cardCount - 1
  end
  
  cardCount = #enemyDeck
  for i = 1, cardCount do
    local randIndex = math.random(cardCount)
    local temp = enemyDeck[randIndex]
    enemyDeck[randIndex] = enemyDeck[cardCount]
    enemyDeck[cardCount] = temp
    cardCount = cardCount - 1
  end
  
  for _, lane in ipairs(playerLaneTable) do
    lane.cards = {}
  end
  
  for _, lane in ipairs(enemyLaneTable) do
    lane.cards = {}
  end
  
  playerHand.cards = {}
  enemyHand.cards = {}
  
  for i = 1, 3 do
    drawCards()
    playerLaneTable[i].adj = enemyLaneTable[i]
    enemyLaneTable[i].adj = playerLaneTable[i]
  end
  
  --reset game state
  turn = 1
  playerMana = turn
  enemyMana = turn
  playerPoints = 0
  enemyPoints = 0
  gameOver = false
end

function nextTurn()
  playRandomEnemyCard()
  
  --reveal all flipped cards
  if playerPoints > enemyPoints then
    revealCards(playerLaneTable)
    revealCards(enemyLaneTable)
  elseif enemyPoints > playerPoints then
    revealCards(enemyLaneTable)
    revealCards(playerLaneTable)
  elseif math.random() > 0.5 then
    revealCards(playerLaneTable)
    revealCards(enemyLaneTable)
  else
    revealCards(enemyLaneTable)
    revealCards(playerLaneTable)
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

  if playerPoints >= 25 or enemyPoints >= 25 then
    gameOver = true
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
    return
  end
  
  --if the card can not be played, cycle through every lane and every card trying to play a card
  for index, card in ipairs(enemyHand.cards) do
    for _, lane in ipairs(enemyLaneTable) do
      if card.cost <= enemyMana and #lane.cards < 4 then
        randomLane:addCard(card)
        table.remove(enemyHand.cards, index)
        return
      end
    end
  end
  
end

--draw a card for both players
function drawCards()
  --we use the add card function for the player hand and not the enemy hand so that the state of the enemy's card does not change, keeping it uninteractable
  if #playerHand.cards < 7 then
    playerHand:addCard(playerDeck[1])
    playerDeck[1].hand = playerHand
    table.remove(playerDeck, 1)
  end
  if #enemyHand.cards < 7 then
    table.insert(enemyHand.cards, enemyDeck[1])
    enemyDeck[1].hand = enemyHand
    table.remove(enemyDeck, 1)
  end
end

--reveal all cards in a given lane table
function revealCards(laneTable)
  for _, lane in ipairs(laneTable) do
    for _, card in ipairs(lane.cards) do
      if card.state == CARD_STATES.FLIPPED then
        card:onReveal()
        card.state = CARD_STATES.IN_PLAY
      end
    end
  end
end



