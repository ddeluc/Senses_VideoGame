--[[
	GD50 Final Assignment
	Senses

	-- Player Class --

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

Player = Class{}

function Player:init(def)
	-- player position
	self.x = def.x
	self.y = def.y

	-- player x and y movement
	self.dx = 0
	self.dy = 0

	-- count for all collected coins
	self.coinCount = 0

	-- additional movement variables
	self.maxvelocity = 85
	self.acceleration = 5
	self.direction = 'right'

	-- player dimensions
	self.width = def.width
	self.height = def.height

	-- players visible radius
	self.radius = 50

	-- radius at which enimies will appear
	-- on the player's radar
	self.hearingRadius = 0

	-- frequency that ghosts will be heard
	self.frequency = 6
	self.radar = false

	-- texture for animation
	self.texture = def.texture

	-- current animation that will depend on
	-- player's state
	self.currentAnimation = Animation {
		frames = {1},
		interval = 1
	}

	-- player state machine
	self.stateMachine = def.stateMachine

	-- reference to level
	self.level = def.level

	-- check to see if player has died
	self.dead = false
	self:upgradeHearing()
end

function Player:update(dt)

	-- increment the hearing radius by dt
	if self.radar then
		self.hearingRadius = self.hearingRadius + DR * dt

		-- if the radius is greater than 500 destroy the circle
		-- and create a new one
		if self.hearingRadius > 500 then
			self.radar = false
		end
	end

	self.currentAnimation:update(dt)
	self.stateMachine:update(dt)
end

--[[
	function that spawns a moving circle depending
	on the frequency of the player's hearing
]]
function Player:upgradeHearing()
	Timer.every(self.frequency, function()
		if self.radar == false then
			self.hearingRadius = 0
			self.radar = true
		end
	end)
end


-- *** The following functions are taken from assignment 4 50 Bros ***

--[[
	The following two methods are used to detect solid tiles to the left and right
	of the player. If these tiles exist, the player will be bounded by the edge of 
	the tiles.
]]
function Player:checkLeftCollisions()
	-- get the left tiles
	local tileTopLeft = self.level:pointToTile(self.x + 1, self.y + 1)
	local tileBottomLeft = self.level:pointToTile(self.x + 1, self.y + self.height - 1)

	-- check if the left tiles are solid, if so, collide and prevent movement
	if (tileTopLeft and tileBottomLeft) and (tileTopLeft.solid or tileBottomLeft.solid) then
		self.x = (tileTopLeft.x - 1) * TILE_SIZE + tileTopLeft.width - 1
		self.dx = 0
	end
end

function Player:checkRightCollisions()
	local tileTopRight = self.level:pointToTile(self.x + self.width - 1, self.y + 1)
	local tileBottomRight = self.level:pointToTile(self.x + self.width - 1, self.y + self.height - 1)

	if (tileTopRight and tileBottomRight) and (tileBottomRight.solid or tileBottomRight.solid) then
		self.x = (tileTopRight.x - 1) * TILE_SIZE - self.width
		self.dx = 0
	end
end

function Player:collides(entity)
	return not (self.x > entity.x + entity.width or entity.x > self.x + self.width or
				self.y > entity.y + entity.height or entity.y > self.y + self.height)
end

function Player:change(stateName, params)
	self.stateMachine:change(stateName, params)
end

function Player:render()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
		math.floor(self.x) + 8, math.floor(self.y) + 10, 0, self.direction == 'right' and 1 or -1, 1, 8, 10)
	love.graphics.setColor(1, 1, 1, 1)


	love.graphics.setStencilTest()
end