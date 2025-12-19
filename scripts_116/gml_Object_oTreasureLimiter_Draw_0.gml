if (!visible)
    exit;

draw_set_color(c_dkgray);
draw_set_alpha(0.7);
draw_rectangle(oCamera.X, oCamera.Y, oCamera.X + 80, oCamera.Y + 240, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(global.HUDFont2);
var _y = DrawY;
draw_set_halign(fa_left);

for (var _ItemIndex = 0; _ItemIndex < 49; _ItemIndex++)
{
    switch (_ItemIndex)
    {
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_11:
        case UnknownEnum.Value_12:
        case UnknownEnum.Value_17:
        case UnknownEnum.Value_20:
        case UnknownEnum.Value_25:
        case UnknownEnum.Value_26:
        case UnknownEnum.Value_21:
        case UnknownEnum.Value_29:
        case UnknownEnum.Value_30:
        case UnknownEnum.Value_31:
        case UnknownEnum.Value_32:
        case UnknownEnum.Value_37:
        case UnknownEnum.Value_22:
        case UnknownEnum.Value_42:
        case UnknownEnum.Value_43:
        case UnknownEnum.Value_45:
        case UnknownEnum.Value_47:
            continue;
    }
    
    var _ItemName = string_delete(string_upper(object_get_name(ObjIndexFromItemClass(_ItemIndex))), 1, 6);
    draw_text(DrawX, _y, _ItemName + ": " + string(global.ItemData[_ItemIndex].LimitCount));
    _y += 6;
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_8 = 8,
    Value_11 = 11,
    Value_12,
    Value_17 = 17,
    Value_20 = 20,
    Value_21,
    Value_22,
    Value_25 = 25,
    Value_26,
    Value_29 = 29,
    Value_30,
    Value_31,
    Value_32,
    Value_37 = 37,
    Value_42 = 42,
    Value_43,
    Value_45 = 45,
    Value_47 = 47
}
