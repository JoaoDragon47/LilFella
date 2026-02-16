if (draw_gui) {
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
}