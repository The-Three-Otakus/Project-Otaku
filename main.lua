bump = require "bump"

require "physics"
require "player"
require "worlds"

love.window.setMode(900,600)
function love.load()
	love.graphics.setBackgroundColor(100,149,237)
	love.graphics.setDefaultFilter("nearest","nearest")
	
	worlds.createTreeLand()
	player = createPlayer()
end

function love.update(dt)
	for i, v in pairs(entities) do
		v.update(dt)
	end
end

function love.draw()
	for _,items in pairs(world:getItems()) do
		local x,y,w,h = world:getRect(items)
		love.graphics.rectangle("fill",x,y,w,h)
	end
	for i, v in pairs(entities) do
		v.draw()
	end
end
