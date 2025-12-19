if (TransformFlash)
    PixelRender(true, true, false, 0, 0, true, TransformFlash_Colors[TransformFlash_Color]);
else
    PixelRender(true, true, false, -4, 0, false, []);

draw_self();
shader_reset();
