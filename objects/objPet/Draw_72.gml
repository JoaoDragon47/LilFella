var _infos = SkinsInfos[skin_id][Infos.Sprites][state_index]
sprite_length = _infos.anim_length
sprite_speed = _infos.anim_speed
sprite_size = _infos.frame_size

if (sprite_x_frame < sprite_length - (sprite_speed / FRAME)) {
	sprite_x_frame += sprite_speed / FRAME
}else{
	sprite_x_frame = 0
}

sprite_y_frame = floor(((dir + 45) / 90))
sprite_y_frame = clamp(sprite_y_frame, 0, 3)