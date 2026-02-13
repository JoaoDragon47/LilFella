if (drawGui) {
	var _xx = 0
	var _yy = 0
	var i = 0; repeat(SkinsCount){
		_xx = 0
		var j = 0; repeat(3) {
			var _skin = Skins[i][j]
			
			draw_sprite(_skin, 0, _xx, _yy)
			
			_xx += sprite_get_width(_skin)
			
			j++
		}
		
		_yy += MODULE * 4
		
		i++
	}
	
	//var _wButtonAddFile=60,_hButtonAddFile=30;
	//var _xButtonAddFile=20,_yButtonAddFile=20;
	//draw_rectangle(_xButtonAddFile,_yButtonAddFile,_xButtonAddFile+_wButtonAddFile,_yButtonAddFile+_hButtonAddFile,false);
	//if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_xButtonAddFile,_yButtonAddFile,_xButtonAddFile+_wButtonAddFile,_yButtonAddFile+_hButtonAddFile)){
	//	if(mouse_check_button_pressed(mb_left)){
	//		skinPathFileClicked=get_open_filename("image file|.png","*.png");
	//		show_debug_message(skinPathFileClicked);
	//		if(skinPathFileClicked!=""){
	//			var _fileName=filename_name(skinPathFileClicked);
	//			var _fileSkin="Skins/"+_fileName;
	//			ini_open(_fileSkin);
	//			ini_close();
	//			file_copy(skinPathFileClicked,_fileSkin);
	//		}
	//	}
	//}
}