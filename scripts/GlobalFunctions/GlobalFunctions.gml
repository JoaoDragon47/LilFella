function approach(_first,_end,_value){
	if(_first < _end){
		return min(_first+_value,_end);
	}else{
		return max(_first-_value,_end);
	}
}

function drawAlign(_valign=fa_top,_halign=fa_left){
	draw_set_valign(_valign);
	draw_set_halign(_halign);
}

function drawReset(){
	draw_set_font(-1);
	draw_set_valign(-1);
	draw_set_halign(-1);
	draw_set_color(c_white);
}