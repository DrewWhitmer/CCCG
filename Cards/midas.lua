--Midas
MidasClass = CardClass:new(
  5,
  3,
  "Midas",
  "When Revealed:\nSet ALL cards here\nto 3 power.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function MidasClass:new(pos)
  local midas = {}
  local metadata = {__index = MidasClass}
  setmetatable(midas, metadata)
  
  midas.pos = pos
  
  return midas
end

function MidasClass:onReveal()
  self:setPowerInLane(3, self.lane)
  self:setPowerInLane(3, self.lane.adj)
end