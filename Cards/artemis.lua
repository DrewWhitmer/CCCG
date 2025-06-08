--Artemis
ArtemisClass = CardClass:new(
  4,
  4,
  "Artemis",
  "When Revealed:\nGain +5 power if\nthere is exactly\none enemy card here.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function ArtemisClass:new(pos)
  local artemis = {}
  local metadata = {__index = ArtemisClass}
  setmetatable(artemis, metadata)
  
  artemis.pos = pos
  
  return artemis
end

function ArtemisClass:onReveal()
  if #self.lane.adj.cards == 1 then
    self.power = self.power + 5
  end
end