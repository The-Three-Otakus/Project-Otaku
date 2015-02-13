worlds = worlds or {}

function worlds.createTreeLand()
	world = bump.newWorld()
	entities = {}
	gravity = 450
	
	local ground = {
		image = love.graphics.newImage("worlds/treeland/background.png")
	}
	world:add(ground,50,520,ground.image:getWidth()*4.65,80*4.65)
	
	function ground.update(dt)
		
	end
	
	function ground.draw()
		love.graphics.draw(ground.image,50,0,0,4.65)
	end
	
	addEntity(ground)
end
