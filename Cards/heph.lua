--Hephaestus
HephClass = CardClass:new(
  5,
  5,
  "Hephaestus",
  "When Revealed:\nLower the cost of\ntwo cards in your\nhand by 1.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function HephClass:new(pos)
  local heph = {}
  local metadata = {__index = HephClass}
  setmetatable(heph, metadata)
  
  heph.pos = pos
  
  return heph
end

function HephClass:onReveal()
  for _, card in ipairs(self:getTwoCards()) do
    card.cost = card.cost - 1
  end
end