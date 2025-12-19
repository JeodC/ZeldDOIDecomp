if (State == UnknownEnum.Value_5 || State == UnknownEnum.Value_7 || State == UnknownEnum.Value_6)
    exit;

if (State == UnknownEnum.Value_2 || State == UnknownEnum.Value_3 || State == UnknownEnum.Value_4)
{
    if (!MergeConnected)
        draw_sprite(sShadow_Large, 0, BaseX_Other, BaseY_Other);
    
    draw_sprite(sItem_Kinstone, image_index, BaseX_Other, SpriteY_Other);
}

if (State == UnknownEnum.Value_4 || MergeConnected)
    draw_sprite(sShadow_Large, 0, BaseX - 3, BaseY);
else
    draw_sprite(sShadow_Large, 0, BaseX, BaseY);

draw_sprite(sprite_index, image_index, BaseX, SpriteY);

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7
}
