var i = 0; repeat(SkinsCount) {
	var j = 0; repeat(StatesIndex.Length) {
		sprite_delete(Skins[i][j])
		
		j++
	}
	
	i++
}