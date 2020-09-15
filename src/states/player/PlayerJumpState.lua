--[[
	GD50 Final Assignment
	Senses
	
	-- Player Jump State --

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(player)
	-- player reference
	self.player = player

	-- set the jump animation
	self.animation = Animation {
		frames = {9},
		interval = 1
	}

	-- set the animation to the player's current animation
	self.player.currentAnimation = self.animation
end

function PlayerJumpState:enter(def)
	self.dx = def.dx
	self.player.dy = JUMP

	if def.direction == 'left' then
		self.direction = -1
	else
		self.direction = 1
	end
end

function PlayerJumpState:update(dt)
	-- adjust the dy by adding gravity each frame
	self.player.dy = self.player.dy + GRAVITY
	self.player.y = self.player.y + self.player.dy * dt

	self.player.x = self.player.x + self.dx * self.direction * dt

	-- get the tiles above the players head
    local tileLeft = self.player.level:pointToTile(self.player.x + 3, self.player.y)
    local tileRight = self.player.level:pointToTile(self.player.x + self.player.width - 3, self.player.y)

    -- change to fall state if there are tiles above the player's head
    -- check for left and right collisions depending on direction
    if (tileLeft and tileRight) and (tileLeft.solid or tileRight.solid) then
        self.player.dy = 0
        self.player:change('fall', {
        	direction = self.direction
        })
    elseif self.direction == -1 then
        self.player:checkLeftCollisions()
    elseif self.direction == 1 then
        self.player:checkRightCollisions()
    end

    -- trigger falling when the player is at the height of their jump
	if self.player.dy > 0 then
		self.player:change('fall', {
			direction = self.direction
		})
	end
end