require "vector"

GrabberClass = {}

function GrabberClass:new()
  local grabber = {}
  local metadata = {__index = GrabberClass}
  setmetatable(grabber, metadata)
  
  grabber.previousMousePos = nil
  grabber.currentMousePos = nil
  
  grabber.grabPos = nil
  
  return grabber
end

function GrabberClass:update()
  self.currentMousePos = Vector(love.mouse.getX(), love.mouse.getY())
end

function GrabberClass:grab()
  self.grabPos = self.currentMousePos
  
  --searches for a card on the mouse position, if that card is in the players hand, grab it
  for _, card in ipairs(cardTable) do
    if self.grabPos.x >= card.pos.x and self.grabPos.x <= card.pos.x + CARD_WIDTH and self.grabPos.y >= card.pos.y and self.grabPos.y <= card.pos.y + CARD_HEIGHT and card.state == CARD_STATES.IN_HAND then
      card.state = CARD_STATES.GRABBED
      return card
    end
  end
end

function GrabberClass:release(grabbedCard)
  self.grabPos = nil
  
  if grabbedCard == nil then
    return
  end
  
  --searches for a lane to put the card into
  for index, lane in ipairs(playerLaneTable) do
    if self.currentMousePos.x >= lane.pos.x and self.currentMousePos.x <= lane.pos.x + LANE_WIDTH and self.currentMousePos.y >= lane.pos.y and self.currentMousePos.y <= lane.pos.y + LANE_HEIGHT and grabbedCard.cost <= playerMana then
      lane:addCard(grabbedCard)
      playerHand:remove(grabbedCard)
      return
    end
  end
  
  grabbedCard.state = CARD_STATES.IN_HAND
end