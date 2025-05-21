-- Drew Whitmer
-- CMPM 121 - CCCG
-- 5/20/2025

io.stdout:setvbuf("no")

function love.load()
  require "vector"
  require "card"
  require "grabber"
  
  love.window.setTitle("When in Greece")
  love.window.setMode(960, 640)
  love.graphics.setBackgroundColor(0, 0.7, 0.2, 1)
  
  
  card = CardClass:new(1,1,1,1,Vector(100,100))
end

function love.update()
  
end

function love.draw()
  card:draw()
end