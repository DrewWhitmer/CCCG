--Hera
HeraClass = CardClass:new(
  4,
  6,
  "Hera",
  "When Revealed:\nGive cards in your\nhand +1 power.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function HeraClass:new(pos)
  local hera = {}
  local metadata = {__index = HeraClass}
  setmetatable(hera, metadata)
  
  hera.pos = pos
  
  return hera
end

function HeraClass:onReveal()
  self:addPowerToLane(1, self.lane)
end