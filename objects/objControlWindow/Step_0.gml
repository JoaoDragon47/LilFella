if(!window_has_focus()) window_set_TopMost();

if(keyboard_check(vk_shift)){
	if(keyboard_check_pressed(ord("V"))){
		with(objPet){
			move=!move;
			if(!move) dir=270;
		}
	}else if(keyboard_check_pressed(ord("C"))){
		if(!instance_exists(objCreateSkinConfigs)){
			instance_create_layer(0,0,layer,objCreateSkinConfigs);
		}
	}
}

if(keyboard_check(vk_space)){
	if(keyboard_check_pressed(vk_home)){
		instance_create_layer(room_width/2,room_height/2,"Instances",objPet);
	}else if(keyboard_check_pressed(vk_end)){
		if(instance_exists(objPet)){
			var _instNum=instance_number(objPet);
			var _inst=instance_find(objPet,_instNum-1);
			with(_inst){
				instance_destroy();
			}
			
			if((_instNum-1)<=0) game_end();
		}
	}
}