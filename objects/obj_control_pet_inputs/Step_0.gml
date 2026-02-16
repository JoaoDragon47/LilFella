if (keyboard_check(vk_shift)) {
	if (keyboard_check_pressed(ord("V"))) {
		with (obj_pet) {
			move = !move
			
			if (!move) {
				change_state(state_choose_state)
			} else {
				change_state(state_follow_mouse)
			}
		}
	}
	
	if (keyboard_check_pressed(vk_home)) {
		instance_create_layer(room_width / 2, room_height / 2, "ins_pets", obj_pet)
	} else if (keyboard_check_pressed(vk_end)) {
		if (instance_exists(obj_pet)) {
			var _inst_num = instance_number(obj_pet)
			var _inst = instance_find(obj_pet, _inst_num - 1)
			with (_inst) {
				instance_destroy()
			}
			
			if ((_inst_num-1) <= 0) {game_end()}
		}
	}
}

with (obj_pet) {
	if (keyboard_check_pressed(ord("1"))) {
		change_state(state_taunt)
	}
	if (keyboard_check_pressed(ord("2"))) {
		change_state(state_sit)
	}
	if (keyboard_check_pressed(ord("3"))) {
		change_state(state_pet_go_steal_mouse)
	}
}