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
  love.graphics.print(self.power, self.pos.x + CARD_WIDTH - 10, self.pos.y)
  love.graphics.print(self.desc, self.pos.x + CARD_WIDTH/2, self.pos.y + CARD_HEIGHT/2)
  love.graphics.print(self.desc, self.pos.x + CARD_WIDTH/2, self.pos.y + CARD_HEIGHT/2 + 20)
end


function CardClass:onReveal()
  return
end