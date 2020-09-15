--[[
	GD50 Final Assignment
	Senses

	-- Tile Class

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

Tile = Class{}

function Tile:init(x, y, quad, solid, visible)
	-- tile position on the level grid
	self.x = x
	self.y = y

	-- dimensions of tile
	self.height = TILE_SIZE
	self.width = TILE_SIZE

	-- quad that it will be drawn as
	self.quad = quad

	-- check to see if the tile is collidable
	self.solid = solid
	self.visible = visible	
end

function Tile:render()
	if self.visible then
		love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.quad],
			(self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
	end
end