var _infos=skinsInfos[skinID];
sprLen=_infos.Lenght;
sprSpd=_infos.Spd;
sprSize=_infos.Size;

if(xFrame<sprLen-(sprSpd/FRAME)){
	xFrame+=sprSpd/FRAME;
}else{
	xFrame=0;
}