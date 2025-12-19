draw_set_alpha(Alpha / 2.2);
draw_set_color(c_black);
draw_rectangle(oCamera.X, oCamera.Y, (oCamera.X + oCamera.W) - 1, (oCamera.Y + oCamera.H) - 1, false);
draw_set_alpha(Alpha);
draw_set_color(c_white);
draw_sprite_stretched(sprite_index, 0, X, Y, W, H);

if (global.Inventory_ShowGems)
    draw_sprite_stretched(sHUD_Window_Inventory_Gems, 0, X_Gems, Y, W_Gems, H_Gems);

draw_set_font(global.HUDFont2);
draw_set_halign(fa_center);
draw_text(X + 30, Y + 10, "LEVEL " + string(global.Inventory_ItemData[UnknownEnum.Value_2].Index + 1));
draw_set_color(#E8B000);
draw_text(X + 30, Y + 17, "INVENTORY");
draw_set_color(c_white);
draw_sprite(sItem_Bag, global.Inventory_ItemData[UnknownEnum.Value_2].Index, SlotPositionsX[2] + 10, Y + 24);

for (var i = 0; i < Slots; i++)
{
    if (global.Inventory[i].Enabled)
    {
        draw_sprite(sInventory_Slot, 0, SlotPositionsX[i], SlotPositionsY[i]);
    }
    else
    {
        switch (i)
        {
            case global.Inventory_SlotIndex_ArrowQuiver:
                draw_sprite(sInventory_TopItem_ArrowQuiver, 0, SlotPositionsX[i] + 10, Y + 23);
                break;
            
            case global.Inventory_SlotIndex_BombBag:
                draw_sprite(sInventory_TopItem_BombBag, 0, SlotPositionsX[i] + 10, Y + 24);
                break;
            
            case global.Inventory_SlotIndex_GemBag:
                draw_sprite(sInventory_TopItem_GemBag, 0, SlotPositionsX[i] + 10, Y + 24);
                break;
        }
    }
}

if (global.Inventory_ShowGems)
{
    var _Slots = 6;
    
    for (var i = 0; i < _Slots; i++)
        draw_sprite(sInventory_Slot, 0, SlotPositionsX_Gems[i], SlotPositionsY_Gems[i]);
}

draw_set_halign(fa_left);

for (var i = 0; i <= global.Inventory_SlotIndex_Last; i++)
{
    if (global.Inventory_ShowGems)
    {
        if (i >= Slots && i < global.Inventory_SlotIndex_Gems)
            continue;
    }
    else if (i >= Slots)
    {
        continue;
    }
    
    var _ItemClass = global.Inventory[i].ItemClass;
    var _ItemIndex = global.Inventory[i].ItemIndex;
    
    if (_ItemClass == -1)
        continue;
    
    var _SprInd;
    
    switch (_ItemClass)
    {
        case UnknownEnum.Value_44:
            _SprInd = sItem_Sword_Inventory;
            break;
        
        default:
            _SprInd = object_get_sprite(ObjIndexFromItemClass(_ItemClass));
            break;
    }
    
    switch (_ItemClass)
    {
        case UnknownEnum.Value_31:
            _ItemIndex = global.Level.SwitchBlock_ActiveColor;
            break;
    }
    
    _SlotPositionX = (i >= global.Inventory_SlotIndex_Gems) ? SlotPositionsX_Gems[i - global.Inventory_SlotIndex_Gems] : SlotPositionsX[i];
    _SlotPositionY = (i >= global.Inventory_SlotIndex_Gems) ? SlotPositionsY_Gems[i - global.Inventory_SlotIndex_Gems] : SlotPositionsY[i];
    Offset = Inventory_GetPosOffset(_SprInd, _ItemIndex);
    var DrawItemX = _SlotPositionX + Offset[0] + 2;
    var DrawItemY = _SlotPositionY + Offset[1] + 1;
    draw_sprite(_SprInd, _ItemIndex, DrawItemX, DrawItemY);
    var _DrawAmount, _ItemAmount;
    
    if (_ItemClass == UnknownEnum.Value_0 && global.Inventory_ItemData[UnknownEnum.Value_0].Owns[0])
    {
        _ItemAmount = global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0];
        _DrawAmount = true;
    }
    else if (_ItemClass == UnknownEnum.Value_4 && global.Inventory_ItemData[UnknownEnum.Value_4].Owns[0])
    {
        _ItemAmount = global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0];
        _DrawAmount = true;
    }
    else if (_ItemClass == UnknownEnum.Value_15 && global.Inventory_ItemData[UnknownEnum.Value_15].Owns[0])
    {
        _ItemAmount = GemBagCount;
        _DrawAmount = true;
    }
    else
    {
        _ItemAmount = global.Inventory[i].Amount;
        _DrawAmount = global.ItemData[_ItemClass].Type == UnknownEnum.Value_4 || global.Inventory[i].Amount > 1;
    }
    
    draw_set_halign(fa_right);
    
    if (_DrawAmount)
    {
        draw_set_font(global.Font_ItemValues);
        draw_text(_SlotPositionX + 18, _SlotPositionY + 11, (_ItemAmount == 0) ? "O" : string(_ItemAmount));
    }
    
    draw_set_halign(fa_left);
}

