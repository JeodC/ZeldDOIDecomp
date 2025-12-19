draw_sprite_ext((FloorLevel == 1) ? sWallMask : ((FloorLevel == 0) ? sWallMask_Lower : sWallMask_UpperLower), 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
draw_text(ObjCenterX(), ObjCenterY(), string(BlockItems));
