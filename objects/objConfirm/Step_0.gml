if(timer>0) timer--;

if(mouse_check_button_pressed(mb_left)){
	if(point_in_rectangle(mouse_x,mouse_y,xInitial,yInitial,xInitial+wButton,yInitial+hButton)){
		with(objCreateSkinConfigs){
			var _dirSkins=obj_pet.SkinsDirectory+"/";
			var _file=skinPath.input;
			
			if(_file!=""){
				var _skinName=_dirSkins+skinName.drawInput+".png";
				ini_open(_skinName);
				ini_close();
				file_copy(_file,_skinName);
				array_push(Skins,sprite_add(_skinName,3,false,true,0,0));
				var _sprSize;
				switch skinSize.selection{
					default: _sprSize=8;break;
					case 1: _sprSize=16;break;
					case 2: _sprSize=32;break;
					case 3: _sprSize=64;break;
				}
				var _wSpr=sprite_get_width(array_last(Skins)) div _sprSize;
				var _spdSpr=floor(_wSpr*1.5);
				array_push(SkinsInfos,{Name: filename_name(_skinName), Lenght: _wSpr, Spd: _spdSpr, Size: _sprSize});
				SkinsCount++;
				
				instance_destroy(skinName);
				instance_destroy(skinPath);
				instance_destroy(skinSize);
				instance_destroy(other);
				instance_destroy();
			}else{
				timerText="Selecione um arquivo"
				other.timer=other.cooldown;
			}
		}
	}
}