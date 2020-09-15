--[[
	GD50 Final Assignment
	Senses

	-- Start State --
	This state handles the visuals of the menu and its behaviour

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

StartState = Class{__includes = BaseState}

-- keep track of the selected option
local highlighted = 1

function StartState:init()
	-- reset the origin to 0
	new_origin = 0

	-- array of ghosts positions and intervals that will appear on the
	-- the screen as blips
	self.ghosts = {
		{x = 100, y = 100, opacity = 0, interval = 6},
		{x = 50, y = 75, opacity = 0, interval = 5},
		{x = 250, y = 25, opacity = 0, interval = 4},
		{x = 10, y = 160, opacity = 0, interval = 7},
		{x = 50, y = 170, opacity = 0, interval = 3},
		{x = 250, y = 160, opacity = 0, interval = 8}
	}

	-- set a unique timer for each ghost
	for k, ghost in pairs(self.ghosts) do
		Timer.every(ghost.interval, function()

			Timer.tween (0.5, {
				[ghost] = {opacity = 0.75}
			})
			:finish(function() 
				Timer.tween (0.5, {
					[ghost] = {opacity = 0}
				})
			end)
		end)
	end
 	
 	-- stop the previous music and play the menu music
	gStateStack:stopMusic()
	gStateStack:changeMusic('menu')
	gStateStack:playMusic()	
end

function StartState:update(dt)
	if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
		highlighted = highlighted * -1
	end

	if love.keyboard.wasPressed('return') then

		if highlighted == 1 then
			gStateStack:push(FadeInState({
				r = 0, g = 0, b = 0
			}, 1,
			function()
				gStateStack:pop()

				gStateStack:push(PlayState())
				gStateStack:push(FadeOutState({
					r = 0, g = 0, b = 0
				}, 1,
				function ()
					gStateStack:push(IntroductionState())
				end))
			end))
		else
			love.event.quit()
		end
	end
end

function StartState:render()
	love.graphics.clear(0, 0, 0, 1)

	for k, ghost in pairs(self.ghosts) do
		love.graphics.setColor(1, 1, 1, ghost.opacity)
		love.graphics.draw(gTextures['ghost'], gFrames['ghost'][2], ghost.x, ghost.y)
	end

	love.graphics.setColor(115/255, 29/255, 181/255, 1)	
	love.graphics.setFont(gFonts['large'])	
	love.graphics.printf('SENSES', 1, VIRTUAL_HEIGHT / 2 - 49, VIRTUAL_WIDTH, 'center')
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf('SENSES', 0, VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')

	if highlighted == 1 then
		love.graphics.setColor(115/255, 29/255, 181/255, 1)
	end

	love.graphics.setFont(gFonts['medium'])
	love.graphics.printf('PLAY', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

	if highlighted == -1 then
		love.graphics.setColor(115/255, 29/255, 181/255, 1)
	else
		love.graphics.setColor(1, 1, 1, 1)
	end

	love.graphics.printf('QUIT', 0, VIRTUAL_HEIGHT / 2 + 25, VIRTUAL_WIDTH, 'center')

end
