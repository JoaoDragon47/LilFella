var mx = display_mouse_get_x(), my = display_mouse_get_y()

if(point_in_rectangle(mx,my,bbox_left,bbox_top,bbox_right,bbox_bottom)){
	if (mouse_check_button_pressed(mb_right)) {
		move = !move;
		if (!move) dir = 270
		
		state = PetChooseState
	}
}

var _info = SkinsInfos[skin_id][Infos.Sprites][state_index]
if (move) {
	xDest = mx
	yDest = my + (_info.frame_size * .8)
	
	PetWalkState();
}else{
	CarryThePet();
}

sprite_y_frame = floor(((dir + 45) / 90))
sprite_y_frame = clamp(sprite_y_frame, 0, 3)