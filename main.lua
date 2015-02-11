bump = require "bump"

require "physics"
require "player"

world = bump.newWorld()
love.window.setMode(900,600)
function love.load()
	love.graphics.setBackgroundColor(100,149,237)
	love.graphics.setDefaultFilter("nearest","nearest")
	
	player = createPlayer()
	
	gravity = 450
	
	ground = {
		image = love.graphics.newImage("background.png")
	}
	world:add(ground,50,520,ground.image:getWidth()*4.65,80*4.65)
end

function love.update(dt)
	player.update(dt)
end

function love.draw()
	for _,items in pairs(world:getItems()) do
		local x,y,w,h = world:getRect(items)
		love.graphics.rectangle("fill",x,y,w,h)
	end
	love.graphics.draw(ground.image,50,0,0,4.65)
	player.draw()
end
