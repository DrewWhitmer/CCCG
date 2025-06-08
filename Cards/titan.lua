--Titan
TitanClass = CardClass:new(
  6,
  12,
  "Titan",
  "",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
  )
function TitanClass:new(pos)
  local titan = {}
  local metadata = {__index = TitanClass}
  setmetatable(titan, metadata)
  
  titan.pos = pos
  
  return titan
end