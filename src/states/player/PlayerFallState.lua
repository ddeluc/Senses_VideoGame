--[[
	GD50 Final Assignment
	Senses
	
	-- Player Fall State --

	Author: Dante Deluca
	dantedeluca3219@icloud.com		
]]

PlayerFallState = Class{__includes = BaseState}

function PlayerFallState:init(player)
	-- player reference
	self.player = player
	
	-- set animation for falling
	self.animation = Animation {
		frames = {10},
		interval = 1
	}

	-- set it as the player's current animation
	self.player.currentAnimation = self.animation
end

function PlayerFallState:enter(def)
	-- determine the direction the player will face when falling
	self.direction = def.direction
end

function PlayerFallState:update(dt)
	-- adjust the players dy by adding gravity for each frame
	self.player.dy = self.player.dy + GRAVITY

	-- update player position
	self.player.y = self.player.y + self.player.dy * dt
	self.player.x = self.player.x + self.player.dx * self.direction * dt

	-- get the tiles that are below us
	local bottomLeftTile = self.player.level:pointToTile(self.player.x + 1, self.player.y + self.player.height)
	local bottomRightTile = self.player.level:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

	-- check to see if teh tiles below us are collidable, if not, continue to fall, if so, collide with ground
	if (bottomLeftTile and bottomRightTile) and (bottomRightTile.solid or bottomLeftTile.solid) then
		self.player.dy = 0
		self.player:change('idle', {
			texture = self.player.texture,
			fall = true
		})
		self.player.y = (bottomLeftTile.y - 1) * TILE_SIZE - self.player.height
	end

	-- check for collisions to the left and right depending
	-- on the player's direction
	if self.direction == 1 then
		self.player:checkRightCollisions()
	elseif self.direction == -1 then
		self.player:checkLeftCollisions()
	end
end