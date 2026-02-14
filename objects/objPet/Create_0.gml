randomize()

#region SPRITE VARIABLES MANAGER

sprite_x_frame = 0
sprite_y_frame = 0
sprite_length = 2
sprite_speed = 3
sprite_size = MODULE
state_index = 0
sprite_angle = 0
sprite_scale = 2
image_xscale = sprite_scale
image_yscale = sprite_scale
skin_id = irandom(SkinsCount - 1)
sprite_base = Skins[skin_id][state_index]

#endregion

move = false
carry_pet = false

spd_walk = 1.2
spd_launch = 6
spd = spd_walk
hspd = 0
vspd = 0
dir = 270

x_dest = room_width / 2
y_dest = room_height / 2
x_mouse_previous = room_width / 2
y_mouse_previous = room_height / 2


#region TIMERS

timer_to_change_state = 0
timer_mouse_position = 0
timer_chasing_mouse = 0
timer = 0

#endregion


change_skin_id = function() {
	if (mouse_wheel_down()) {
		skin_id--
		if(skin_id < 0) {skin_id = SkinsCount - 1}
		sprite_base = Skins[skin_id][state_index]
	}
	
	if (mouse_wheel_up()) {
		skin_id++
		if (skin_id >= SkinsCount) {skin_id = 0}
		sprite_base = Skins[skin_id][state_index]
	}
}


check_pet_follow_mouse = function() {
	// Começar ou parar de seguir o mouse
	if (mouse_check_button_pressed(mb_right)) {
		move = !move
		if (!move) {
			change_state(state_choose_state)
		} else {
			change_state(state_follow_mouse)
		}
	}
}


check_grab_pet = function() {
	var _holding_mouse = mouse_check_button(mb_left)
	if (_holding_mouse and (objMouse.pet_holding == noone or keyboard_check(vk_shift))) {
		objMouse.pet_holding = self
		carry_pet = true
		dir = 270
			
		change_state(state_pet_grabbed)
		return
	}
}


check_next_state = function() {
	timer_to_change_state--
	if (timer_to_change_state <= 0) {
		change_state(state_choose_state)
	}
}


state_idle = new State()
state_idle.start = function() {
	state_index = StatesIndex.Idle
	sprite_base = Skins[skin_id][state_index]
}
state_idle.step = function() {
	check_next_state()
	
	if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
		change_skin_id()
		check_pet_follow_mouse()
		check_grab_pet()
	}
}


state_walk = new State()
state_walk.start = function() {
	state_index = StatesIndex.Walk
	sprite_base = Skins[skin_id][state_index]
}
state_walk.step = function() {
	dir = point_direction(x, y, x_dest, y_dest)
			
	hspd = lengthdir_x(spd, dir)
	vspd = lengthdir_y(spd, dir)
	x += hspd
	y += vspd
	if (point_distance(x, y, x_dest, y_dest) <= spd * 1.5) {
		x = x_dest
		y = y_dest
		dir = 270
		
		change_state(state_idle)
	}
	
	check_next_state()
	
	if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
		change_skin_id()
		check_pet_follow_mouse()
		check_grab_pet()
	}
}


state_follow_mouse = new State()
state_follow_mouse.start = function() {
	state_index = StatesIndex.Walk
	sprite_base = Skins[skin_id][state_index]
}
state_follow_mouse.step = function() {
	var _actual_skin_info = SkinsInfos[skin_id][Infos.Sprites][state_index]
	sprite_base = Skins[skin_id][state_index]
	
	x_dest = display_mouse_get_x()
	y_dest = display_mouse_get_y() + (_actual_skin_info.frame_size * 0.6)
	
	dir = point_direction(x, y, x_dest, y_dest)
			
	hspd = lengthdir_x(spd, dir)
	vspd = lengthdir_y(spd, dir)
	
	x += hspd
	y += vspd
	
	if (point_distance(x, y, x_dest, y_dest) <= spd * 1.5) {
		x = x_dest
		y = y_dest
		dir = 270
		state_index = StatesIndex.Idle
	} else {
		state_index = StatesIndex.Walk
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
		change_skin_id()
		check_pet_follow_mouse()
		check_grab_pet()
	}
}
state_follow_mouse.stop = function() {
	move = false
	dir = 270
}


state_choose_state = new State()
state_choose_state.start = function() {
	next_state = choose(state_idle, state_walk, state_pet_walk_to_mouse)
	timer_to_change_state = FRAME * random_range(1, 10)
	
	change_state(next_state)
}
state_choose_state.stop = function() {
	switch (next_state) {
		case state_walk:
			x_dest = irandom(room_width)
			y_dest = irandom(room_height)
			break;
	}
}


