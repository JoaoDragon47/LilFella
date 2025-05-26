var xx=20*mScale,yy=20*mScale;

skinName=instance_create_layer(x,y,layer,objInputBoxSkinName,{
	xInitial: xx,
	yInitial: yy*1
});
skinPath=instance_create_layer(x,y,layer,objInputBoxSkinPath,{
	xInitial: xx,
	yInitial: yy*3
});
skinSize=instance_create_layer(x,y,layer,objDropdownBoxSkinSize,{
	xInitial: xx,
	yInitial: yy*5
});
confirmButton=instance_create_layer(x,y,layer,objConfirm,{
	xInitial: (other.skinSize.right)+xx,
	yInitial: other.skinSize.top
})

inputsAreas=[skinName,skinPath,skinSize,confirmButton];