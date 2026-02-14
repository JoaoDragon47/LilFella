if (surface_exists(global.surface_interface)) {surface_free(global.surface_interface)}
if (font_exists(FontGame)) {font_delete(FontGame)}

if (file_exists(SkinsFile)) {file_delete(SkinsFile)}
var buff = buffer_create(10, buffer_grow, 1)
buffer_seek(buff, buffer_seek_start, 0)

buffer_write(buff, buffer_text, json_stringify(SkinsInfos))
	
buffer_save(buff, SkinsFile)
buffer_delete(buff)