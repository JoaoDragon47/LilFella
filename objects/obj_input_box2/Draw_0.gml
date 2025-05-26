/// @description Draw
input_box_draw(xOffset,yOffset,boxSprite,autoHeight,fillInactiveCol,fillActiveCol,borderInactiveCol,borderActiveCol,textInactiveCol,textActiveCol,highlightCol,highlightAlpha,hideVbarXOffset,hideVbarYOffset);

draw_set_font(fntGame);
draw_text(left+width+16,top+yOffset,"("+input+")");