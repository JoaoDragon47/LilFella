randomize()

sprite_x_frame = 0
sprite_y_frame = 0
sprite_length = 2
sprite_speed = 3
sprite_size = MODULE
state_index = 0
sprite_angle = 0
sprite_scale = 1
image_xscale = sprite_scale
image_yscale = sprite_scale

skin_id = irandom(SkinsCount - 1)
sprite_base = Skins[skin_id][state_index]

move=false;
carryPet=false;
timer=0;

walkSpd=1.2;
launchSpd=6;
spd=walkSpd;
hspd=-1;
vspd=-1;
dir=270;

xDest=room_width/2;
yDest=room_height/2;
xMousePrevious=room_width/2;
yMousePrevious=room_height/2;
mousePositionTimer=0;

nextState=PetChooseState;
state=nextState;
changeStateTimer=0;

sacudir=0;

x=room_width/2;
y=room_height/2;

CarryThePet=function(){
	var mx = display_mouse_get_x(), my = display_mouse_get_y()
	var _info = SkinsInfos[skin_id][Infos.Sprites][state_index]
	
	/// CARREGAR O PET COM O MOUSE
	var _holdingMouse = mouse_check_button(mb_left)
	state_index = StatesIndex.Idle
	if(point_in_rectangle(mx,my,bbox_left,bbox_top,bbox_right,bbox_bottom)){
		if(_holdingMouse and (objMouse.petHolding==noone or keyboard_check(vk_tab))){
			objMouse.petHolding = self
			carryPet = true
			state = PetIdleState
			dir = 270
		}
		
		if (mouse_wheel_down()) {
			skin_id--
			if(skin_id < 0) {skin_id = SkinsCount - 1}
		}
		
		if (mouse_wheel_up()) {
			skin_id++
			if (skin_id >= SkinsCount) {skin_id=0}
		}
		
		sprite_base = Skins[skin_id][state_index]
	}
	
	if(!_holdingMouse and carryPet){
		objMouse.petHolding=noone;
		carryPet=false;
		timer=FRAME*2;
		changeStateTimer=0;
		
		if(sacudir>1){
			var _sacudirValue=25;
			if((abs(xMousePrevious-mx)>=_sacudirValue) or (abs(yMousePrevious-my)>=_sacudirValue)){
				dir=point_direction(x,y,mx,my);
				var _valueDir=point_distance(0,0,abs(xMousePrevious-mx),abs(xMousePrevious-mx));
				//show_debug_message(_valueDir);
				launchSpd=(_valueDir/100)+((sacudir*2)/5)+walkSpd;
				hspd=lengthdir_x(launchSpd,dir);
				vspd=lengthdir_y(launchSpd,dir);
				timer=0;
				changeStateTimer=FRAME*3+(launchSpd);
			
				state=PetLaunchState;
				script_execute(state);
			}
		}
		
		sacudir=0;
	}
	
	if(carryPet){
		state_index = StatesIndex.Carrying
		sprite_base = Skins[skin_id][state_index]
		x = mx
		y = my + (_info.frame_size * .8)
		
		mousePositionTimer--;
		
		if(mousePositionTimer<=0){
			if(xMousePrevious!=mx or yMousePrevious!= my){
				var _sacudirValue=30;
				if((abs(xMousePrevious-mx)>=_sacudirValue) or (abs(yMousePrevious-my)>=_sacudirValue)){
					//show_debug_message("mouse sacudindo");
					sacudir++;
				}else{
					//show_debug_message("mouse em canto diferente");
				}
			}else{
				//show_debug_message("mouse no mermo canto");
				if(sacudir>0) sacudir--;
			}
			
			//show_debug_message(sacudir);
			mousePositionTimer=FRAME*.05;
			xMousePrevious=mx;
			yMousePrevious=my;
		}
	}else{
		timer--;
		
		if(timer<=0){
			if(changeStateTimer<=0){
				state=PetChooseState;
			}
			
			script_execute(state);
		}
	}
}