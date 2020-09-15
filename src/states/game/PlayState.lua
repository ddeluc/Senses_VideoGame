--[[
	GD50 Final Assignment
	Senses

    -- Play State --
    This class updates the behaviours of the level and all of
    the entities in the level.

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- instantiate the level
	self.level = MapGenerator:generate()

    -- set a reference to the player
    self.player = self.level.player

    -- reset the background position
    self.backgroundX = 0
    self.camX = 0

    -- begin the player in the idle state
    self.player:change('idle', {
        texture = self.player.texture
    })

    -- stop the previous music and play the playstate music
    gStateStack:stopMusic()
    gStateStack:changeMusic('play')
    gStateStack:playMusic()
end

function PlayState:update(dt)
	self.player:update(dt)
    self.level:update(dt)

    -- bound the player to the level
    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x > TILE_SIZE * self.level.width - self.player.width then
        self.player.x = TILE_SIZE * self.level.width - self.player.width
    end

    -- if the player dies than push the death state
    if self.player.dead == true then
        gSounds['caught']:play()
        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0
        }, 1,
        function()
            gStateStack:push(DeathState())
        end))
    end

    self:updateCamera()
    new_origin = self.camX
end

function PlayState:render()	

    love.graphics.translate(- math.floor(self.camX), 0)

    self.level:renderBlips()

    push:setCanvas('stencil_canvas')

    love.graphics.stencil(
        function() love.graphics.circle("fill", self.player.x + self.player.width / 2, self.player.y + self.player.height / 2, self.player.radius) end
        , "replace", 1)
    love.graphics.setStencilTest("greater", 0)

    for i = 0, 10 do
        love.graphics.draw(gTextures['background'], gFrames['background'][1], math.floor(-self.backgroundX) + 150 * i, 0)
    end    

	self.level:render()
    self.player:render()

    love.graphics.setStencilTest()    

end
--[[
    This function was taken from Assignment 4 50 Bros
    This function adjusts the camera to seemingly follow the player
]]
function PlayState:updateCamera()
    self.camX = math.max(0,
        math.min(TILE_SIZE * self.level.width - VIRTUAL_WIDTH,
        self.player.x - (VIRTUAL_WIDTH / 2 - 8)))

    self.backgroundX = (self.camX / 3) % 150
end