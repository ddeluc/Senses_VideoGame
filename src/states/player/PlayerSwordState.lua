--[[
	GD50 Final Assignment
	Senses
	
	-- Player Attack State --

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

PlayerSwordState = Class{__includes = BaseState}

function PlayerSwordState:init(player)
	-- player reference
	self.player = player

	-- direction reference
	local direction = self.player.direction

	-- hitbox position and dimensions
	local hitboxX, hitboxY, hitboxWidth, hitboxHeight

	-- set the attack animation
	self.animation = Animation {
		frames = {1, 2, 1},
		interval = 0.1,
		looping = false
	}

	-- set the animation to the player's current animation
	self.player.currentAnimation = self.animation

	-- adjust the higtbox to follow the direction of the player
	if direction == 'left' then
		hitboxWidth = 8
		hitboxHeight = 16
		hitboxX = self.player.x - hitboxWidth
		hitboxY = self.player.y + 2
	else
		hitboxWidth = 8
		hitboxHeight = 16
		hitboxX = self.player.x + self.player.width
		hitboxY = self.player.y + 2
	end

	-- instantiate the hitbox
	self.swordHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
end

function PlayerSwordState:enter(def)
	self.player.texture = def.texture
	gSounds['punch']:play()

	self.player.currentAnimation:refresh()
end

function PlayerSwordState:update(dt)
	-- check to see if the player hit the enemy, if so, destroy it
	for k, ghost in pairs(self.player.level.ghosts) do
		if ghost:collides(self.swordHitbox) then
			gSounds['ghostKilled']:play()
			ghost.dead = true
		end
	end

	-- allow the sword animation play once before changing back to idle state
	if self.player.currentAnimation.timesPlayed > 0 then
		self.player.currentAnimation.timesPlayed = 0
		self.player:change('idle', {
			texture = 'player_movement'
		})
	end
end