--Demeter
DemeterClass = CardClass:new(
  1,
  1,
  "Demeter",
  "When Revealed:\nBoth players\ndraw a card.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function DemeterClass:new(pos)
  local demeter = {}
  local metadata = {__index = DemeterClass}
  setmetatable(demeter, metadata)
  
  demeter.pos = pos
  
  return demeter
end

function DemeterClass:onReveal()
  drawCards()
end
