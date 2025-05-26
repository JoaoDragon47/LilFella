if(!directory_exists("skins")) directory_create("skins");
skins=array_create(0);

var _dirSkins="skins/*.png"
var _file=file_find_first(_dirSkins,fa_archive)
	
while(_file!=""){
	array_push(skins,sprite_add("skins/"+_file,3,false,true,0,0));
	
	_file=file_find_next();
}

//if(!file_exists("skins/BlankSkin.png")){
//	ini_open("skins/BlankSkin.png");
//	ini_close();
//	file_copy(sprPetBlanked,"skins/BlankSkin.png");
//}

skinsCount=array_length(skins);
drawGui=false;
skinPathFileClicked="";

//skinListSurface=noone;

//if(!surface_exists(skinListSurface)) skinListSurface=surface_create(60,30);
//surface_set_target(skinListSurface);

//surface_reset_target();