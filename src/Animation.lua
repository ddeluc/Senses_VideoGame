--[[
    GD50 Final Assignment
    Senses

    -- Animation Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Animation = Class{}

function Animation:init(def)
    -- frames to iterate over
    self.frames = def.frames

    -- time inbetween each frame
    self.interval = def.interval

    -- timer to perform animation
    self.timer = 0

    -- index of sprite that will be drawn
    self.currentFrame = 1

    -- check to see if the animation should loop
    self.looping = def.looping or true

    -- counter for the number of complete animations
    self.timesPlayed = 0
end

function Animation:refresh()
    -- reset animation from the beginning
    self.timer = 0
    self.currentFrame = 1
    self.timesPlayed = 0
end

function Animation:update(dt)
    -- if the animation should not loop, prevent it from looping
    -- more than once
    if not self.looping and self.timesPlayed > 0 then
        return
    end

    -- perform the animation depending on intialized paramters
    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))

            if self.currentFrame == 1 then
                self.timesPlayed = self.timesPlayed + 1
            end
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end