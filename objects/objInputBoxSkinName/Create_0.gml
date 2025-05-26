/// @description Init
//Init variables (if you want to use the same object for different instances then put all the below in each instance's Creation Code)
var _defaultArray = ["Nome Skin",fntGame,true];
var _hideArray = [false,"*",fnt_hide,font_get_size(fnt_hide)+8];
var _excludedArray = [";","!"];
input_box_init(xInitial,yInitial,192,24,font_get_size(fntGame)+7,false,_defaultArray,192-(4*3),30,6,fntGame,1,_hideArray,0,_excludedArray,objInputBoxSkinPath);

//step variables
canCutCopy = true;
canPaste = true;

//draw variables (doing the below is optional but helps keeps all the input box settings in one place)
xOffset = 4;
yOffset = 2;
boxSprite = -1;//set the sprite to use for the input box (-1 for none). Use a Top Left Sprite Origin. Frame 0 will be used for Inactive, frame 1 will be used for active
//if using a sprite then set the below fill and border colours to -1. If the above autoHeight is true make sure the sprite uses Nine Slice
autoHeight = true;
fillInactiveCol = make_colour_rgb(239,239,239);//-1 to not draw
fillActiveCol = c_white;//-1 to not draw
borderInactiveCol = c_dkgray;//-1 to not draw
borderActiveCol = c_black;//-1 to not draw
textInactiveCol = c_white;
textActiveCol = c_white;
highlightCol = c_white;
highlightAlpha = 0.5;
hideVbarXOffset = -2;
hideVbarYOffset = -2;