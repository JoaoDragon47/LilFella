window_set_Penetrate(false);

pet_alpha=255;
window_set_showborder(false);
window_set_AlphaAndCrkey(pet_alpha,c_black);
window_set_size(wDisplay,hDisplay);
display_set_gui_size(wDisplay,hDisplay);
window_set_position(0,0);

if(!surface_exists(surfInterface)) surfInterface=surface_create(wDisplay,hDisplay);