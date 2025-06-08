--Aphrodite
AphroditeClass = CardClass:new(
  5,
  5,
  "Aphrodite",
  "When Revealed:\nLower the power\nof each enemy card\nhere by 1.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function AphroditeClass:new(pos)
  local aphrodite = {}
  local metadata = {__index = AphroditeClass}
  setmetatable(aphrodite, metadata)
  
  aphrodite.pos = pos
  
  return aphrodite
end

function AphroditeClass:onReveal()
  self:addPowerToLane(-1, self.lane.adj)
end