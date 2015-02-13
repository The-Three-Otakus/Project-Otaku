local Base = Object:extend()

function Base:initialize(...)
	self.x = 0
	self.y = 0
	self.width = 10
	self.height = 10
	self.y_velocity = 0
	self.x_velocity = 0
	self.scale = 1
	self.onground = false
	self.hasGravity = true
	
	self:setupObject(...)
	self:addCollisionObjects()
	
	addEntity(self)
end

function Base:setupObject()
	
end

function Base:addCollisionObjects()
	world:add(self,self.x,self.y,self.width*self.scale,self.height*self.scale)
end

function Base:updatePhysics(dt)
	if self.x_velocity < 0 then
		self.x_velocity = self.x_velocity+math.min(dt*1600,math.abs(self.x_velocity))
	elseif player.x_velocity > 0 then
		self.x_velocity = self.x_velocity-math.min(dt*1600,math.abs(self.x_velocity))
	end
	
	if self.hasGravity then
		self.y_velocity = self.y_velocity+(gravity*dt)
	end
	
	local x,y,cols,len = world:move(self,self.x + (self.x_velocity*dt),self.y + (self.y_velocity*dt))
	self.x = x
	self.y = y
	
	self.onground = false
	
	for i=1, len do
		if cols[i].normal.y == -1 then
			self.onground = true
			self.y_velocity = 0
			break
		end
	end
end

function Base:update(dt)
	self:updatePhysics(dt)
end

function Base:draw()
	
end

return Base
