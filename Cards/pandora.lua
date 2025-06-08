--Pandora
PandoraClass = CardClass:new(
  6,
  13,
  "Pandora",
  "When Revealed:\nIf no ally cards\nare here, lower\nthis card's power\nby 5.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function PandoraClass:new(pos)
  local pandora = {}
  local metadata = {__index = PandoraClass}
  setmetatable(pandora, metadata)
  
  pandora.pos = pos
  
  return pandora
end

function PandoraClass:onReveal()
  if #self.lane.cards == 1 then
    self.power = self.power - 5
  end
end