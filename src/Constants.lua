--[[
	GD50 Final Assignment
	Senses

	-- constants --

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 180

TILE_SIZE = 16

GRAVITY = 7
JUMP = -175
DR = 500

ghostPositions = {
	{15, 6, 10},
	{30, 7, 21},
	{40, 4, 46},
	{55, 6, 8},
	{60, 5, 75},
	{65, 7, 56}
}

coinPositions = {
	{4, 12},
	{2, 29},
	{4, 65}
}

CANVAS = love.graphics.newCanvas(1280, 720)
