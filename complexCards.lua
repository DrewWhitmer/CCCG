-- COMPLEX CARDS --

--Ares
AresClass = CardClass:new(
  2,
  2,
  "Ares",
  "When Revealed: Gain +2 power for each enemy card here.",
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

function AresClass:OnReveal()
  self.power = self.power + (2 * #self.lane.adj.cards)
end

--Artemis
ArtemisClass = CardClass:new(
  4,
  4,
  "Artemis",
  "When Revealed: Gain +5 power if there is exactly one enemy card here.",
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

function ArtemisClass:OnReveal()
  if #self.lane.adj.cards == 1 then
    self.power = self.power + 5
  end
end

--Hera
HeraClass = CardClass:new(
  4,
  6,
  "Hera",
  "When Revealed: Give cards in your hand +1 power.",
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

function HeraClass:OnReveal()
  for _, card in ipairs(self.lane.hand.cards) do
    card.power = card.power + 1
  end
end

--Demeter
DemeterClass = CardClass:new(
  1,
  1,
  "Demeter",
  "When Revealed: Both players draw a card.",
  CARD_STATES.IN_DECK,
  Vector(0, 0)
)

function DemeterClass:new(pos)
  local demeter = {}
  local metadata = {__index = DemeterClass}
  setmetatable(demeter, metadata)
  
  demeter.pos = pos
  
  return demeter
end

function DemeterClass:OnReveal()
  drawCards()
end

--Hercules
HerculesClass = CardClass:new(
  3,
  4,
  "Hercules",
  "When Revealed: Doubles it's power if it's the strongest card here.",
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

function HerculesClass:OnReveal()
  if self:getStrongestHere().power == self.power then
    self.power = self.power * 2
  end
end

--Dionysus
DionysusClass = CardClass:new(
  2,
  3,
  "Dionysus",
  "When Revealed: Gains +2 power for each of your other cards here.",
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

function DionysusClass:OnReveal()
  self.power = self.power + (2 * (#self.lane.cards - 1))
end

--Midas
MidasClass = CardClass:new(
  5,
  3,
  "Midas",
  "When Revealed: Set ALL cards here to 3 power.",
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

function MidasClass:OnReveal()
  for _, card in ipairs(self.lane.cards) do
    card.power = 3
  end
  for _, card in ipairs(self.lane.adj.cards) do
    card.power = 3
  end
end

--Aphrodite
AphroditeClass = CardClass:new(
  5,
  5,
  "Aphrodite",
  "When Revealed: Lower the power of each enemy card here by 1.",
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

function AphroditeClass:OnReveal()
  for _, card in ipairs(self.lane.adj.cards) do
    card.power = card.power - 1
  end
end

--Hephaestus
HephClass = CardClass:new(
  5,
  5,
  "Hephaestus",
  "When Revealed: Lower the cost of two cards in your hand by 1.",
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

function HephClass:OnReveal()
  for _, card in ipairs(self:getTwoCards()) do
    card.cost = card.cost - 1
  end
end

--Pandora
PandoraClass = CardClass:new(
  6,
  13,
  "Pandora",
  "When Revealed: If no ally cards are here, lower this card's power by 5.",
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

function PandoraClass:OnReveal()
  if #self.lane.cards == 1 then
    self.power = self.power - 5
  end
end


