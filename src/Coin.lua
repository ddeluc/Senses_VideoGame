--[[
	GD50 Final Assignment
	Senses

	-- Coin Class --
	Coins that are collected will allow the player
	to upgrade their senses or win the game

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

Coin = Class{__includes = BaseState}

function Coin:init(x, y)
	-- position
	self.x = (x - 1) * TILE_SIZE + 4
	self.y = (y - 1) * TILE_SIZE + 4

	-- rotation animation for the coin
	self.animation = Animation {
		frames = {1, 2, 3, 2},
		interval = 0.1
	}

	-- dimensions of the coin
	self.width = 8
	self.height = 8

	-- check to see if the coin was collected
	self.collected = false
end

function Coin:update(dt)
	self.animation:update(dt)	
end

function Coin:render()
	if not self.collected then
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(gTextures['coin'], gFrames['coin'][self.animation:getCurrentFrame()], self.x, self.y)
	end
end