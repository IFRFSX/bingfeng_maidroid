------------------------------------------------------------
-- Copyright (c) 2016 tacigar. All rights reserved.
-- https://github.com/tacigar/maidroid
------------------------------------------------------------

-- register a definition of a core writer.
(function()
	local node_box = {
		type = "fixed",
		fixed = {
			{-0.4375,   -0.25, -0.4375,  0.4375,  0.1875,  0.4375},
			{ 0.1875,  0.3125,  0.0625,  0.4375,   0.375,   0.125},
			{ -0.375,  0.1875,  -0.375,   0.375,    0.25,   0.375},
			{-0.0625,    -0.5, -0.0625,  0.0625,   0.375,  0.0625},
			{  0.375,  0.1875,  0.0625,  0.4375,   0.375,   0.125},
			{ -0.375,    -0.5,  -0.375,   0.375,   -0.25,   0.375},
		},
	}

	local tiles = {
		"maidroid_tool_core_writer_top.png",
		"maidroid_tool_core_writer_bottom.png",
		"maidroid_tool_core_writer_right.png",
		"maidroid_tool_core_writer_right.png^[transformFX",
		"maidroid_tool_core_writer_front.png^[transformFX",
		"maidroid_tool_core_writer_front.png",
	}

	minetest.register_node("maidroid_tool:core_writer", {
		description        = "maidroid tool : core writer",
		drawtype           = "nodebox",
		paramtype          = "light",
		paramtype2         = "facedir",
		groups             = {cracky = 2},
		is_ground_content  = false,
		sounds             = default.node_sound_stone_defaults(),
		node_box           = node_box,
		tiles              = tiles,
	})
end) ();

-- register a definition of a core entity.
(function()
	local node_box = {
		type = "fixed",
		fixed = {
			{   -0.5,    -0.5,  -0.125,     0.5, -0.4375,   0.125},
			{ -0.125,    -0.5,    -0.5,   0.125, -0.4375,     0.5},
			{  -0.25,    -0.5, -0.4375,    0.25, -0.4375,  0.4375},
			{ -0.375,    -0.5,  -0.375,   0.375, -0.4375,   0.375},
			{-0.4375,    -0.5,   -0.25,  0.4375, -0.4375,    0.25},
		},
	}

	local tiles = {
		"maidroid_tool_core_top.png",
		"maidroid_tool_core_top.png",
		"maidroid_tool_core_right.png",
		"maidroid_tool_core_right.png",
		"maidroid_tool_core_right.png",
		"maidroid_tool_core_right.png",
	}

	minetest.register_node("maidroid_tool:core_node", {
		drawtype    = "nodebox",
		tiles       = tiles,
		node_box    = node_box,
		paramtype   = "light",
		paramtype2  = "facedir",
	})

	minetest.register_entity("maidroid_tool:core_entity", {
		physical       = false,
		visual         = "wielditem",
		visual_size    = {x = 0.5, y = 0.5},
		collisionbox  = {0, 0, 0, 0, 0, 0},

		on_activate = function(self, staticdata)
			self.object:set_properties{textures = {"maidroid_tool:core_node"}}
		end,

		on_step = function(self, dtime)
			local yaw = self.object:getyaw()
			self.object:setyaw(yaw + 0.1)
		end,
	})

	minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
		minetest.add_entity(pointed_thing.above, "maidroid_tool:core_entity")
	end)

end) ()