var _SlotPositionX = (global.Inventory_SlotIndex_Selected >= global.Inventory_SlotIndex_Gems) ? SlotPositionsX_Gems[global.Inventory_SlotIndex_Selected - global.Inventory_SlotIndex_Gems] : SlotPositionsX[global.Inventory_SlotIndex_Selected];
var _SlotPositionY = (global.Inventory_SlotIndex_Selected >= global.Inventory_SlotIndex_Gems) ? SlotPositionsY_Gems[global.Inventory_SlotIndex_Selected - global.Inventory_SlotIndex_Gems] : SlotPositionsY[global.Inventory_SlotIndex_Selected];
draw_sprite_stretched(sInventory_Selection, 0, _SlotPositionX, _SlotPositionY, 20, 20);
draw_set_font(global.HUDFont2);
draw_set_color(c_dkgray);
draw_text(MenuX, MenuY, MenuStr);
draw_set_color(c_white);

if (MenuEnable)
{
    for (var i = 0; i < MenuItems; i++)
    {
        if (ds_grid_get(MenuItemGrid, 1, i))
            draw_text(MenuX + MenuItemPos[i], MenuY, ds_grid_get(MenuItemGrid, 0, i));
    }
    
    draw_sprite_stretched(sInventory_Selection, 0, (MenuX + MenuItemPos[MenuSelectionIndex]) - 2, MenuY - 2, MenuItemW[MenuSelectionIndex] + 3, 9);
}

if (instance_exists(oDialogueBox) || DB_Init || DB_Started)
    exit;

if (global.Cursed)
{
    var TextX = X_Cursed + 116;
    draw_sprite_stretched(sHUD_Window_Curse, 0, X_Cursed, Y_Curse, 232, 52);
    draw_set_color(#E00000);
    draw_set_font(global.HUDFont2);
    draw_set_halign(fa_center);
    draw_text(TextX, Y_Curse + 12, "YOU ARE CURSED!");
    draw_set_color(c_white);
    draw_text(TextX, Y_Curse + 24, "EFFECT: " + string_upper(string_replace(global.CurseEffectStr, "\\", " ")));
    draw_text(TextX, Y_Curse + 34, "TASK: " + string_upper(string_replace(global.CurseTaskStr, "\\", " ")) + "  (" + string(global.CurseTaskCount) + " REMAINING)");
    draw_set_halign(fa_left);
}

draw_set_alpha(1);

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4,
    Value_5,
    Value_15 = 15,
    Value_31 = 31,
    Value_44 = 44
}
