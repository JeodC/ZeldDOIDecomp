if (instance_exists(ErrorMsgInst))
    exit;

draw_set_halign(fa_left);
var _y = 0;
var _MainTitle = Menu_Title[MenuWin_Main_MenuIndex];
var _OptionsTitle = Menu_Title[MenuWin_Options_MenuIndex];
draw_set_font(MenuWin_Main_Active ? global.MenuFont : global.MenuFont_Innactive);

for (var i = 0; i < Menu_Count[MenuWin_Main_MenuIndex]; i++)
{
    draw_text(inst_100004.x + 32, Menu_Y[MenuWin_Main_MenuIndex][i], Menu[MenuWin_Main_MenuIndex][i]);
    
    switch (MenuWin_Main_MenuIndex)
    {
        case UnknownEnum.Value_0:
            if (i < global.MaxUsers)
                draw_text(inst_100004.x + 43, Menu_Y[MenuWin_Main_MenuIndex][i], global.Users[i].Name);
            
            break;
    }
}

draw_set_font(global.MenuFont);

if (inst_100005.visible)
{
    switch (MenuWin_Options_MenuIndex)
    {
        default:
            for (var i = 0; i < Menu_Count[MenuWin_Options_MenuIndex]; i++)
            {
                switch (MenuWin_Options_MenuIndex)
                {
                    case UnknownEnum.Value_3:
                        if (i == 1)
                            draw_sprite(global.CharacterSprites, global.LinkCharacterIndex, inst_100005.x + 94, Menu_Y[MenuWin_Options_MenuIndex][i] - 6);
                        
                        if (i == 2)
                        {
                            var _SlotIndex = global.StartingGear * 4;
                            var _SprIndex = global.GearSprites[_SlotIndex];
                            var _ImgIndex = global.GearSprites[_SlotIndex + 1];
                            var _SprOffsetX = 0;
                            var _SprOffsetY = global.GearSprites[_SlotIndex + 3];
                            var _PosX = inst_100005.x + 102 + _SprOffsetX;
                            var _PosY = Menu_Y[MenuWin_Options_MenuIndex][i] + 17 + _SprOffsetY;
                            draw_sprite(_SprIndex, _ImgIndex, _PosX, _PosY);
                            
                            switch (_SprIndex)
                            {
                                case sItem_Rupee:
                                    draw_set_font(global.Font_ItemValues);
                                    draw_text(_PosX - 1, _PosY - 6, "100");
                                    draw_set_font(global.MenuFont);
                                    break;
                                
                                case sItem_Bag:
                                    draw_set_font(global.Font_ItemValues);
                                    draw_text(_PosX + 2, _PosY - 7, "+");
                                    draw_set_font(global.MenuFont);
                                    break;
                                
                                case sItem_Rod:
                                    draw_set_font(global.Font_ItemValues);
                                    draw_text(_PosX, _PosY - 6, "16");
                                    draw_set_font(global.MenuFont);
                                    break;
                                
                                case sItem_Food:
                                    draw_set_font(global.Font_ItemValues);
                                    draw_text(_PosX + 3, _PosY - 6, string(StartingGear_Apples));
                                    draw_set_font(global.MenuFont);
                                    break;
                                
                                case sItem_Orb:
                                    draw_set_font(global.Font_ItemValues);
                                    draw_text(_PosX + 3, _PosY - 6, "10");
                                    draw_set_font(global.MenuFont);
                                    break;
                            }
                        }
                        
                        if (i == 3)
                        {
                            for (_ChallengeIndex = 0; _ChallengeIndex < 7; _ChallengeIndex++)
                            {
                                if (global.Challenges[_ChallengeIndex])
                                {
                                    var _PosX = inst_100005.x + 95;
                                    var _PosY = Menu_Y[MenuWin_Options_MenuIndex][i] + 1;
                                    draw_sprite(sCheckbox, 1, _PosX, _PosY);
                                    break;
                                }
                            }
                        }
                        
                        break;
                }
                
                draw_text(inst_100005.x + 32, Menu_Y[MenuWin_Options_MenuIndex][i], Menu[MenuWin_Options_MenuIndex][i]);
                draw_set_font(global.MenuFont);
            }
            
            break;
        
        case UnknownEnum.Value_5:
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            var Chr = 0;
            
            for (_y = 0; _y < global.LetterGridRows; _y++)
            {
                if (_y == (global.LetterGridRows - 1))
                {
                    draw_set_halign(fa_left);
                    draw_set_valign(fa_top);
                }
                
                for (var _x = 0; _x < global.LetterGridColumns; _x++)
                {
                    var Letter = global.NewUserChrMap[Chr];
                    var PosX = LetterGridX + (_x * global.LetterGridSpacingW) + ((_y < (global.LetterGridRows - 1)) ? 3 : 0);
                    var PosY = LetterGridY + (_y * global.LetterGridSpacingH) + ((_y < (global.LetterGridRows - 1)) ? 8 : 0);
                    
                    switch (Letter)
                    {
                        case "!":
                            draw_text(PosX, PosY, "Ok");
                            break;
                        
                        case "@":
                            draw_text(PosX, PosY, "");
                            break;
                        
                        case "#":
                            draw_text(PosX, PosY, "Back");
                            break;
                        
                        case "$":
                            draw_text(PosX, PosY, "");
                            break;
                        
                        default:
                            draw_text(PosX, PosY, Letter);
                            break;
                    }
                    
                    Chr++;
                }
            }
            
            LetterGrid_DrawCrossHair_H();
            LetterGrid_DrawCrossHair_V();
            break;
        
        case UnknownEnum.Value_9:
            for (var i = 0; i < 9; i++)
            {
                var PosX = inst_100005.x + 24 + ((i % 3) * 42);
                var PosY = inst_100005.y + 16 + ((i div 3) * 48);
                draw_sprite(global.CharacterSprites, i, PosX, PosY);
                
                if (i == global.LinkCharacterIndex)
                    draw_sprite(sCharacterSelector, 0, PosX - 3, PosY - 2);
            }
            
            break;
        
        case UnknownEnum.Value_8:
            draw_set_halign(fa_right);
            var PosX = inst_100005.x + 112;
            var PosY = inst_100005.y + 14;
            var Stats = global.Users[global.UserIndex].Stats;
            draw_text(PosX, PosY, "Games Played:");
            PosY += 16;
            draw_text(PosX, PosY, "Games Won:");
            PosY += 16;
            draw_text(PosX, PosY, "Best Time:");
            PosY += 16;
            draw_text(PosX, PosY, "Deaths:");
            PosY += 16;
            draw_text(PosX, PosY, "Monsters Killed:");
            PosY += 16;
            draw_text(PosX, PosY, "Rupees Collected:");
            PosY += 16;
            draw_text(PosX, PosY, "Treasures Opened:");
            PosY += 16;
            draw_set_halign(fa_left);
            PosX = inst_100005.x + 116;
            PosY = inst_100005.y + 14;
            draw_text(PosX, PosY, string(Stats[UnknownEnum.Value_0]));
            PosY += 16;
            draw_text(PosX, PosY, string(Stats[UnknownEnum.Value_1]));
            PosY += 16;
            draw_text(PosX, PosY, (Stats[UnknownEnum.Value_6] == 0) ? "0" : Time_Str(Stats[UnknownEnum.Value_6]));
            PosY += 16;
            draw_text(PosX, PosY, string(Stats[UnknownEnum.Value_2]));
            PosY += 16;
            draw_text(PosX, PosY, string(Stats[UnknownEnum.Value_3]));
            PosY += 16;
            draw_text(PosX, PosY, string(Stats[UnknownEnum.Value_4]));
            PosY += 16;
            draw_text(PosX, PosY, string(Stats[UnknownEnum.Value_5]));
            PosY += 16;
            break;
    }
    
    switch (MenuWin_Options_MenuIndex)
    {
        case UnknownEnum.Value_10:
            for (var _ItemIndex = 0; _ItemIndex < 8; _ItemIndex++)
            {
                var _SlotIndex = _ItemIndex * 4;
                var _SprOffsetX = global.GearSprites[_SlotIndex + 2];
                var _SprOffsetY = global.GearSprites[_SlotIndex + 3];
                var _PosX = inst_100005.x + 123 + _SprOffsetX;
                var _PosY = inst_100005.y + 30 + (_ItemIndex * 16) + _SprOffsetY;
                var _SprIndex = global.GearSprites[_SlotIndex];
                var _ImgIndex = global.GearSprites[_SlotIndex + 1];
                draw_sprite(_SprIndex, _ImgIndex, _PosX, _PosY);
                
                switch (_ItemIndex)
                {
                    case UnknownEnum.Value_1:
                        draw_set_font(global.Font_ItemValues);
                        draw_text(_PosX - 1, _PosY - 6, "100");
                        draw_set_font(global.MenuFont);
                        break;
                    
                    case UnknownEnum.Value_2:
                        draw_set_font(global.Font_ItemValues);
                        draw_text(_PosX + 2, _PosY - 7, "+");
                        draw_set_font(global.MenuFont);
                        break;
                    
                    case UnknownEnum.Value_5:
                        draw_set_font(global.Font_ItemValues);
                        draw_text(_PosX, _PosY - 6, "16");
                        draw_set_font(global.MenuFont);
                        break;
                    
                    case UnknownEnum.Value_6:
                        draw_set_font(global.Font_ItemValues);
                        draw_text(_PosX + 3, _PosY - 6, "10");
                        draw_set_font(global.MenuFont);
                        break;
                }
            }
            
            break;
        
        case UnknownEnum.Value_11:
            for (_ChallengeIndex = 0; _ChallengeIndex < 7; _ChallengeIndex++)
                draw_sprite(global.Challenges[_ChallengeIndex] ? sCheckbox : sCheckBox_Innactive, global.Challenges[_ChallengeIndex] ? 1 : 0, inst_100005.x + 120, inst_100005.y + 31 + (_ChallengeIndex * 16));
            
            if (Selector_Index_Options > 0)
                _OptionsTitle = global.ChallengeTitles[Selector_Index_Options - 1];
            
            break;
        
        case UnknownEnum.Value_13:
            draw_set_halign(fa_right);
            var PosX = inst_100005.x + 136;
            var PosY = inst_100005.y + 14;
            draw_text(PosX, PosY, "Sword:");
            PosY += 16;
            draw_text(PosX, PosY, "Action:");
            PosY += 16;
            draw_text(PosX, PosY, "Item:");
            PosY += 16;
            draw_text(PosX, PosY, "Map:");
            PosY += 16;
            draw_text(PosX, PosY, "Strafe:");
            PosY += 16;
            draw_text(PosX, PosY, "Inventory:");
            PosY += 16;
            draw_text(PosX, PosY, "Menu:");
            PosY += 16;
            draw_text(PosX, PosY, "HUD:");
            PosY += 16;
            draw_set_halign(fa_left);
            PosX = inst_100005.x + 140;
            PosY = inst_100005.y + 14;
            
            for (var i = 0; i < global.BindingIconCount[UnknownEnum.Value_0]; i++)
            {
                if (Bindings_Remap)
                {
                    if (i == global.BindingRemap_VerbIndex)
                        draw_rectangle(PosX, PosY, PosX + 36, PosY + 15, false);
                    else
                        draw_text(PosX, PosY, global.BindingIcons[UnknownEnum.Value_0][i]);
                }
                else
                {
                    draw_text(PosX, PosY, global.BindingIcons[UnknownEnum.Value_0][i]);
                }
                
                PosY += 16;
            }
            
            break;
        
        case UnknownEnum.Value_14:
            draw_set_halign(fa_right);
            var PosX = inst_100005.x + 136;
            var PosY = inst_100005.y + 14;
            draw_text(PosX, PosY, "Sword:");
            PosY += 16;
            draw_text(PosX, PosY, "Action:");
            PosY += 16;
            draw_text(PosX, PosY, "Item:");
            PosY += 16;
            draw_text(PosX, PosY, "Map:");
            PosY += 16;
            draw_text(PosX, PosY, "Strafe:");
            PosY += 16;
            draw_text(PosX, PosY, "Inventory:");
            PosY += 16;
            draw_text(PosX, PosY, "HUD:");
            PosY += 16;
            draw_set_halign(fa_left);
            PosX = inst_100005.x + 140;
            PosY = inst_100005.y + 14;
            
            for (var i = 0; i < global.BindingIconCount[UnknownEnum.Value_1]; i++)
            {
                var BindingIcon = global.BindingIcons[UnknownEnum.Value_1][i];
                BindingIcon = string_replace(BindingIcon, "empty", "");
                
                if (Bindings_Remap)
                {
                    if (i == global.BindingRemap_VerbIndex)
                        draw_rectangle(PosX, PosY, PosX + 36, PosY + 15, false);
                    else
                        draw_text(PosX, PosY, BindingIcon);
                }
                else
                {
                    draw_text(PosX, PosY, BindingIcon);
                }
                
                PosY += 16;
            }
            
            break;
    }
}

if (Menu_Selector[MenuWin_Main_MenuIndex])
    draw_sprite(MenuWin_Main_Active ? sMenu_Selector_Active : sMenu_Selector_Innactive, Selector_Frame, inst_100004.x + 12, Menu_Y[MenuWin_Main_MenuIndex][Selector_Index_Main]);

if (Menu_Active && MenuWin_Options_Active && Menu_Selector[MenuWin_Options_MenuIndex])
    draw_sprite(sMenu_Selector_Active, Selector_Frame, inst_100005.x + 12, Menu_Y[MenuWin_Options_MenuIndex][Selector_Index_Options]);

draw_set_halign(fa_center);
draw_set_font(MenuWin_Main_Active ? global.MenuFont : global.MenuFont_Innactive);
draw_text(inst_100002.x + (inst_100002.W / 2), inst_100002.y + 8.5, _MainTitle);
draw_set_font(global.MenuFont);

if (inst_100003.visible)
    draw_text(inst_100003.x + (inst_100003.W / 2), inst_100003.y + 8.5, _OptionsTitle);

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_8 = 8,
    Value_9,
    Value_10,
    Value_11,
    Value_13 = 13,
    Value_14
}
