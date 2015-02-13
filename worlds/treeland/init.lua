worlds = worlds or {}

function worlds.createTreeLand()
	world = bump.newWorld()
	entities = {}
	gravity = 450
	
	local ground = loadClass "entity.Ground":new("worlds/treeland/background.png")
	addEntity(ground)
end
