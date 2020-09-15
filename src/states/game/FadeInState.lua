--[[
    GD50 Final Assignment
    Senses
    From Assignment 7

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

FadeInState = Class{__includes = BaseState}

function FadeInState:init(color, time, onFadeComplete)
    self.r = color.r
    self.g = color.g
    self.b = color.b
    self.opacity = 0
    self.time = 2

    Timer.tween(self.time, {
        [self] = {opacity = 1}
    })
    :finish(function()
        gStateStack:pop()
        onFadeComplete()
    end)
end

function FadeInState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', new_origin, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
end