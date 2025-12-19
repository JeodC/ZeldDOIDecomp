PixelRender_Dim(true, true, false, -4, 0, false, []);
draw_sprite(sShadow_Large, 0, x, y - 1);
draw_sprite_ext(sprite_index, image_index, x, y, Dir, 1, 0, c_white, 1);
shader_reset();
