if (BossDestroyed)
{
    PixelRender(true, true, false, -4, 0, false, []);
    draw_sprite(sBoss_Aghanim_Dead, 0, x, y);
    shader_reset();
    exit;
}

PixelRender(true, true, false, -4, 0, false, []);
draw_sprite(sShadow_Large, 0, x, y);
shader_reset();

if (GravityBall)
{
    PixelRender(true, true, true, sPalette_Aghanim_EnergyBall, EnergyBall_PalIndex, false, 0);
    draw_sprite(sEnergyBall, 2, x - 12, y - 28);
    draw_sprite(sEnergyBall, 2, x + 12, y - 28);
    shader_reset();
}

switch (State)
{
    default:
        Enemy_PixelRender();
        draw_self();
        shader_reset();
        break;
    
    case UnknownEnum.Value_8:
    case UnknownEnum.Value_1:
        PixelRender(true, true, false, -4, 0, false, []);
        draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, make_color_rgb(BlackballMorph, BlackballMorph, BlackballMorph), 1);
        shader_reset();
        break;
    
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_19:
        PixelRender(false, false, false, -4, 0, true, global.KnockBackColors[KnockBackColorFrame]);
        draw_self();
        shader_reset();
        break;
}

if (TakeItems_ShowBag)
{
    PixelRender(true, true, false, -4, 0, false, []);
    draw_sprite(sItem_Bag, global.Inventory_ItemData[UnknownEnum.Value_2].Index, TakeItems_BagPosX, TakeItems_BagPosY);
    shader_reset();
    
    if (TakeItems_ShowShield)
    {
        var _Index = (alarm[8] >= 96) ? 0 : ((alarm[8] >= 92) ? 1 : (2 + EnergyBall_PalIndex));
        draw_sprite_ext(sAghanim_GravityBall, _Index, x, y + 4, 1, -1, 0, c_white, 1);
        PixelRender(false, false, true, sPalette_Aghanim_EnergyBall, EnergyBall_PalIndex, false, 0);
        draw_sprite(sEnergyBall, 2, x - 12, y - 24);
        draw_sprite(sEnergyBall, 2, x + 12, y - 24);
        shader_reset();
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_8 = 8,
    Value_19 = 19
}
