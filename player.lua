require "animate"

function createPlayer()
	local player = {
		x = 300,
		y = 300,
		y_velocity = 0,
		x_velocity = 0,
		jump_height = 5,
		walk_speed = 35,
		sp=100,
		image = love.graphics.newImage("mattmain.png"),
		TPose = {
			root = {name = "root", length = 15, rotation = 0, skin = {file="matt/torso.png",x=7,y=0}, children = {
					{name = "head", length = 17, rotation = math.rad(-180), skin = {file="matt/head.png",x=9,y=9,rotation=math.pi,ppx=0,ppy=4}},
					{name = "chestbone1", length = 6, rotation = math.pi/2, at=1/15, children = {
							{name = "left_arm", length = 9, rotation = math.rad(-90), skin = {file="matt/leftarm.png",x=4,y=0},at = 1},
						}
					},
					{name = "chestbone2", length = 7, rotation = -math.pi/2, at=1/15, before = true, children = {
							{name = "right_arm", length = 8, rotation = math.rad(90), skin = {file="matt/rightarm.png",x=4,y=0},at = 1},
						}
					},
					{name = "hip1", length = 4, rotation = math.pi/2, at = 1, children = {
							{name = "left_leg", length = 11, rotation = math.rad(-90), skin = {file="matt/leftleg.png",x=2,y=0}, at = 1},
						}
					},
					{name = "hip2", length = 4, rotation = -math.pi/2, at = 1, children = {
							{name = "right_leg", length = 11, rotation = math.rad(90), skin = {file="matt/rightleg.png",x=2,y=0}, at = 1},
						}
					},
				}
			},
			animations = {
				raise_arms = {
					{duration = 1, data = {
						left_arm = {rotation = math.rad(-90)},
						--left_arm_lower = {rotation = math.rad(25)},
						right_arm = {rotation = math.rad(90)},
						--right_arm_lower = {rotation = math.rad(-25)}
					}},
					{duration = 1, data = {
						left_arm = {rotation = math.rad(-80)},
						--left_arm_lower = {rotation = math.rad(0)},
						right_arm = {rotation = math.rad(80)},
						--right_arm_lower = {rotation = math.rad(0)}
					}},
				}
			}
		}
	}
	world:add(player,player.x,player.y,player.image:getWidth()*1.75,player.image:getHeight()*1.75)
	
	addEntity(player)
	
	initPose(player.TPose)
	
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
		--love.graphics.draw(player.image, player.x,player.y,0,1.75)
		love.graphics.push()
		love.graphics.translate(player.x+player.image:getWidth()/2,player.y+player.image:getHeight()/2)
		love.graphics.scale(1.75,1.75)
		drawBone(player.TPose)
		love.graphics.pop()
	end
	
	return player
end
