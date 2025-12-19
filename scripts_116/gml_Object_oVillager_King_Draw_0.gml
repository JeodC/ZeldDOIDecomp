if (!Reveal && !Revealed)
    exit;

PixelRender(true, true, false, -4, 0, false, [], undefined, Alpha);
draw_sprite(sprite_index, image_index, x, y + HoverY);
shader_reset();
