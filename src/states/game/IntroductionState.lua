--[[
	GD50 Final Assignment
	Senses

	-- Introduction State --
	This state spawns a description at the beginning of the
	game to inform the player of what their objective is

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

IntroductionState = Class{__includes = BaseState}

function IntroductionState:init()
	-- width of panel
	self.textWidth = 150
	self.textHeight = 55

	-- position of the text
	self.textPositionx = 10
	self.textPositiony = 10
end

function IntroductionState:update(dt)
	-- if the player presses enter, continue with the game
	if love.keyboard.wasPressed('return') then
		gStateStack:pop()
	end
end

function IntroductionState:render(dt)

	love.graphics.setColor(94/255, 3/255, 158/255, 0.75)
	love.graphics.rectangle("fill", self.textPositionx, self.textPositiony, self.textWidth, self.textHeight, 5)
	love.graphics.setColor(13/255, 0, 23/255, 0.85)
	love.graphics.rectangle("fill", self.textPositionx + 2, self.textPositiony + 2, self.textWidth - 4, self.textHeight - 4, 5)

	love.graphics.setColor(1, 1, 1, 0.8)
	love.graphics.printf("Oh no! you have lost your way! Quickly, You must find the three missing coins that will restore your senses! " .. 
		"But be careful of the ghosts that lurk in the darkness. Good Luck!", gFonts['small'], self.textPositionx + 5, self.textPositiony + 4, self.textWidth - 8, 'left')


end