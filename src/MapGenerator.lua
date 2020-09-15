--[[
	GD50 Final Assignment
	Senses

	-- MapGenerator Class --
	The generate function uses data created with
	the application 'Tiled' and creates two tilemaps.
	One for the solid ground and one for
	the non solid tiles beneath the ground.

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

MapGenerator = Class{}

function MapGenerator:generate()
	local map = require("src/map1b")

	local tiles = {}

	for i = 1, map.height do
		table.insert(tiles, {})
	end

	for y = 1, map.height do
		for x = 1, map.width do

			local index = (map.width * y) - (map.width - x)

			local q = map.layers[1].data[index]
			local sq = map.layers[2].data[index]

			if q ~= 0 then
				table.insert(tiles[y], Tile(x, y, q, false, true))
			elseif sq ~= 0 then
				table.insert(tiles[y], Tile(x, y, sq, true, true))
			else
				table.insert(tiles[y], Tile(x, y, 0, false, false))
			end
		end
	end

	level = Level(tiles, map.height, map.width)

	return level
end