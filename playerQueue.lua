
PlayerQueue = {}

function PlayerQueue:new()
  local queue = {}
  local metadata = {__index = PlayerQueue}
  setmetatable(queue, metadata)
  
  queue.cards = {}
  
  return queue
end

function PlayerQueue:append(card)
  table.insert(self.cards, card)
  card.state = CARD_STATES.FLIPPED
  playerHand:remove(card)
end

function PlayerQueue:revealAll()
  for _, card in ipairs(self.cards) do
    card:onReveal()
    card.state = CARD_STATES.IN_PLAY
  end
end

function PlayerQueue:undo()
  if #self.cards < 1 then
    return
  end
  
  local undoCard = self.cards[#self.cards]
  for _, lane in ipairs(playerLaneTable) do
    for index, card in ipairs(lane.cards) do
      if card == undoCard and card.state == CARD_STATES.FLIPPED then
        table.remove(lane.cards, index)
        break
      end
    end
  end
  
  playerMana = playerMana + undoCard.cost
  playerHand:addCard(undoCard)
  table.remove(self.cards, #self.cards)
end