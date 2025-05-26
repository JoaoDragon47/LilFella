draw_clear_alpha(c_black,0);

var _instN=instance_number(objPet);
var i=0;repeat(_instN){
	var _inst=instance_find(objPet,i);
	with(_inst){
		event_perform(ev_draw,0);
	}
	i++;
}

var _configSkin=instance_nearest(0,0,objCreateSkinConfigs);
if(instance_exists(_configSkin)){
	var _inputsAreas=array_length(_configSkin.inputsAreas);
	i=0;repeat(_inputsAreas){
		var _inst=_configSkin.inputsAreas[i];
		with(_inst){
			event_perform(ev_draw,0);
		}
		i++;
	}
}