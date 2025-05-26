if(surface_exists(surfInterface)) surface_free(surfInterface);
if(font_exists(fntGame)) font_delete(fntGame);

var i=0;repeat(skinsCount){
	sprite_delete(skins[i]);
	i++;
}

if(file_exists(SkinsFile)) file_delete(SkinsFile);
var buff=buffer_create(10,buffer_grow,1);
buffer_seek(buff,buffer_seek_start,0);

buffer_write(buff,buffer_text,json_stringify(skinsInfos));
	
buffer_save(buff,SkinsFile);
buffer_delete(buff);