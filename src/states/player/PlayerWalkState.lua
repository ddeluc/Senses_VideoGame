--[[
	GD50 Final Assignment
	Senses
	
	-- Player Walk State --

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

PlayerWalkState = Class{__includes = BaseState}

function PlayerWalkState:init(player)
	-- player reference
	self.player = player
	self.player.color = {0, 1, 0}

	-- set walking animation
	self.animation = Animation {
		frames = {1, 2},
		interval = 0.1
	}

	-- set the animation to the player's current animation
	self.player.currentAnimation = self.animation

	-- independent time variable for player acceleration
	self.time = 0
end

function PlayerWalkState:update(dt)
	-- increment time each frame
	self.time = self.time + 1

	-- if the player is not moving, go back to idle
	if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
		self.player:change('idle', {
			texture = self.player.texture
		})
	else

		-- get the tiles below the player
		local bottomLeftTile = self.player.level:pointToTile(self.player.x + 1, self.player.y + self.player.height)
		local bottomRightTile = self.player.level:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

		-- Check to see if the tiles are collidable
		if (bottomLeftTile and bottomRightTile) and (not bottomRightTile.solid and not bottomLeftTile.solid) then
			self.player.dy = 0
			self.player:change('fall', {
				dx = self.player.dx,
				gravity = GRAVITY,
				direction = self.player.direction == 'right' and 1 or -1
			})
		elseif love.keyboard.isDown('left') then
			self.player.dx = math.min(self:acceleration(self.time), self.player.maxvelocity)
			self.player.x = self.player.x - self.player.dx * dt
			self.player.direction = 'left'
			self.player:checkLeftCollisions()
		elseif love.keyboard.isDown('right') then
			self.player.dx = math.min(self:acceleration(self.time), self.player.maxvelocity)
			self.player.x = self.player.x + self.player.dx * dt
			self.player.direction = 'right'
			self.player:checkRightCollisions()
		else
			self.player:change('idle', {
				texture = self.player.texture 
			})
		end
	end

	if love.keyboard.wasPressed('up') then
		self.player:change('jump', {
			dx = self.player.dx,
			direction = self.player.direction
		})
	end

	if love.keyboard.wasPressed('space') then
		self.player:change('sword', {
			texture = 'player_combat'
		})
	end
end

--[[
	fnction that determines the player's smooth acceleration
]]
function PlayerWalkState:acceleration(t)
	return math.atan(t / 15) * 60
end