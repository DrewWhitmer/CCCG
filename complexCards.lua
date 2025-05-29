-- COMPLEX CARDS --

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
  for _, card in ipairs(self.lane.hand.cards) do
    card.power = card.power + 1
  end
end

--Demeter
DemeterClass = CardClass:new(
  1,
  1,
  "Demeter",
  "When Revealed:\nBoth players\ndraw a card.",
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

function DemeterClass:onReveal()
  drawCards()
end

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
  for _, card in ipairs(self.lane.adj.cards) do
    card.power = card.power - 1
  end
end

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


