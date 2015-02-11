function createPlayer()
	local player = {
		x = 300,
		y = 300,
		y_velocity = 0,
		x_velocity = 0,
		jump_height = 5,
		walk_speed = 35,
		sp=100,
		image = love.graphics.newImage("mattmain.png") 
	}
	world:add(player,player.x,player.y,player.image:getWidth()*1.75,player.image:getHeight()*1.75)
	
	function player.update(dt)
		if love.keyboard.isDown("left") then
			player.x_velocity = player.x_velocity-player.walk_speed
		elseif love.keyboard.isDown("right") then
			player.x_velocity = player.x_velocity+player.walk_speed
		end
		
		if player.onground and love.keyboard.isDown("up"," ") then
			player.y_velocity = -(player.jump_height/dt)
		end
		
		updatePhysics(player,dt)
		
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
	
	function player.draw()
		love.graphics.draw(player.image, player.x,player.y,0,1.75)
	end
	
	return player
end
