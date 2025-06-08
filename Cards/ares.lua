--Ares
AresClass = CardClass:new(
  2,
  2,
  "Ares",
  "When Revealed:\nGain +2 power for\neach enemy card\nhere.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
  )
function AresClass:new(pos)
  local ares = {}
  local metadata = {__index = AresClass}
  setmetatable(ares, metadata)
  
  ares.pos = pos
  
  return ares
end

function AresClass:onReveal()
  self.power = self.power + (2 * #self.lane.adj.cards)
end