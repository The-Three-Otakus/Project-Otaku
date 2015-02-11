function updatePhysics(entity,dt)
	if entity.x_velocity < 0 then
		entity.x_velocity = entity.x_velocity+math.min(dt*1600,math.abs(entity.x_velocity))
	elseif player.x_velocity > 0 then
		entity.x_velocity = entity.x_velocity-math.min(dt*1600,math.abs(entity.x_velocity))
	end
	
	entity.y_velocity = entity.y_velocity+(gravity*dt)
	
	local x,y,cols,len = world:move(entity,entity.x + (entity.x_velocity*dt),entity.y + (entity.y_velocity*dt))
	entity.x = x
	entity.y = y
	
	entity.onground = false
	
	for i=1, len do
		if cols[i].normal.y == -1 then
			entity.onground = true
			entity.y_velocity = 0
			break
		end
	end
end
