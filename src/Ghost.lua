--[[
	GD50 Final Assignment
	Senses

	-- Ghost Class --
	Ghosts in this game are programmed to be deadly upon interaction
	and will follow the player around if the are in close proximity 
	with the player. Each ghost has a radius and if the player is evaluated
	to be within this radius the ghost will begin following the player
	until the player has escaped.

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

Ghost = Class{__includes = Entity}

function Ghost:init(def)
	-- position
	self.x = def.x
	self.y = def.y

	-- position origin for fixed path
	self.oy = self.y
	self.ox = self.x

	-- position target to follow
	self.targetx = 0
	self.targety = 0

	-- visibity of ghost in darkness
	self.blipOpacity = 0

	-- ghost promity radius
	self.radius = 125

	-- x and y velocity
	self.dx = 0
	self.dy = 0

	-- ghost dimesions
	self.width = 16	
	self.height = 20

	-- ghost movement speed
	self.speed = 10

	-- reference to level
	self.level = def.level

	-- follow state
	self.follow = false

	-- timer for movement function
	self.counter = def.counter

	-- check if ghost has been killed
	self.dead = false
end

function Ghost:update(dt)
	-- independent variable for ghost movemnt
	self.counter = (self.counter + 1 * dt) % 100

	-- distance measured from ghost to player
	local x_distance = self.targetx - self.x
	local y_distance = self.targety - self.y

	local distance = math.sqrt((x_distance * x_distance) + (y_distance * y_distance))

	-- checking if the ghost should follow the player
	if distance < self.radius then
		self.follow = true
	else 
		self.follow = false
	end

	-- if the ghost is not to follow the player then the ghost should follow a set path (figure-8)
	if not self.follow then
		self.dx = TILE_SIZE * 3 * math.cos(self.counter)
		self.dy = - 2.2 * TILE_SIZE * math.sin(2.2 * self.counter)
	else
		-- create unit vector and multiply by the ghosts movement speed
		self.dx = (x_distance / distance) * self.speed
		self.dy = (y_distance / distance) * self.speed

		self.oy = self.y
		self.ox = self.x
	end

	-- update the ghosts x and y position depending on its behaviour
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
	
end

--[[
	This function updates the target based on the
	player's position.
]]
function Ghost:updatePlayerPosition(x, y)
	self.targetx = x
	self.targety = y
end

--[[
	This function was take from assignment 4 50 Bros
	Checks if the ghost is colliding with a certain entity
]]
function Ghost:collides(entity)
	return not (self.x > entity.x + entity.width or entity.x > self.x + self.width or
				self.y > entity.y + entity.height or entity.y > self.y + self.height)
end

function Ghost:render()
	if not self.dead then
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(gTextures['ghost'], gFrames['ghost'][1], math.floor(self.x), math.floor(self.y))
		love.graphics.setColor(1, 1, 1)
	end
end