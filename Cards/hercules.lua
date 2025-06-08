--Hercules
HerculesClass = CardClass:new(
  3,
  4,
  "Hercules",
  "When Revealed:\nDoubles it's power\nif it's the\nstrongest card here.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function HerculesClass:new(pos)
  local hercules = {}
  local metadata = {__index = HerculesClass}
  setmetatable(hercules, metadata)
  
  hercules.pos = pos
  
  return hercules
end

function HerculesClass:onReveal()
  if self:getStrongestHere().power == self.power then
    self.power = self.power * 2
  end
end