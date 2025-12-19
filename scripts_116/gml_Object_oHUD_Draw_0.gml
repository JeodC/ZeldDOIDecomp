if (global.Level.Index == UnknownEnum.Value_0)
    MainAlpha = 1 - oIntro.DarkScreenAlpha;

draw_set_color(c_white);
draw_set_alpha(MainAlpha);

if (ShowLevelName)
{
    draw_set_halign(fa_center);
    draw_set_font(global.HUDFont);
    draw_set_alpha(ShowLevelName_Alpha);
    draw_text(oCamera.X + 128, oCamera.Y + 100, global.DungeonNames[global.Level.Index]);
    draw_set_alpha(1);
}

draw_set_halign(fa_left);
draw_set_font(global.FontNumbers);

if (!global.Users[global.UserIndex].Prefs[UnknownEnum.Value_2])
    exit;

draw_sprite_ext(sHUD_Life, 0, MainSide + 15, 3, 1, 1, 0, HealthLowPulseColor, 1);
var _HeartIndex;

for (_HeartIndex = 0; _HeartIndex < global.Inventory_ItemData[UnknownEnum.Value_18].Amount; _HeartIndex++)
    draw_sprite_ext(sHUD_Heart, 0, HeartsX[_HeartIndex], HeartsY[_HeartIndex], 1, 1, 0, HealthLowPulseColor, 1);

var _HealthToDraw = max(global.Inventory_ItemData[UnknownEnum.Value_17].Amount - AddHealth, 0);
var _FullHearts = floor(_HealthToDraw);

for (_HeartIndex = 0; _HeartIndex < _FullHearts; _HeartIndex++)
    draw_sprite_ext(sHUD_Heart, 4, HeartsX[_HeartIndex], HeartsY[_HeartIndex], 1, 1, 0, HealthLowPulseColor, 1);

_HealthToDraw -= _FullHearts;

if (_HealthToDraw > 0)
{
    var _HeartValue = (_HealthToDraw < 0.25) ? 1 : clamp(floor(_HealthToDraw * 4), 0, 3);
    draw_sprite_ext(sHUD_Heart, _HeartValue, HeartsX[_HeartIndex], HeartsY[_HeartIndex], 1, 1, 0, HealthLowPulseColor, 1);
}

draw_sprite(sHUD_Magic, 0, MainSide + 2, 31);
draw_sprite_stretched(sHUD_MagicMeterLiquid, 0, MMX, MMY, MagicW, 6);
draw_sprite(sHUD_Items, 0, MainSide + 4, 52);

if (global.Inventory_SlotIndex_Equiped != -1)
{
    var _ItemEquiped = global.Inventory[global.Inventory_SlotIndex_Equiped];
    
    if (_ItemEquiped != -1)
    {
        var _ItemClass = _ItemEquiped.ItemClass;
        
        switch (_ItemClass)
        {
            case UnknownEnum.Value_4:
                _ItemClass = UnknownEnum.Value_5;
                break;
        }
        
        var _ObjIndex = ObjIndexFromItemClass(_ItemClass);
        
        if (_ObjIndex != -1)
        {
            var SprInd = object_get_sprite(_ObjIndex);
            var ItemInd = _ItemEquiped.ItemIndex;
            Offset = Inventory_GetPosOffset(SprInd, ItemInd);
            var _x = ItemX + Offset[0] + 3;
            var _y = ItemY + Offset[1] + 2;
            draw_sprite(SprInd, ItemInd, _x, _y);
            var _DrawAmount, _ItemAmount;
            
            if (_ItemClass == UnknownEnum.Value_5 && global.Inventory_ItemData[UnknownEnum.Value_4].Owns[0])
            {
                _ItemAmount = global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0];
                _DrawAmount = true;
            }
            else
            {
                _ItemAmount = _ItemEquiped.Amount;
                _DrawAmount = global.ItemData[_ItemClass].Type == UnknownEnum.Value_4 || global.Inventory[global.Inventory_SlotIndex_Equiped].Amount > 1;
            }
            
            if (_DrawAmount)
            {
                draw_set_font(global.Font_ItemValues);
                draw_set_halign(fa_right);
                draw_text(ItemX + 19, ItemY + 12, string(_ItemAmount));
                draw_set_halign(fa_left);
            }
        }
    }
}

draw_set_font(global.FontNumbers);

if (global.Inventory_ItemData[UnknownEnum.Value_21].Owns[0])
    draw_sprite(sHUD_Infinite, 0, KeysX, KeysY + 1);
else
    draw_text(KeysX, KeysY, string(global.Inventory_ItemData[UnknownEnum.Value_20].Amount));

