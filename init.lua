-- Create the trash field
local trash = minetest.create_detached_inventory("creative_trash", {
	-- Allow the stack to be placed and remove it in on_put()
	-- This allows the creative inventory to restore the stack
	allow_put = function(inv, listname, index, stack, player)
		if not minetest.setting_getbool("creative_mode") then
			return stack:get_count()
		else
			return stack:get_count()
		end
	end,
	on_put = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, "")
	end,
})
trash:set_size("main", 1)

creative_inventory.set_creative_formspec = function(player, start_i, pagenum)
	pagenum = math.floor(pagenum)
	local pagemax = math.floor((creative_inventory.creative_inventory_size-1) / (2*4) + 1)
	player:set_inventory_formspec("size[8,7.5]"..
			"list[current_player;main;0,3.5;8,4;]"..
			"list[current_player;craft;3,0;3,3;]"..
			"list[current_player;craftpreview;7,1;1,1;]"..
			"label[0,1.5;Trash:]"..
			"list[detached:creative_trash;main;0,2;1,1;]")
end

minetest.register_on_joinplayer(function(player)
	creative_inventory.set_creative_formspec(player, 0, 1)
end)
