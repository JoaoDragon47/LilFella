draw_clear_alpha(c_black,0)

var _pets_num = instance_number(obj_pet)
var i = 0; repeat (_pets_num) {
	var _pet = instance_find(obj_pet, i)
	with (_pet) {
		event_perform(ev_draw, 0)
	}
	
	i++
}

//var _config_skin = instance_nearest(0, 0, objCreateSkinConfigs)
//if(instance_exists(_configSkin)){
//	var _inputsAreas=array_length(_configSkin.inputsAreas);
//	i=0;repeat(_inputsAreas){
//		var _inst=_configSkin.inputsAreas[i];
//		with(_inst){
//			event_perform(ev_draw,0);
//		}
//		i++;
//	}
//}