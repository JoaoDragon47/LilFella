randomize();

//window_ExtendFrame();

globalvar mScale;
mScale=(wDisplay/wDisplay);

wScale=mScale;
hScale=mScale;

xFrame=0;
yFrame=0;
sprLen=2;
sprSpd=3;
sprSize=tCell;
stateIndex=0;
globalvar skins;
globalvar skinsCount;
skins=array_create(0);
globalvar skinsInfos;
skinsInfos=array_create(0);
SkinsDirectory=program_directory+"skins";
if(!file_exists(SkinsFile)){
	if(!directory_exists(SkinsDirectory)) directory_create(SkinsDirectory);

	var _dirSkins=SkinsDirectory+"/";
	var _file=file_find_first(_dirSkins+"*.png",fa_none);

	while(_file != ""){
		array_push(skins,sprite_add(_dirSkins+_file,3,false,true,0,0));
		var _skin=array_last(skins);
		var _wSpr=sprite_get_width(_skin) div tCell;
		var _spdSpr=floor(_wSpr*1.5);
		array_push(skinsInfos,{Name: filename_name(_file), Lenght: _wSpr, Spd: _spdSpr, Size: tCell});
	
		_file=file_find_next();
	}
	skinsCount=array_length(skins);

	if(skinsCount<=0){
		array_push(skins,TemplateSkin);
		var _skin=array_last(skins);
		var _wSpr=sprite_get_width(_skin) div tCell;
		var _spdSpr=floor(_wSpr*1.5);
		array_push(skinsInfos,{Name: "Template.png", Lenght: _wSpr, Spd: _spdSpr, Size: tCell});
	}
	
	var buff=buffer_create(10,buffer_grow,1);
	buffer_seek(buff,buffer_seek_start,0);
	
	buffer_write(buff,buffer_text,json_stringify(skinsInfos));
	
	buffer_save(buff,SkinsFile);
	buffer_delete(buff);
}else{
	
	var buff=buffer_load(SkinsFile);
	buffer_seek(buff,buffer_seek_start,0);
	
	skinsInfos=json_parse(buffer_read(buff,buffer_text));
	
	var i=0;repeat(array_length(skinsInfos)){
		var _fileSkin=SkinsDirectory+"/"+skinsInfos[i].Name;
		if(file_exists(_fileSkin)){
			array_push(skins,sprite_add(_fileSkin,3,false,true,0,0));
			i++;
		}else{
			array_delete(skinsInfos,i,1);
		}
	}
	
	buffer_delete(buff);
	
	skinsCount=array_length(skins);
	
	if(skinsCount<=0){
		array_push(skins,TemplateSkin);
		var _skin=array_last(skins);
		var _wSpr=sprite_get_width(_skin) div tCell;
		var _spdSpr=floor(_wSpr*1.5);
		array_push(skinsInfos,{Name: "Template.png", Lenght: _wSpr, Spd: _spdSpr, Size: tCell});
	}
}

skinsCount=array_length(skins);
skinID=irandom(skinsCount-1);
sprBase=skins[skinID];
sprScale=2*mScale;
image_xscale=sprScale;
image_yscale=sprScale;

move=false;
carryPet=false;
timer=0;

walkSpd=1.2;
launchSpd=6;
spd=walkSpd;
hspd=-1;
vspd=-1;
dir=270;
angle=0;

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
	var mx=display_mouse_get_x()*wScale,my=display_mouse_get_y()*hScale;
	var _info=skinsInfos[skinID];
	
	///CARREGAR O PET COM O MOUSE
	var _holdingMouse=mouse_check_button(mb_left);
	stateIndex=StatesIndex.Idle;
	if(point_in_rectangle(mx,my,bbox_left,bbox_top,bbox_right,bbox_bottom)){
		if(_holdingMouse and (objMouse.petHolding==noone or keyboard_check(vk_tab))){
			objMouse.petHolding=self;
			carryPet=true;
			state=PetIdleState;
			dir=270;
		}
		
		if(mouse_wheel_down()){
			skinID--;
			if(skinID<0) skinID=skinsCount-1;
		}
		
		if(mouse_wheel_up()){
			skinID++;
			if(skinID>=skinsCount) skinID=0;
		}
		
		sprBase=skins[skinID];
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
				show_debug_message(_valueDir);
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
		stateIndex=StatesIndex.Carrying;
		x=mx;
		y=my+(_info.Size*.8);
		
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