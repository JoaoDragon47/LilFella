global.surface_interface = noone
global.monitor_width = display_get_width()
global.monitor_height = display_get_height()

enum StatesIndex {
	Idle,
	Walk,
	Carrying,
	Length
}

enum Infos {
	Name,
	Sprites,
	Length
}

globalvar FontGame;
FontGame = font_add_sprite_ext(spr_font_game, "/\\|!?,;.:%*-+_[]{}<>()#'\"=&abcdefghijklmnopqrstuvwxyzçáàâãéèêíìîóòôõúùûABCDEFGHIJKLMNOPQRSTUVWXYZÇÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛ0123456789", true, 0)

globalvar Skins;
globalvar SkinsCount;
globalvar SkinsInfos;
globalvar SkinsFile;
globalvar SkinsDirectory;
SkinsFile = "skins_data.dat"
SkinsDirectory = working_directory + "skins"