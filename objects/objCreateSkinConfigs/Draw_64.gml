var mx=display_mouse_get_x(),my=display_mouse_get_y();
var c=make_color_rgb(190,190,190);

if(!surface_exists(surfInterface)) surfInterface=surface_create(wDisplay,hDisplay);
surface_set_target(surfInterface);
draw_clear_alpha(c_black,0);

c=c_white
draw_rectangle_color(0,0,confirmButton.xInitial+confirmButton.wButton+20*mScale,confirmButton.yInitial+confirmButton.hButton+20*mScale,c,c,c,c,false)

with(skinName){
	input_box_draw(xOffset,yOffset,boxSprite,autoHeight,fillInactiveCol,fillActiveCol,borderInactiveCol,borderActiveCol,textInactiveCol,textActiveCol,highlightCol,highlightAlpha,hideVbarXOffset,hideVbarYOffset);
}

with(skinPath){
	input_box_draw(xOffset,yOffset,boxSprite,autoHeight,fillInactiveCol,fillActiveCol,borderInactiveCol,borderActiveCol,textInactiveCol,textActiveCol,highlightCol,highlightAlpha,hideVbarXOffset,hideVbarYOffset);
}

with(skinSize){
	input_box_dd_Draw(1,1,c_black,c_white,c_gray,c_white,c_white,c_white,c_white,spr_dropdown_arrow);
}

with(confirmButton){
	
	draw_align(fa_middle,fa_center);
	draw_set_font(FontGame);
	
	c=make_color_rgb(190,190,190);
	if(point_in_rectangle(mx,my,xInitial,yInitial,xInitial+wButton,yInitial+hButton)){
		c=make_color_rgb(140,140,140);
	}
	draw_rectangle_color(xInitial,yInitial,xInitial+wButton,yInitial+hButton,c,c,c,c,false);
	
	c=c_white;
	draw_text_color(xInitial+(wButton/2),yInitial+(hButton/2),"Adicionar",c,c,c,c,1);
	if(timer>0){
		draw_align(fa_middle,fa_left);
		c=make_color_rgb(255,50,60);
		draw_text_color(objInputBoxSkinPath.xInitial+objInputBoxSkinPath.width+12,objInputBoxSkinPath.yInitial+(objInputBoxSkinPath.height/2),"<- "+timerText,c,c,c,c,1);
	}

	draw_reset();
}

surface_reset_target();

draw_surface(surfInterface,0,0);