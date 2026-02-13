window_set_Penetrate(false)

pet_alpha = 255
window_set_showborder(false)
window_set_AlphaAndCrkey(pet_alpha, c_black)
window_set_size(global.monitor_width, global.monitor_height)
display_set_gui_size(VIEW_WIDTH, VIEW_HEIGHT)
window_center()

if(!surface_exists(global.surface_interface)) {global.surface_interface = surface_create(global.monitor_width, global.monitor_height)}
