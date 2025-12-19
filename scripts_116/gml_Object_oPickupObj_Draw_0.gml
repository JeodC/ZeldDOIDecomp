var _PickedUp = State == UnknownEnum.Value_2;
var _Lighting = Lighting && !_PickedUp;
PixelRender_Dim(_Lighting, _Lighting, false, -4, 0, false, []);

if (DrawShadow)
    draw_sprite(sShadow_Large, 0, x, y_base);

draw_sprite(sprite_index, Index, x, y);

if (!_PickedUp)
    Obj_DrawInWater(false);

shader_reset();

enum UnknownEnum
{
    Value_2 = 2
}
