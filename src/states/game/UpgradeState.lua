--[[
	GD50 Final Assignment
	Senses

	-- Upgrade State --
	This State spawns a menu where the player chooses which
	sense to upgrade once they collect a coin.

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

UpgradeState = Class{__includes = BaseState}

function UpgradeState:init(player)
	-- reference to the player
	self.player = player

	-- highlighted option
	self.highlighted = 1
end

function UpgradeState:update(dt)
	if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
		self.highlighted = self.highlighted * -1
	end

	-- if the player chose to upgrade vision, increment the visible radius,
	-- and if the player chose to upgrade hearing, increase the frequency
	if love.keyboard.wasPressed('return') then
		gSounds['upgrade']:play()

		if self.highlighted == 1 then
			self.player.radius = self.player.radius + 15
		elseif self.highlighted == -1 then
			self.player.frequency = self.player.frequency - 2
			self.player:upgradeHearing()
		end

		gStateStack:pop()
	end
end

function UpgradeState:render()
	love.graphics.setColor(0, 0, 0, 0.75)
	love.graphics.rectangle("fill", new_origin, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

	love.graphics.setColor(1, 1, 1, 0.75)
	love.graphics.printf('You have found a coin! You can now upgrade one of your senses. Use the arrow keys to toggle between the two options.', gFonts['small'],
		math.floor(new_origin) + VIRTUAL_WIDTH / 4, VIRTUAL_HEIGHT / 2 - 25, VIRTUAL_WIDTH / 2, 'center')

	love.graphics.setColor(1, 1, 1, 1)

	if self.highlighted == 1 then
		love.graphics.setColor(0, 1, 0, 1)
	end

	love.graphics.printf("VISION", gFonts['medium'], math.floor(new_origin), VIRTUAL_HEIGHT / 2 + 25, VIRTUAL_WIDTH, 'center')

	if self.highlighted == -1 then
		love.graphics.setColor(0, 1, 0, 1)
	else
		love.graphics.setColor(1, 1, 1, 1)
	end

	love.graphics.printf("HEARING", gFonts['medium'], math.floor(new_origin), VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH, 'center')


end