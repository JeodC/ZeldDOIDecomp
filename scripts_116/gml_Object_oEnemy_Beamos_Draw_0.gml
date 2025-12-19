if (EyeA < 180)
{
    if (Shooting)
        Beamos_Laser_Draw();
    
    Enemy_PixelRender(true, sEnemy_Beamos_Palette, Index);
    draw_sprite(sEnemy_Beamos_Eye, EyeImgIndex, EyeX, EyeY);
    shader_reset();
}

if (StopWatch || Stoned)
    Enemy_PixelRender();
else if (State == UnknownEnum.Value_10)
    PixelRender_Dim(true, true, true, sEnemy_Beamos_Palette, Index, true, global.KnockBackColors[KnockBackColorFrame]);
else
    PixelRender_Dim(!Flashing, !Flashing, true, sEnemy_Beamos_Palette, Index, Flashing, FlashColors[FlashColorIndex]);

draw_self();
shader_reset();

if (EyeA >= 180)
{
    Enemy_PixelRender(true, sEnemy_Beamos_Palette, Index);
    draw_sprite(sEnemy_Beamos_Eye, EyeImgIndex, EyeX, EyeY);
    shader_reset();
    
    if (Shooting && !StopWatch)
        Beamos_Laser_Draw();
}

enum UnknownEnum
{
    Value_10 = 10
}
