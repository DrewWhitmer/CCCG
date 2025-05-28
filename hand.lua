HandClass = {}

function HandClass:new(xPos, yPos)
  local hand = {}
  local metatable = {__index = HandClass}
  setmetatable(hand, metatable)
  
  hand.pos = Vector(xPos, yPos)
  hand.cards = {}
  
  return hand
end

function HandClass:update()
  for index, card in ipairs(self.cards) do
    if card.state ~= CARD_STATES.GRABBED then
      card.pos = Vector(self.pos.x + (index - 1) * (CARD_WIDTH + CARD_OFFSET), self.pos.y)
    end
  end
end

function HandClass:draw()
  return
end

function HandClass:remove(cardToRemove)
  for index, card in ipairs(self.cards) do 
    if cardToRemove == card then
      table.remove(self.cards, index)
      playerMana = playerMana - cardToRemove.cost
      return
    end
  end
end

--only use for player hand, makes sure that player can pick up/see their own cards but not the enemy's
function HandClass:addCard(card)
  table.insert(self.cards, card)
  card.state = CARD_STATES.IN_HAND
end
