--Pegasus
PegasusClass = CardClass:new(
  3,
  5,
  "Pegasus",
  "",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
  )
function PegasusClass:new(pos)
  local pegasus = {}
  local metadata = {__index = PegasusClass}
  setmetatable(pegasus, metadata)
  
  pegasus.pos = pos
  
  return pegasus
end