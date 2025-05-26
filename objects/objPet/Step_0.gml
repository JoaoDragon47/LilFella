var mx=display_mouse_get_x()*wScale,my=display_mouse_get_y()*hScale;

if(point_in_rectangle(mx,my,bbox_left,bbox_top,bbox_right,bbox_bottom)){
	if(mouse_check_button_pressed(mb_right)){
		//move=!move;
		if(!move) dir=270;
		
		state=PetChooseState;
	}
}

var _info=skinsInfos[skinID];
if(move){
	xDest=mx;
	yDest=my+(_info.Size*(.8));
	
	PetWalkState();
}else{
	CarryThePet();
}

yFrame=floor(((dir+45)/90));
yFrame=clamp(yFrame,0,3);