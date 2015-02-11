bump = require "bump"
world = bump.newWorld()
love.window.setMode(900,600)
function love.load()
	love.graphics.setDefaultFilter("nearest","nearest")
	
	player = {
		x = 300,
		y = 300,
		y_velocity = 0,
		x_velocity = 0,
		jump_height = 15,
		walk_speed = 10,
		sp=100,
		image = love.graphics.newImage("mattmain.png") 
	}
	world:add(player,player.x,player.y,player.image:getWidth()*1.75,player.image:getHeight()*1.75)
	
	gravity = 450
	
	ground = {
		image = love.graphics.newImage("background.png")
	}
	world:add(ground,50,520,ground.image:getWidth()*4.65,80*4.65)
end

function love.update(dt)
	if love.keyboard.isDown("left") then
		player.x_velocity = player.x_velocity-player.walk_speed
	elseif love.keyboard.isDown("right") then
		player.x_velocity = player.x_velocity+player.walk_speed
	else
		if player.x_velocity < 0 then
			player.x_velocity = player.x_velocity+math.min(dt*800,math.abs(player.x_velocity))
		elseif player.x_velocity > 0 then
			player.x_velocity = player.x_velocity-math.min(dt*800,math.abs(player.x_velocity))
		end
	end
	
	player.y_velocity = player.y_velocity+(gravity*dt)
	
	if player.onground and love.keyboard.isDown("up"," ") then
		player.y_velocity = player.y_velocity - (player.jump_height/dt)
	end
	
	local x,y,cols,len = world:move(player,player.x + (player.x_velocity*dt),player.y + (player.y_velocity*dt))
	player.x = x
	player.y = y
	
	player.onground = false
	
	for i=1, len do
		if cols[i].normal.y == -1 then
			player.onground = true
			break
		end
	end
	if player.y > 650 then 
		world:update(player,300,300,player.image:getWidth()*1.75,player.image:getHeight()*1.75)
		player.x = 300
		player.y = 300
		player.y_velocity = 0
		player.x_velocity = 0
	else
		player.x = player.x
		player.y = player.y
		player.y_velocity = player.y_velocity
		player.x_velocity = player.x_velocity	
	end
end

function love.draw()
	for _,items in pairs(world:getItems()) do
		local x,y,w,h = world:getRect(items)
		love.graphics.rectangle("fill",x,y,w,h)
	end
	love.graphics.setBackgroundColor(100,149,237)
	love.graphics.draw(ground.image,50,0,0,4.65)
	love.graphics.draw(player.image, player.x,player.y,0,1.75)
end
