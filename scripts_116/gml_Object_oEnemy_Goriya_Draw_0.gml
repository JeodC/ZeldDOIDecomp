Enemy_DrawShadow();
Enemy_PixelRender(true, sEnemy_Goriya_Pal, Type);
draw_self();

if (Type == 1 && OpenMouth)
{
    switch (Dir)
    {
        case 3:
            draw_sprite(sEnemy_Goriya_Mouth, 0, x - 6, y - 14);
            break;
        
        case 4:
            draw_sprite(sEnemy_Goriya_Mouth, 1, x + 6, y - 14);
            break;
        
        case 2:
            draw_sprite(sEnemy_Goriya_Mouth, 2, x, y - 15);
            break;
    }
}

shader_reset();
