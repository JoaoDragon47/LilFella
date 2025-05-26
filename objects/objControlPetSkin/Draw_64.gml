if(drawGui){
	var i=0;repeat(skinsCount){
		var _skin=skins[i];
		
		draw_sprite(_skin,0,0,20*i);
		
		i++;
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
	//			var _fileSkin="skins/"+_fileName;
	//			ini_open(_fileSkin);
	//			ini_close();
	//			file_copy(skinPathFileClicked,_fileSkin);
	//		}
	//	}
	//}
}