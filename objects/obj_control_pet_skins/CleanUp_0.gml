var i = 0; repeat(SkinsCount) {
	var j = 0; repeat(StatesIndex.Length) {
		sprite_delete(Skins[i][j])
		
		j++
	}
	
	i++
}


if (file_exists(SkinsFile)) {file_delete(SkinsFile)}

if (global.save_files) {
	var buff = buffer_create(10, buffer_grow, 1)
	buffer_seek(buff, buffer_seek_start, 0)
	
	buffer_write(buff, buffer_text, json_stringify(SkinsInfos))
	
	buffer_save(buff, SkinsFile)
	buffer_delete(buff)
}