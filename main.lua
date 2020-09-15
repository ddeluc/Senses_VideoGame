--[[
	GD50 Final Assignment
	Senses

	Author: Dante Deluca
	dantedeluca3219@icloud.com

	Senses is a 2D platformer made in Love2D. In this game, the player
	must navigate through a dark map with only a radius of visibility
	(vision) that surrounds the player and a radar-like mechanic that
	indicates where there may be potential enemies (hearing). The player’s
	objective is to collect three special coins that will allow the player
	to completely restore their senses and escape the darkness. Throughout
	the game, there are floating ghosts that will follow the player. The
	player can attack the ghosts and destroy them, but if they get caught,
	it is game over. The level and the enemies are not randomly generated.

	*** CITATIONS (IF ANY) ***

	Most of the formating for the common lua scripts are
	modeled after the scripts used the "GD50 Introduction
	to Game Development" Course by Colton Ogden.
]]

require 'src/Dependencies'

new_origin = 0

function love.load()
	love.window.setTitle('Senses')
	love.graphics.setDefaultFilter('nearest', 'nearest')
	math.randomseed(os.time())

	-- setting up the window and reducing the resolution for a retro effect
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = true,
		vsync = true,
		resizable = false
	})

	-- setting up a canvas for the player's visible radius stencil
	push:setupCanvas({
		{ name = 'main_canvas' },
		{ name = 'stencil_canvas', stencil = true }
	})

	-- creating a stack of states to manage the game states
	gStateStack = StateStack()
	gStateStack:push(StartState())

	-- keyboard array to store input
	love.keyboard.keysPressed = {}
end

function love.resize(w, h)
	push:resize(w, h)
end

-- keep track of the keys that have been pressed
function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end

	-- add to the table if true
	love.keyboard.keysPressed[key] = true
end

-- check if a certain key was pressed
function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end

function love.update(dt)
	-- update all the of timers that are in use
	Timer.update(dt)

	-- update the current game state atop the state stack
	gStateStack:update(dt)

	-- clear the key table after every frame
	love.keyboard.keysPressed = {}
end

function love.draw()
	push:start()

	-- render the current game state
	gStateStack:render()
	
	push:finish()
end

