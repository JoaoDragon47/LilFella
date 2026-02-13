function PetChooseState(){
	nextState=choose(PetWalkState,PetIdleState,PetWalkToMouseState);
	changeStateTimer=FRAME*random_range(1.5,4);
	
	switch nextState{
		case PetWalkState:
			xDest=irandom(room_width);
			yDest=irandom(room_height);
			
			state=PetWalkState;
			break;
		case PetIdleState:
			state=PetIdleState;
			break;
		//case PetWalkToMouseState:
		//	xDest=mouse_x;
		//	yDest=mouse_y;
			
		//	state=PetWalkToMouseState;
		//	break;
	}
}

function PetWalkState(){
	state_index=StatesIndex.Walk;
	sprite_base = Skins[skin_id][state_index]
	changeStateTimer--;
	
	dir=point_direction(x,y,xDest,yDest);
			
	hspd=lengthdir_x(spd,dir);
	vspd=lengthdir_y(spd,dir);
	x+=hspd;
	y+=vspd;
	if(point_distance(x,y,xDest,yDest)<=spd*1.5){
		state_index=StatesIndex.Idle;
		x=xDest;
		y=yDest;
		dir=270;
	}
}

function PetIdleState(){
	state_index=StatesIndex.Idle;
	sprite_base = Skins[skin_id][state_index]
	changeStateTimer--;
}

function PetLaunchState(){
	if(launchSpd>0){
		image_angle=-dir;
		angle=image_angle;
		launchSpd-=.1;
		state_index=StatesIndex.Walk;
		sprite_base = Skins[skin_id][state_index]
		dir=point_direction(x,y,x+hspd,y+vspd);
		
		hspd=lengthdir_x(launchSpd,dir);
		vspd=lengthdir_y(launchSpd,dir);
		
		if(x+hspd>=room_width or x+hspd<=0){
			hspd=-hspd;
			launchSpd-=.2;
		}
		
		if(y+vspd>=room_height or y+vspd<=0){
			vspd=-vspd;
			launchSpd-=.2;
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
	xDest=mouse_x;
	yDest=mouse_y;
	
	state_index=StatesIndex.Walk;
	sprite_base = Skins[skin_id][state_index]
	
	dir=point_direction(x,y,xDest,yDest);
			
	hspd=lengthdir_x(spd,dir);
	vspd=lengthdir_y(spd,dir);
	x+=hspd;
	y+=vspd;
	
	if(point_distance(x,y,xDest,yDest)<=spd*1.5){
		xDest=irandom(room_width);
		yDest=irandom(room_height);
		
		state=PetGrabMouseState;
	}
}

function PetGrabMouseState(){
	display_mouse_set(x,y);
	
	state_index=StatesIndex.Walk;
	sprite_base = Skins[skin_id][state_index]
	changeStateTimer--;
	
	dir=point_direction(x,y,xDest,yDest);
			
	hspd=lengthdir_x(spd,dir);
	vspd=lengthdir_y(spd,dir);
	x+=hspd;
	y+=vspd;
	if(point_distance(x,y,xDest,yDest)<=spd*1.5){
		state_index=StatesIndex.Idle;
		sprite_base = Skins[skin_id][state_index]
		x=xDest;
		y=yDest;
		dir=270;
	}
}