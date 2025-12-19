surface_set_target(global.Arcade_ActiveInst.GameSurface);
draw_sprite_stretched(sprite_index, 0, ScreenX, ScreenY, ScreenW, ScreenH);
surface_reset_target();
surface_set_target(GameSurface);
draw_clear_alpha(c_black, 1);
draw_set_color(#003318);
draw_rectangle(0, GameH - 6, GameW, GameH, false);
surface_reset_target();
