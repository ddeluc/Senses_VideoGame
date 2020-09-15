--[[
	GD50 Final Assignment
	Senses
	
	-- Win State --
	This state fades the game to white and displays text

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

WinState = Class{__includes = BaseState}

function WinState:init( ... )
	self.opacity = 0
	new_origin = 0

	Timer.tween(2, {[self] = {opacity = 1}})

	gStateStack:stopMusic()
	gStateStack:changeMusic('win')
	gStateStack:playMusic()
end

function WinState:update( ... )
	if love.keyboard.wasPressed('return') then
		gStateStack:push(FadeInState({
			r = 0, g = 0, b = 0
		}, 1,
		function()
			gStateStack:pop()

			gStateStack:push(StartState())
			gStateStack:push(FadeOutState({
				r = 0, g = 0, b = 0
			}, 1,
			function() end))
		end))
	end
end

function WinState:render()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.rectangle("fill", new_origin, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

	love.graphics.setColor(0, 0, 0, self.opacity)
	love.graphics.printf("YOU ESCAPED", gFonts['large'], math.floor(new_origin), VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')

	love.graphics.printf("Press Enter", gFonts['small'], math.floor(new_origin), VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

end