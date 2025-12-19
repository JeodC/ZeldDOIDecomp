Enemy_DrawShadow();
Enemy_PixelRender();
draw_self();

switch (Dir)
{
    case 3:
        draw_sprite(Sprite_Mouth_Left, MouthFrame, x - 9, y - 7);
        break;
    
    case 4:
        draw_sprite(Sprite_Mouth_Right, MouthFrame, x, y - 7);
        break;
    
    case 2:
        draw_sprite(Sprite_Mouth_Down, MouthFrame, x - 4, y - 4);
        break;
}

shader_reset();
