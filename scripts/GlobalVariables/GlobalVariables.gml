globalvar tCell;
tCell=16;
globalvar wDisplay;
globalvar hDisplay;
wDisplay=display_get_width();
hDisplay=display_get_height();
globalvar surfInterface;
surfInterface=noone;

#macro FRAME game_get_speed(gamespeed_fps)

enum StatesIndex{
	Idle,
	Walk,
	Carrying
}

globalvar fntGame;
fntGame=font_add_sprite_ext(sprFontGame,"/\\|!?,;.:%*-+_[]{}<>()#'\"=&abcdefghijklmnopqrstuvwxyzçáàâãéèêíìîóòôõúùûABCDEFGHIJKLMNOPQRSTUVWXYZÇÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛ0123456789",true,0);

globalvar SkinsFile;
SkinsFile="skins_data.dat";