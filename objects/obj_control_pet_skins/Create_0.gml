// Se não existir a pasta de skins, então crie-a.
if (!directory_exists(SkinsDirectory)) {directory_create(SkinsDirectory)}

Skins = array_create(0)
SkinsInfos = array_create(0)

// Verificar se existe o arquivo 'skins_data.dat' criado na pasta.
if (!file_exists(SkinsFile)) {
	// Se não tiver criado, começar a montá-lo.
	
	// Pegar uma string contendo 'local_pasta/skins/', para facilitar o acesso às pastas das skins.
	var _folder_skins = SkinsDirectory + "/"
	// Pegar a primeira pasta de skins que houver.
	var _folder_skin_file = file_find_first(_folder_skins + "*", fa_directory)
	
	while (_folder_skin_file != "") {
		array_push(Skins, [
			sprite_add(_folder_skins + _folder_skin_file + "/idle.png", 1, false, true, 0, 0),
			sprite_add(_folder_skins + _folder_skin_file + "/walk.png", 1, false, true, 0, 0),
			sprite_add(_folder_skins + _folder_skin_file + "/carrying.png", 1, false, true, 0, 0),
			sprite_add(_folder_skins + _folder_skin_file + "/taunt.png", 1, false, true, 0, 0),
			sprite_add(_folder_skins + _folder_skin_file + "/steal_mouse.png", 1, false, true, 0, 0),
			sprite_add(_folder_skins + _folder_skin_file + "/sit.png", 1, false, true, 0, 0),
			sprite_add(_folder_skins + _folder_skin_file + "/launched.png", 1, false, true, 0, 0)
		])
		
		var _skins_count = array_length(Skins)
		var _actual_skin = array_last(Skins)
		
		array_push(SkinsInfos, [_folder_skin_file, array_create(StatesIndex.Length)])
		
		var i = 0; repeat (StatesIndex.Length) {
			SkinsInfos[_skins_count - 1][Infos.Sprites][i] = {
				anim_length: sprite_get_width(_actual_skin[i]) div MODULE,
				anim_speed: (sprite_get_width(_actual_skin[i]) div MODULE) * 1.5,
				frame_size: MODULE
			}
			
			i++
		}
		
		_folder_skin_file = file_find_next()
	}
	SkinsCount = array_length(Skins)
	
	var i = 0; repeat (SkinsCount) {
		var j = 0; repeat(StatesIndex.Length) {
			if (Skins[i][j] == -1) {
				Skins[i][j] = spr_template_skin_idle
				SkinsInfos[i][Infos.Sprites][j] = {
					anim_length: 5,
					anim_speed: 7,
					frame_size: MODULE
				}
			}
			j++
		}
		
		i++
	}
	
	if (SkinsCount <= 0) {
		array_push(Skins, [
			spr_template_skin_idle,
			spr_template_skin_walk,
			spr_template_skin_carrying,
			spr_template_skin_taunt,
			spr_template_skin_steal_mouse,
			spr_template_skin_sit,
			spr_template_skin_launched
		]);
		
		array_push(SkinsInfos, ["Template", array_create(StatesIndex.Length)])
		
		i = 0; repeat (StatesIndex.Length) {
			SkinsInfos[SkinsCount - 1][Infos.Sprites][i] = {
				anim_length: sprite_get_width(Skins[0][i]) div MODULE,
				anim_speed: (sprite_get_width(Skins[0][i]) div MODULE) * 1.5,
				frame_size: MODULE
			}
			
			i++
		}
	}
	
	if (global.save_files) {
		var buff = buffer_create(1, buffer_grow, 1)
		buffer_seek(buff, buffer_seek_start, 0)
		
		buffer_write(buff, buffer_text, json_stringify(SkinsInfos))
		
		buffer_save(buff, SkinsFile)
		buffer_delete(buff)
	}
} else {
	
	var _folder_skins = SkinsDirectory + "/"
	var buff = buffer_load(SkinsFile)
	buffer_seek(buff, buffer_seek_start, 0)
	
	SkinsInfos = json_parse(buffer_read(buff, buffer_text))
	
	var i = 0; repeat (array_length(SkinsInfos)) {
		var _folder_skin_file = _folder_skins + SkinsInfos[i][Infos.Name]
		
		if(directory_exists(_folder_skin_file)){
			array_push(Skins, [
				sprite_add(_folder_skin_file + "/idle.png", 1, false, true, 0, 0),
				sprite_add(_folder_skin_file + "/walk.png", 1, false, true, 0, 0),
				sprite_add(_folder_skin_file + "/carrying.png", 1, false, true, 0, 0),
				sprite_add(_folder_skin_file + "/taunt.png", 1, false, true, 0, 0),
				sprite_add(_folder_skin_file + "/steal_mouse.png", 1, false, true, 0, 0),
				sprite_add(_folder_skin_file + "/sit.png", 1, false, true, 0, 0),
				sprite_add(_folder_skin_file + "/launched.png", 1, false, true, 0, 0)
			])
			
			i++
		} else {
			array_delete(SkinsInfos, i, 1)
		}
	}
	
	buffer_delete(buff)
	
	SkinsCount = array_length(Skins)
	
	i = 0; repeat (SkinsCount) {
		var j = 0; repeat(StatesIndex.Length) {
			if (Skins[i][j] == -1) {
				Skins[i][j] = spr_template_skin_idle
				SkinsInfos[i][Infos.Sprites][j] = {anim_length: 5, anim_speed: 7, frame_size: MODULE}
			}
			j++
		}
		
		i++
	}
	
	if (SkinsCount <= 0) {
		array_push(Skins, [
			spr_template_skin_idle,
			spr_template_skin_walk,
			spr_template_skin_carrying,
			spr_template_skin_taunt,
			spr_template_skin_steal_mouse,
			spr_template_skin_sit,
			spr_template_skin_launched	
		]);
		
		array_push(SkinsInfos, ["Template", array_create(StatesIndex.Length)])
		
		i = 0; repeat (StatesIndex.Length) {
			SkinsInfos[SkinsCount - 1][Infos.Sprites][i] = {
				anim_length: sprite_get_width(Skins[0][i]) div MODULE,
				anim_speed: (sprite_get_width(Skins[0][i]) div MODULE) * 1.5,
				frame_size: MODULE
			}
			
			i++
		}
	}
}

draw_gui = false
skinPathFileClicked = ""
