--[[
    GD50 Final Assignment
	Senses

	This box will appear only when the player is in the AttackState
	and any ghost that collides with it will be destroyed

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Hitbox = Class{}

function Hitbox:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
end