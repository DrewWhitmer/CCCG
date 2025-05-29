LaneClass = {}

LANE_WIDTH = CARD_WIDTH * 2 + CARD_OFFSET*3
LANE_HEIGHT = CARD_HEIGHT * 2 + CARD_OFFSET*3

function LaneClass:new(xPos, yPos, hand)
  local lane = {}
  local metatable = {__index = LaneClass}
  setmetatable(lane, metatable)
  
  lane.pos = Vector(xPos, yPos)
  lane.hand = hand
  lane.cards = {}
  lane.adj = nil
  
  return lane
end

function LaneClass:update()
  return
end

function LaneClass:draw()
  love.graphics.setColor(COLORS.BLACK)
  love.graphics.rectangle("line", self.pos.x, self.pos.y, LANE_WIDTH, LANE_HEIGHT)
end

function LaneClass:addCard(card)
  --makes sure lane can't get too full
  if #self.cards > 3 then
    return
  end
  
  --adds the card and set's it state to flipped
  table.insert(self.cards, card)
  table.insert(revealQueue, card)
  card.state = CARD_STATES.FLIPPED
  card.lane = self
  
  --set the card's position
  if #self.cards > 2 then
    card.pos.y = self.pos.y + CARD_OFFSET * 2 + CARD_HEIGHT
  else
    card.pos.y = self.pos.y + CARD_OFFSET
  end
  
  if #self.cards % 2 == 0 then
    card.pos.x = self.pos.x + CARD_OFFSET * 2 + CARD_WIDTH
  else
    card.pos.x = self.pos.x + CARD_OFFSET
  end
end

function LaneClass:getTotalPower()
  local pow = 0
  for _, card in ipairs(self.cards) do
    pow = pow + card.power
  end
  return pow
end
