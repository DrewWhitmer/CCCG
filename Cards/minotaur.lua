--Minotaur
MinotaurClass = CardClass:new(
  5,
  9,
  "Minotaur",
  "",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
  )
function MinotaurClass:new(pos)
  local minotaur = {}
  local metadata = {__index = MinotaurClass}
  setmetatable(minotaur, metadata)
  
  minotaur.pos = pos
  
  return minotaur
end