--Wooden Cow
WoodCowClass = CardClass:new(
  1,
  1,
  "Wooden\nCow",
  "",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
  )
function WoodCowClass:new(pos)
  local woodCow = {}
  local metadata = {__index = WoodCowClass}
  setmetatable(woodCow, metadata)
  
  woodCow.pos = pos
  
  return woodCow
end