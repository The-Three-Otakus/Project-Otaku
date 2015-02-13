local Ground = loadClass "entity.Base":extend()

function Ground:setupObject(imagefile)
	self.x = 300
	self.y = 300
	self.jump_height = 5
	self.walk_speed = 35
	self.sp = 100
	self.scale = 4.65
	self.image = love.graphics.newImage(imagefile)
end

function Ground:addCollisionObjects()
	world:add(self,50,520,self.image:getWidth()*4.65,80*4.65)
end

function Ground:update(dt)
	
end

function Ground:draw()
	love.graphics.draw(self.image,50,0,0,4.65)
end

return Ground
