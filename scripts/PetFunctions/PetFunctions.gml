function PetChooseState(){
	next_state=choose(PetWalkState,PetIdleState,PetWalkToMouseState);
	timer_to_change_state=FRAME*random_range(1.5,4);
	
	switch next_state{
		case PetWalkState:
			x_dest=irandom(room_width);
			y_dest=irandom(room_height);
			
			state=PetWalkState;
			break;
		case PetIdleState:
			state=PetIdleState;
			break;
		//case PetWalkToMouseState:
		//	x_dest=mouse_x;
		//	y_dest=mouse_y;
			
		//	state=PetWalkToMouseState;
		//	break;
	}
}

function PetWalkState(){
	state_index=StatesIndex.Walk;
	sprite_base = Skins[skin_id][state_index]
	timer_to_change_state--;
	
	dir=point_direction(x,y,x_dest,y_dest);
			
	hspd=lengthdir_x(spd,dir);
	vspd=lengthdir_y(spd,dir);
	x+=hspd;
	y+=vspd;
	if(point_distance(x,y,x_dest,y_dest)<=spd*1.5){
		state_index=StatesIndex.Idle;
		x=x_dest;
		y=y_dest;
		dir=270;
	}
}

function PetIdleState(){
	state_index=StatesIndex.Idle;
	sprite_base = Skins[skin_id][state_index]
	timer_to_change_state--;
}

function PetLaunchState(){
	if(spd_launch>0){
		image_angle=-dir;
		angle=image_angle;
		spd_launch-=.1;
		state_index=StatesIndex.Walk;
		sprite_base = Skins[skin_id][state_index]
		dir=point_direction(x,y,x+hspd,y+vspd);
		
		hspd=lengthdir_x(spd_launch,dir);
		vspd=lengthdir_y(spd_launch,dir);
		
		if(x+hspd>=room_width or x+hspd<=0){
			hspd=-hspd;
			spd_launch-=.2;
		}
		
		if(y+vspd>=room_height or y+vspd<=0){
			vspd=-vspd;
			spd_launch-=.2;
		}
		
		x+=hspd;
		y+=vspd;
	}else{
		state_index=StatesIndex.Idle;
		sprite_base = Skins[skin_id][state_index]
		angle=0;
		dir=270;
		state=PetChooseState;
	}
}

function PetWalkToMouseState(){
	x_dest=mouse_x;
	y_dest=mouse_y;
	
	state_index=StatesIndex.Walk;
	sprite_base = Skins[skin_id][state_index]
	
	dir=point_direction(x,y,x_dest,y_dest);
			
	hspd=lengthdir_x(spd,dir);
	vspd=lengthdir_y(spd,dir);
	x+=hspd;
	y+=vspd;
	
	if(point_distance(x,y,x_dest,y_dest)<=spd*1.5){
		x_dest=irandom(room_width);
		y_dest=irandom(room_height);
		
		state=PetGrabMouseState;
	}
}

function PetGrabMouseState(){
	display_mouse_set(x,y);
	
	state_index=StatesIndex.Walk;
	sprite_base = Skins[skin_id][state_index]
	timer_to_change_state--;
	
	dir=point_direction(x,y,x_dest,y_dest);
			
	hspd=lengthdir_x(spd,dir);
	vspd=lengthdir_y(spd,dir);
	x+=hspd;
	y+=vspd;
	if(point_distance(x,y,x_dest,y_dest)<=spd*1.5){
		state_index=StatesIndex.Idle;
		sprite_base = Skins[skin_id][state_index]
		x=x_dest;
		y=y_dest;
		dir=270;
	}
}