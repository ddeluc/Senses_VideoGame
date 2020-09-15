--[[
	GD50 Final Assignment
	Senses

	-- Death State --
	This state fades the game to black and displays text

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

DeathState = Class{__includes = BaseState}

function DeathState:init()
	-- screen opacity
	self.opacity = 0

	-- duration that it will fade
	self.time = 3

	-- x shear
	self.kx = 5

	gSounds['gameOver']:play()

	-- fade the screen to black and display text,
	-- once this is done, pop() the start state
	Timer.tween(self.time, {
		[self] = {opacity = 1,
		kx = 1}
	})
	:finish(function()

		Timer.after(self.time - 2, function()

			Timer.tween(self.time, {
				[self] = {opacity = 0,
				kx = 7}
			})
			:finish(function() 
				gStateStack:pop()
				gStateStack:pop()			

				gStateStack:push(StartState())
				gStateStack:push(FadeOutState({
					r = 0, g = 0, b = 0
				}, 1,
				function () end ))
			end)			
		end)
	end)
end

function DeathState:render()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle('fill', new_origin, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

	love.graphics.setColor(0.3, 0, 0, self.opacity)
	love.graphics.printf('YOU WERE CAUGHT!', gFonts['large'], math.floor(new_origin), VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center', 0, 1, 1, 0, self.kx)
end