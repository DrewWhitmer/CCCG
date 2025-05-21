
CardClass = {}

require "vector"


CARD_WIDTH = 70
CARD_HEIGHT = 95

IMAGE_WIDTH = 140
IMAGE_HEIGHT = 190


function CardClass:new(cost, power, desc, state, pos)
  local card = {}
  local metatable = {__index = CardClass}
  setmetatable(card, metatable)
  card.cost = cost
  card.power = power
  card.desc = desc
  card.state = state
  card.pos = pos
  card.size = Vector(CARD_WIDTH, CARD_HEIGHT)
  
  return card
  
end

function CardClass:update()
  
end

function CardClass:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", self.pos.x, self.pos.y, CARD_WIDTH, CARD_HEIGHT)
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(self.cost, self.pos.x + 2, self.pos.y)
  love.graphics.print(self.power, self.pos.x + CARD_WIDTH - 10, self.pos.y)
  love.graphics.print(self.desc, self.pos.x + CARD_WIDTH/2, self.pos.y + CARD_HEIGHT/2)
end


