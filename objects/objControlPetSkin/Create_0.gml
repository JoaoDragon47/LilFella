//if(!directory_exists("Skins")) directory_create("Skins");
//Skins=array_create(0);



//var _dirSkins="Skins/*.png"
//var _file=file_find_first(_dirSkins,fa_archive)
	
//while(_file!=""){
//	array_push(Skins,sprite_add("Skins/"+_file,3,false,true,0,0));
	
//	_file=file_find_next();
//}


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
	
	while(_folder_skin_file != "") {
		array_push(Skins, [
			sprite_add(_folder_skins + _folder_skin_file + "/idle.png", 1, false, true, 0, 0),		// Idle
			sprite_add(_folder_skins + _folder_skin_file + "/walk.png", 1, false, true, 0, 0),		// Walk
			sprite_add(_folder_skins + _folder_skin_file + "/carrying.png", 1, false, true, 0, 0)	// Carrying
		])
		
		var _skins = array_last(Skins)
		
		array_push(SkinsInfos, [ _folder_skin_file,
			[
				{anim_length: sprite_get_width(_skins[0]) div MODULE, anim_speed: (sprite_get_width(_skins[0]) div MODULE) * 1.5, frame_size: MODULE},
				{anim_length: sprite_get_width(_skins[1]) div MODULE, anim_speed: (sprite_get_width(_skins[1]) div MODULE) * 2, frame_size: MODULE},
				{anim_length: sprite_get_width(_skins[2]) div MODULE, anim_speed: (sprite_get_width(_skins[2]) div MODULE) * 1.5, frame_size: MODULE}
			]
		])
		
		_folder_skin_file = file_find_next()
	}
	SkinsCount = array_length(Skins)
	
	if (SkinsCount <= 0) {
		array_push(Skins, [
			sprite_add(_folder_skins + "Template/idle.png", 1, false, true, 0, 0),		// Idle
			sprite_add(_folder_skins + "Template/walk.png", 1, false, true, 0, 0),		// Walk
			sprite_add(_folder_skins + "Template/carrying.png", 1, false, true, 0, 0)	// Carrying
		]);
		
		array_push(SkinsInfos, ["Template",
			[
				{anim_length: 5, anim_speed: 7, frame_size: MODULE},
				{anim_length: 5, anim_speed: 9, frame_size: MODULE},
				{anim_length: 5, anim_speed: 7, frame_size: MODULE}
			]
		]);
	}
	
	var buff=buffer_create(1, buffer_grow, 1)
	buffer_seek(buff, buffer_seek_start, 0)
	
	buffer_write(buff, buffer_text, json_stringify(SkinsInfos))
	
	buffer_save(buff, SkinsFile)
	buffer_delete(buff)
}else{
	
	var _folder_skins = SkinsDirectory + "/"
	var buff = buffer_load(SkinsFile)
	buffer_seek(buff, buffer_seek_start, 0)
	
	SkinsInfos = json_parse(buffer_read(buff, buffer_text))
	
	var i = 0; repeat(array_length(SkinsInfos)){
		var _folder_skin_file = _folder_skins + SkinsInfos[i][Infos.Name]
		
		if(directory_exists(_folder_skin_file)){
			array_push(Skins, [
				sprite_add(_folder_skin_file + "/idle.png", 1, false, true, 0, 0),		// Idle
				sprite_add(_folder_skin_file + "/walk.png", 1, false, true, 0, 0),		// Walk
				sprite_add(_folder_skin_file + "/carrying.png", 1, false, true, 0, 0)	// Carrying
			])
			
			i++
		} else {
			array_delete(SkinsInfos, i, 1)
		}
	}
	
	show_message(Skins)
	
	buffer_delete(buff)
	
	SkinsCount = array_length(Skins)
	
	if (SkinsCount <= 0) {
		array_push(Skins, [
			sprite_add(_folder_skins + "Template/idle.png", 1, false, true, 0, 0),		// Idle
			sprite_add(_folder_skins + "Template/walk.png", 1, false, true, 0, 0),		// Walk
			sprite_add(_folder_skins + "Template/carrying.png", 1, false, true, 0, 0)	// Carrying
		]);
		
		array_push(SkinsInfos, ["Template",
			[
				{anim_length: 5, anim_speed: 7, frame_size: MODULE},
				{anim_length: 5, anim_speed: 9, frame_size: MODULE},
				{anim_length: 5, anim_speed: 7, frame_size: MODULE}
			]
		]);
	}
}

SkinsCount = array_length(Skins)
drawGui = false;
skinPathFileClicked="";
