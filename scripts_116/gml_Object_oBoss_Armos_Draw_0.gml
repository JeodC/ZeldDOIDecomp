PixelRender(true, true, false, -4, 0, false, 0);
var ShadowFrame = (z <= 7) ? 0 : ((z <= 14) ? 1 : ((z <= 21) ? 2 : 3));
draw_sprite(sShadow_Armos, ShadowFrame, x + oBoss_Armos_C.ShakeOffset, y_base);
shader_reset();
Enemy_PixelRender();
draw_sprite(sBoss_Armos, image_index, x + oBoss_Armos_C.ShakeOffset, y);
shader_reset();
