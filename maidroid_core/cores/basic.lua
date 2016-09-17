------------------------------------------------------------
-- Copyright (c) 2016 tacigar. All rights reserved.
-- https://github.com/tacigar/maidroid
------------------------------------------------------------

local state = {IDLE = 0, ACCOMPANY = 1}

local function on_start(self)
	print("KOKO")
	self.state = state.IDLE
	self.object:setacceleration{x = 0, y = -10, z = 0}
	self.object:setvelocity{x = 0, y = 0, z = 0}
end

local function on_stop(self)
	self.state = nil
	self.object:setvelocity{x = 0, y = 0, z = 0}
end

local on_resume = on_start

local on_pause = on_stop

local function on_step(self, dtime)
	local player = self:get_nearest_player(10)
	if player == nil then
		self:set_animation(maidroid.animation_frames.STAND)
		return
	end

	local position = self.object:getpos()
	local player_position = player:getpos()
	local direction = vector.subtract(player_position, position)
	local velocity = self.object:getvelocity()

	if vector.length(direction) < 3 then
		if self.state == state.ACCOMPANY then
			self:set_animation(maidroid.animation_frames.STAND)
			self.state = state.IDLE
			self.object:setvelocity{x = 0, y = velocity.y, z = 0}
		end
	else
		if self.state == state.IDLE then
			self:set_animation(maidroid.animation_frames.WALK)
			self.state = state.ACCOMPANY
		end
		self.object:setvelocity{x = direction.x, y = velocity.y, z = direction.z} -- TODO
	end

	-- if maidroid is stoped by obstacle, the maidroid must jump.
	if velocity.y == 0 and self.state == state.ACCOMPANY then
		local front_node = self:get_front_node()
		if front_node.name ~= "air" then
			self.object:setvelocity{x = direction.x, y = 5, z = direction.z}
		end
	end
end

-- register a definition of a new core.
maidroid.register_core("maidroid_core:basic", {
	description      = "maidroid core : basic",
	inventory_image  = "maidroid_core_basic.png",
	on_start         = on_start,
	on_stop          = on_stop,
	on_resume        = on_resume,
	on_pause         = on_pause,
	on_step          = on_step,
})
