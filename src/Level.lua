--[[
	CS50 Final Assignment
	Senses

	This class is meant to manage all of the entities and objects
	that are instantiated in the level.

	Author: Dante Deluca
	dantedeluca3219@icloud.com
]]

Level = Class{}

function Level:init(tiles, height, width)
	-- array of map tiles
	self.tiles = tiles

	-- height and width of the map
	self.height = height
	self.width = width

	-- player object
	self.player = Player({
        x = 5, y = 6 * TILE_SIZE - 20,
        width = 16, height = 20,
        color = {1, 0, 0}, texture = 'player_movement',
        stateMachine = StateMachine({
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walk'] = function() return PlayerWalkState(self.player) end,
            ['jump'] = function() return PlayerJumpState(self.player) end,
            ['fall'] = function() return PlayerFallState(self.player) end,
            ['sword'] = function() return PlayerSwordState(self.player) end
        }),

        level = self
    })	

	-- array of all ghosts in the level to keep track of
	self.ghosts = {}

	-- spawn the ghosts depending on an array of constant values
	for k, pos in pairs(ghostPositions) do
		table.insert(self.ghosts, Ghost({
			x = pos[1] * TILE_SIZE,
			y = pos[2] * TILE_SIZE,
			level = self,
			counter = pos[3]
		}))
	end

	-- array of coins to keep track of
	self.coins = {} 

	-- spawn the coins depending on an array of constant values
	for k, pos in pairs(coinPositions) do
		table.insert(self.coins, Coin(pos[2], pos[1]))
	end
end

function Level:update(dt)

	-- iterate through all of the ghosts and check if whether or not they are wihtin
	-- the player's visible radius or if they are outside of it
	for k, ghost in pairs(self.ghosts) do

		-- if the ghost is outside of the player's visible radius, allow them to appear visible 
		-- for only a small moment in time
		if self:checkEqualDistance(ghost.x, ghost.y, self.player.x, self.player.y, self.player.hearingRadius) then
			Timer.tween(0.25, {
				[ghost] = {blipOpacity = 1}
			})
			:finish(function() 
				Timer.tween(1, {
					[ghost] = {blipOpacity = 0}
				})
			end)
		end

		-- if the ghost is whithin the visible radius then do not show them as a blip
		if self:checkLessDistance(ghost.x, ghost.y, self.player.x, self.player.y, self.player.radius) then
			ghost.blipOpacity = 0
		end

		-- update the player position
		ghost:updatePlayerPosition(self.player.x, self.player.y)
		ghost:update(dt)

		-- kill the player if they touch the ghost
		if ghost:collides(self.player) then
			self.player.dead = true	
		end
	end

	-- check if the player falls below the map and kill them if they do
	if self.player.y > self.height * TILE_SIZE then
		self.player.dead = true
	end

	-- iterate through each coin and check to see if the
	-- player has collided with it
	for k, coin in pairs(self.coins) do
		coin:update(dt)

		-- if the player collided with the coin then allow the
		-- player to upgrade their senses
		if self.player:collides(coin) then
			gSounds['coin']:play()
			coin.collected = true
			self.player.coinCount = self.player.coinCount + 1

			-- if the player count has reached 3, then return the push
			-- the win state
			if self.player.coinCount == 3 then	
				gStateStack:push(FadeInState({
					r = 1, g = 1, b = 1
				}, 1,
				function()
					gStateStack:pop()

					gStateStack:push(WinState())
				end))
			else
				gStateStack:push(UpgradeState(self.player))
			end
		end
	end

	-- remove all of the dead ghosts from the level
	for k, ghost in pairs(self.ghosts) do
		if ghost.dead then
			table.remove(self.ghosts, k)
		end
	end

	-- remove all of the collected coins from the level
	for k, coin in pairs(self.coins) do
		if coin.collected then 
			table.remove(self.coins, k)
		end
	end
end

function Level:render()
	for y = 1, self.height do
		for x = 1, self.width do
			if self.tiles[y][x] ~= nil then
				self.tiles[y][x]:render()
			end
		end
	end

	for k, ghost in pairs(self.ghosts) do
		ghost:render()
	end

	for k, coin in pairs(self.coins) do
		coin:render()
	end

	love.graphics.setStencilTest()
end

--[[
 	A function that renders the ghosts as blips if they are outside
 	of the player's visible radius
]]
function Level:renderBlips()
	for k, ghost in pairs(self.ghosts) do
		love.graphics.setColor(1, 1, 1, ghost.blipOpacity)
		love.graphics.draw(gTextures['ghost'], gFrames['ghost'][2], ghost.x, ghost.y)
		love.graphics.setColor(1, 1, 1, 1)
	end
end

--[[
	This function is taken from Assignment 4 50 Bros
	This function returns a tile specified by its x and y index
	in the level
]]
function Level:pointToTile(x, y)
	if x < 0 or x > self.width * TILE_SIZE or y < 0 or y > self.height * TILE_SIZE then
		return nil
	end 

	return self.tiles[math.floor(y / TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1]
end

--[[
	Return ture if the distance between a ghost and the player
	is equal to the visible radius
]]
function Level:checkEqualDistance(x1, y1, x2, y2, radius)
	local result = self:getDistance(x1, y1, x2, y2)

	if radius > result - 5 and radius < result + 5 then
		return true
	else
		return false
	end
end

--[[
	Check to see if a distance is less than a radius
]]
function Level:checkLessDistance(x1, y1, x2, y2, radius)
	local result = self:getDistance(x1, y1, x2, y2)

	if result < radius then
		return true
	else
		return false
	end
end

--[[
	return distance between two points
]]
function Level:getDistance(x1, y1, x2, y2)
	local dy = math.abs(y2 - y1)
	local dx = math.abs(x2 - x1)

	local result = math.sqrt((dy * dy) + (dx * dx))

	return result
end