state_pet_grabbed = new State() 
state_pet_grabbed.start = function() {
	state_index = StatesIndex.Carrying
	sprite_base = Skins[skin_id][state_index]
}
state_pet_grabbed.step = function() {
	var _holding_mouse = mouse_check_button(mb_left)
	var _actual_skin_info = SkinsInfos[skin_id][Infos.Sprites][state_index]
	
	if (!_holding_mouse) {
		if (throw_pet_strength > 1) {
			var _min_mouse_deslocation = 25
			if ((abs(x_mouse_previous - mouse_x) >= _min_mouse_deslocation) or (abs(y_mouse_previous - mouse_y) >= _min_mouse_deslocation)) {
				dir = point_direction(x, y, mouse_x, mouse_y)
				
				var _value_diagonal = point_distance(0, 0, abs(x_mouse_previous - mouse_x), abs(x_mouse_previous - mouse_x))
				show_debug_message(_value_diagonal)
				spd_launch = (_value_diagonal / 100) + ((throw_pet_strength * 2) / 5) + spd_walk
				hspd = lengthdir_x(spd_launch, dir)
				vspd = lengthdir_y(spd_launch, dir)
			
				change_state(state_pet_launched)
				return
			}
		}
		
		change_state(state_idle)
	}
	
	x = mouse_x
	y = mouse_y + (_actual_skin_info.frame_size * 0.8)
	
	// Verificar alteração na posição do mouse para identificar o movimento de arremessar o pet
	timer_mouse_position--
	if (timer_mouse_position <= 0) {
		if (x_mouse_previous != mouse_x or y_mouse_previous != mouse_y) {
			// Verificar o quanto o mouse se deslocou, se for uma diferença de '30' pixels então somar a força de arremesso.
			var _min_mouse_deslocation = 30
			if ((abs(x_mouse_previous - mouse_x) >= _min_mouse_deslocation) or (abs(y_mouse_previous - mouse_y) >= _min_mouse_deslocation)) {
				//show_debug_message("mouse sacudindo")
				// Aumentar a força de arremesso aos poucos
				throw_pet_strength++
			}else{
				//show_debug_message("mouse em canto diferente")
			}
		} else {
			//show_debug_message("mouse no mermo canto")
			// Diminuir a força de arremesso aos poucos
			if (throw_pet_strength > 0) {throw_pet_strength--}
		}
			
		//show_debug_message(throw_pet_strength)
		timer_mouse_position = FRAME * 0.05
		x_mouse_previous = mouse_x
		y_mouse_previous = mouse_y
	}
}
state_pet_grabbed.stop = function() {
	objMouse.pet_holding = noone
	//carry_pet = false
	timer = FRAME * 2
	timer_to_change_state = 0
	throw_pet_strength = 0
}


state_pet_launched = new State()
state_pet_launched.start = function() {
	timer = 0
	timer_to_change_state = (FRAME * 3) + spd_launch
	
	state_index = StatesIndex.Walk
	sprite_base = Skins[skin_id][state_index]
}
state_pet_launched.step = function() {
	if (spd_launch > 0) {
		//image_angle = -dir
		sprite_angle = -dir
		spd_launch -= 0.1
		
		dir = point_direction(x, y, x + hspd, y + vspd)
		
		hspd = lengthdir_x(spd_launch, dir)
		vspd = lengthdir_y(spd_launch, dir)
		
		if (x + hspd >= room_width or x + hspd <= 0){
			hspd = -(hspd + irandom_range(0.5, 1.5))
			spd_launch -= 0.2
		}
		
		if (y + vspd >= room_height or y + vspd <= 0){
			vspd = -(vspd + irandom_range(0.5, 1.5))
			spd_launch -= 0.2
		}
		
		x += hspd
		y += vspd
	} else {
		change_state(state_idle)
	}
}
state_pet_launched.stop = function() {
	sprite_angle = 0
	dir = 270
}


state_pet_walk_to_mouse = new State()
state_pet_walk_to_mouse.start = function() {
	state_index = StatesIndex.Walk
	sprite_base = Skins[skin_id][state_index]
	
	timer_chasing_mouse = FRAME * random_range(2, 8)
}
state_pet_walk_to_mouse.step = function() {
	var _actual_skin_info = SkinsInfos[skin_id][Infos.Sprites][state_index]
	
	x_dest = display_mouse_get_x()
	y_dest = display_mouse_get_y()
	
	dir = point_direction(x, y, x_dest, y_dest)
			
	hspd = lengthdir_x(spd, dir)
	vspd = lengthdir_y(spd, dir)
	
	x += hspd
	y += vspd
	
	if (point_distance(x, y, x_dest, y_dest) <= spd * 1.5) {
		x = x_dest
		y = y_dest
		dir = 270
		
		change_state(state_pet_grab_mouse)
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
		change_skin_id()
		check_pet_follow_mouse()
		check_grab_pet()
	}
	
	timer_chasing_mouse--
	if (timer_chasing_mouse <= 0) {
		change_state(state_idle)
	}
}


state_pet_grab_mouse = new State()
state_pet_grab_mouse.start = function() {
	state_index = StatesIndex.Walk
	sprite_base = Skins[skin_id][state_index]
	
	x_dest = x + irandom_range(-128, 128)
	y_dest = y + irandom_range(-128, 128)
	
	x_dest = clamp(x_dest, 0, room_width)
	y_dest = clamp(y_dest, 0, room_height)
}
state_pet_grab_mouse.step = function() {
	display_mouse_set(x, y)
	
	dir = point_direction(x, y, x_dest, y_dest)
			
	hspd = lengthdir_x(spd, dir)
	vspd = lengthdir_y(spd, dir)
	
	x += hspd
	y += vspd
	
	if (point_distance(x, y, x_dest, y_dest) <= spd * 1.5) {
		change_state(state_idle)
	}
}


next_state = state_choose_state
state = new State()
init_state(next_state)

throw_pet_strength = 0

x = room_width / 2
y = room_height / 2