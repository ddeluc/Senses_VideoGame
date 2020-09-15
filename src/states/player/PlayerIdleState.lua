--[[
	GD50 Final Assignment
	Senses
	
	-- Player Idle State --

	Author: Dante Deluca
	dantedeluca3219@icloud.com	
]]

PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
	-- reference to player
	self.player = player

	-- set the walking animation
	self.animation = Animation {
		frames = {1},
		interval = 1
	}

	-- set the animation as the the player's current animation
	self.player.currentAnimation = self.animation
end

function PlayerIdleState:enter(def)
	self.player.texture = def.texture
	local fall = def.fall or false

	if fall then
		gSounds['fall']:play()
	end
end

function PlayerIdleState:update(dt)
	-- if the player is still moving, decelerate the player
	-- in the appropriate direction until they stop
	if self.player.dx ~= 0 then
		self.player.dx = math.max(self.player.dx - self.player.acceleration, 0)

		-- check for left and right collisions if they are decelerating
		if self.player.direction == 'right' then			
			self.player.x  = self.player.x + self.player.dx * dt
			self.player:checkRightCollisions()
		else
			self.player.x  = self.player.x - self.player.dx * dt
			self.player:checkLeftCollisions()
		end
	end

	-- get the tiles below the player
	local bottomLeftTile = self.player.level:pointToTile(self.player.x + 1, self.player.y + self.player.height)
	local bottomRightTile = self.player.level:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

	-- if the tiles are not collidable then fall
	if (bottomLeftTile and bottomRightTile) and (not bottomRightTile.solid and not bottomLeftTile.solid) then
		self.player.dy = 0
		self.player:change('fall', {
			gravity = GRAVITY,
			direction = self.player.direction == 'right' and 1 or -1
		})
	end

	-- check for input to change to the walking state
	if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
		self.player:change('walk')
	end

	if love.keyboard.wasPressed('up') then
		self.player:change('jump', {
			dx = self.player.dx,
			direction = self.player.direction
		})
	end

	-- check if player enters attack state
	if love.keyboard.wasPressed('space') then
		self.player:change('sword', {
			texture = 'player_combat'
		})
	end
end