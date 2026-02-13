if(surface_exists(surfInterface)) surface_free(surfInterface);
if(font_exists(FontGame)) font_delete(FontGame);

var i=0;repeat(SkinsCount){
	sprite_delete(Skins[i]);
	i++;
}

if(file_exists(SkinsFile)) file_delete(SkinsFile);
var buff=buffer_create(10,buffer_grow,1);
buffer_seek(buff,buffer_seek_start,0);

buffer_write(buff,buffer_text,json_stringify(SkinsInfos));
	
buffer_save(buff,SkinsFile);
buffer_delete(buff);