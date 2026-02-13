var _xOff = (sprite_size / 2) * sprite_scale, _yOff = (sprite_size / 2) * sprite_scale
if (sprite_base != noone) {
	draw_sprite_general(sprite_base, 0, floor(sprite_x_frame) * sprite_size, sprite_y_frame * sprite_size, sprite_size, sprite_size, x - _xOff, y - _yOff, image_xscale, image_yscale, sprite_angle, c_white, c_white, c_white, c_white, 1)
}