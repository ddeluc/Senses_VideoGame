--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Constants'
require 'src/Util'
require 'src/Tile'
require 'src/MapGenerator'
require 'src/Level'
require 'src/Player'
require 'src/StateMachine'
require 'src/Hitbox'
require 'src/Ghost'
require 'src/Coin'
require 'src/Animation'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/player/PlayerIdleState'
require 'src/states/player/PlayerWalkState'
require 'src/states/player/PlayerJumpState'
require 'src/states/player/PlayerFallState'
require 'src/states/player/PlayerSwordState'

require 'src/states/game/StartState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'
require 'src/states/game/PlayState'
require 'src/states/game/DeathState'
require 'src/states/game/UpgradeState'
require 'src/states/game/WinState'
require 'src/states/game/IntroductionState'

gTextures = {
	['tiles'] = love.graphics.newImage('graphics/ground_tiles.png'),
	['player_movement'] = love.graphics.newImage('graphics/Player.png'),
	['background'] = love.graphics.newImage('graphics/background.png'),
	['player_combat'] = love.graphics.newImage('graphics/PlayerCombat.png'),
	['ghost'] = love.graphics.newImage('graphics/Ghost.png'),
	['coin'] = love.graphics.newImage('graphics/Coin.png')
}

gFrames = {
	['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
	['player_movement'] = GenerateQuads(gTextures['player_movement'], 16, 20),
	['background'] = GenerateQuads(gTextures['background'], 150, 180),
	['player_combat'] = GenerateQuads(gTextures['player_combat'], 20, 20),
	['ghost'] = GenerateQuads(gTextures['ghost'], 16, 20),
	['coin'] = GenerateQuads(gTextures['coin'], 8, 8)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gSounds = {
	['menu'] = love.audio.newSource('sounds/menu.mp3', 'static'),
	['play'] = love.audio.newSource('sounds/play.mp3', 'static'),
	['win'] = love.audio.newSource('sounds/win.mp3', 'static'),
	['coin'] = love.audio.newSource('sounds/coin.wav', 'static'),
	['ghostKilled'] = love.audio.newSource('sounds/ghostKilled.wav', 'static'),
	['punch'] = love.audio.newSource('sounds/punch.wav', 'static'),
	['caught'] = love.audio.newSource('sounds/caught.wav', 'static'),
	['upgrade'] = love.audio.newSource('sounds/upgrade.wav', 'static'),
	['fall'] = love.audio.newSource('sounds/fall.wav', 'static'),
	['gameOver'] = love.audio.newSource('sounds/gameOver.mp3', 'static')
}