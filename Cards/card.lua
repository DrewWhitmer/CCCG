CardClass = {}


CARD_WIDTH = 70
CARD_HEIGHT = 95


CARD_STATES = {
  IN_DECK = 1,
  IN_HAND = 2,
  GRABBED = 3,
  FLIPPED = 4,
  IN_PLAY = 5,
  DISCARD = 6
}


function CardClass:new(cost, power, name, desc, state, pos)
  local card = {}
  local metatable = {__index = CardClass}
  setmetatable(card, metatable)
  card.cost = cost
  card.power = power
  card.name = name
  card.desc = desc
  card.state = state
  card.lane = 0
  card.pos = pos
  
  return card
  
end

function CardClass:update()
  --follow the mouse if the card is grabbed
  if self.state == CARD_STATES.GRABBED then
    self.pos = Vector(grabber.currentMousePos.x - CARD_WIDTH/2, grabber.currentMousePos.y - CARD_HEIGHT/2)
  end
  

end

function CardClass:draw()
  --if card is flipped or in the deck, draw it face down
  if self.state == CARD_STATES.IN_DECK or self.state == CARD_STATES.FLIPPED then 
    love.graphics.setColor(COLORS.WHITE)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, CARD_WIDTH, CARD_HEIGHT)
    return
  end
  
  --make the base card
  love.graphics.setColor(COLORS.WHITE)
  love.graphics.rectangle("fill", self.pos.x, self.pos.y, CARD_WIDTH, CARD_HEIGHT)
  --display card info
  love.graphics.setColor(COLORS.BLACK)
  love.graphics.print(self.cost, self.pos.x + 2, self.pos.y)
  if self.power < 10 then
    love.graphics.print(self.power, self.pos.x + CARD_WIDTH - 10, self.pos.y)
  else
    love.graphics.print(self.power, self.pos.x + CARD_WIDTH - 15, self.pos.y)
  end
  
  love.graphics.print(self.name, self.pos.x + CARD_WIDTH/2, self.pos.y + CARD_HEIGHT/2, 0, 1, 1, love.graphics.getFont():getWidth(self.name)/2)
  love.graphics.print(self.desc, self.pos.x + CARD_WIDTH/2, self.pos.y + CARD_HEIGHT/2 + 20, 0, 0.5, 0.5, love.graphics.getFont():getWidth(self.desc)/2)
end


function CardClass:onReveal()
  return
end

--subclass sandbox

--adds given power to all cards in given lane
function CardClass:addPowerToLane(pow, lane)
  for _, card in ipairs(lane.cards) do
    card.power = card.power + pow
  end
end

--sets given power to all cards in given lane
function CardClass:setPowerInLane(pow, lane)
  for _, card in ipairs(lane.cards) do
    card.power = pow
  end
end

--returns the card with the most power in a given lane
function CardClass:getStrongestHere()
  local strongestCard = self.lane.cards[1]
  for _, card in ipairs(self.lane.cards) do
    if card.power > strongestCard.power then
      strongestCard = card
    end
  end
  
  for _, card in ipairs(self.lane.adj.cards) do
    if card.power > strongestCard.power then
      strongestCard = card
    end
  end
  
  return strongestCard
end

--returns two random cards
function CardClass:getTwoCards()
  if #self.hand.cards <= 2 then
    return self.hand.cards
  end
  
  local randIndex1 = math.random(#self.hand.cards)
  local randIndex2 = math.random(#self.hand.cards)
  --makes sure that it doesn't return two of the same card
  while randIndex2 == randIndex1 do
    randIndex2 = math.random(#self.hand.cards)
  end
  
  return {self.hand.cards[randIndex1], self.hand.cards[randIndex2]}
end


-- All the different kinds of cards --
require "Cards/woodCow"
require "Cards/minotaur"
require "Cards/pegasus"
require "Cards/titan"
require "Cards/ares"
require "Cards/artemis"
require "Cards/hera"
require "Cards/demeter"
require "Cards/hercules"
require "Cards/dionysus"
require "Cards/midas"
require "Cards/aphrodite"
require "Cards/heph"
require "Cards/pandora"















