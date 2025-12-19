PixelRender(true, true, false, -4, 0, false, []);

if (oLink.Facing != 1)
    draw_sprite_ext(sHookshot_Handle, 0, StartPointX, StartPointY, 1, 1, Dir, c_white, 1);

for (var ChainIndex = 0; ChainIndex < Chains; ChainIndex++)
    draw_sprite(sHookshot_Chain, ChainAniFrame, ds_list_find_value(ChainXList, ChainIndex), ds_list_find_value(ChainYList, ChainIndex));

if (oLink.Facing == 1 && y_base > (oLink.y - 20))
{
}
else
{
    draw_sprite_ext(sprite_index, 0, x, y_base, 1, 1, Dir, c_white, 1);
}

shader_reset();