draw_text(RupeesX, RupeesY, RupeesStr);
draw_set_color(AttackColor);
draw_text(oHUD.AttackX, oHUD.AttackY, string(oLink.AttackPoints));
draw_set_color(DefenseColor);
draw_text(oHUD.DefenseX, oHUD.DefenseY, string(oLink.DefensePoints));
draw_set_color(ArrowsColor);
draw_text(ArrowsX, ArrowsY, ScoreText(global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0], 2));
draw_set_color(BombsColor);
draw_text(BombsX, BombsY, ScoreText(global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0], 2));
draw_set_color(c_white);
draw_sprite(sHUD_Side1, 0, MainSide + 3, 92);
draw_sprite(sHUD_Side2, 0, MapSide + 2, 2);
draw_sprite(sHUD_Sword, global.Inventory_ItemData[UnknownEnum.Value_44].Index + 1, SwordX, SwordY);
draw_sprite(sHUD_Tunic, global.Inventory_ItemData[UnknownEnum.Value_46].Index, TunicX, TunicY);
draw_sprite(sHUD_Shield, global.Inventory_ItemData[UnknownEnum.Value_41].Index + 1, ShieldX, ShieldY);
draw_sprite(sHUD_Map, DrawMap ? 1 : 0, MapItemX, MapItemY);
draw_sprite(sHUD_Compass, DrawCompass ? 1 : 0, CompassX, CompassY);
draw_sprite(sHUD_Gloves, global.Inventory_ItemData[UnknownEnum.Value_16].Index + 1, GlovesX, GlovesY);
draw_sprite(sHUD_MoonPearl, global.Inventory_ItemData[UnknownEnum.Value_31].Owns[0] ? (global.Level.SwitchBlock_ActiveColor + 1) : 0, MoonPearlX, MoonPearlY);
draw_sprite(sHUD_MasterKey, global.Inventory_ItemData[UnknownEnum.Value_21].Owns[0] ? 1 : 0, MasterKeyX, MasterKeyY);

if (ShowLamp)
{
    if (global.Inventory_ItemData[UnknownEnum.Value_24].Owns[0])
        draw_sprite(sHUD_Lamp, 0, LampX, LampY);
    else
        draw_sprite(sHUD_Candle, 1, LampX, LampY);
}
else
{
    draw_sprite(sHUD_Candle, 0, LampX, LampY);
}

for (var i = 0; i < 8; i++)
    draw_sprite(global.Inventory_ItemData[UnknownEnum.Value_34].Owns[i] ? sHUD_Pendents : sHUD_Pendents_Grey, i, oHUD.PendantsX[i], oHUD.PendantsY[i]);

for (var i = 0; i < 3; i++)
    draw_sprite(sHUD_Crystal, (ShowCrystals && i <= (oHUD.BossesDefeated - 1)) ? 1 : 0, CrystalsX[i], CrystalsY);

for (var i = oHUD.BossesDefeated; i < 3; i++)
    draw_sprite(sHUD_DungeonIcons, 0, oHUD.DungeonIconsX, oHUD.DungeonIconsY[i]);

draw_sprite(sHUD_DungeonIcons, 1, oHUD.DungeonIconsX, oHUD.DungeonIconsY[3]);
draw_sprite(sHUD_DungeonIcons, 2, oHUD.DungeonIconsX, oHUD.DungeonIconsY[4]);

for (var i = 5; i <= 9; i++)
    draw_sprite(sHUD_DungeonIcons, 3, oHUD.DungeonIconsX_Save, oHUD.DungeonIconsY[i]);

draw_sprite(global.LinkSpr_DungeonIcon, 0, DungeonLinkX, DungeonLinkY);

if (!global.MapHidden)
{
    if (DrawMap)
        draw_sprite_ext(global.Level.Map_Sprite_All, 0, SmallMapX, SmallMapY, 0.25, 0.25, 0, c_white, MainAlpha);
    
    draw_sprite_ext(global.Level.Map_Sprite_Explored, 0, SmallMapX, SmallMapY, 0.25, 0.25, 0, c_white, MainAlpha);
    
    if (DrawCompass)
    {
        draw_sprite_ext(global.Level.Map_Sprite_Doors_Explored, 0, SmallMapX, SmallMapY, 0.25, 0.25, 0, c_white, MainAlpha);
        
        if (DrawMap)
            draw_sprite_ext(global.Level.Map_Sprite_Doors_All, 0, SmallMapX, SmallMapY, 0.25, 0.25, 0, c_white, MainAlpha);
    }
    
    draw_sprite(sLinkMap, 0, (SmallMapX + Map_GetCoordinate_Small(oLink.House_Inside ? oLink.House_OldX : oLink.x)) - 0.5, (SmallMapY + Map_GetCoordinate_Small(oLink.House_Inside ? oLink.House_OldY : oLink.y)) - 0.5);
}

draw_set_alpha(1);

with (oAghanim_End)
{
    if (Exiting)
    {
        draw_set_alpha(ExitFade);
        draw_set_color(c_black);
        draw_rectangle(oHUD.HUD_Left, 0, 0, oCamera.H, false);
    }
    
    draw_set_alpha(1);
    draw_set_color(c_white);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4,
    Value_5,
    Value_16 = 16,
    Value_17,
    Value_18,
    Value_20 = 20,
    Value_21,
    Value_24 = 24,
    Value_31 = 31,
    Value_34 = 34,
    Value_41 = 41,
    Value_44 = 44,
    Value_46 = 46
}
