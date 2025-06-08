--Dionysus
DionysusClass = CardClass:new(
  2,
  3,
  "Dionysus",
  "When Revealed:\nGains +2 power for\neach of your other\ncards here.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function DionysusClass:new(pos)
  local dionysus = {}
  local metadata = {__index = DionysusClass}
  setmetatable(dionysus, metadata)
  
  dionysus.pos = pos
  
  return dionysus
end

function DionysusClass:onReveal()
  self.power = self.power + (2 * (#self.lane.cards - 1))
end
