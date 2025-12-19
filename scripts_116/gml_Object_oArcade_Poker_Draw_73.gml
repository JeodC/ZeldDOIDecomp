if (State == UnknownEnum.Value_0)
    exit;

surface_copy_part(global.ArcadeVP_Surface, 0, 0, GameSurface, 0, 0, CamW, CamH);
surface_set_target(global.ArcadeVP_Surface);
draw_set_font(global.ArcadeFont);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_color(#B00000);
var RecX1 = 69 + (Bet * 26);
draw_rectangle(RecX1, 2, RecX1 + 22, 57, false);

if (CurrentHand > UnknownEnum.Value_0)
{
    draw_set_halign(fa_left);
    var YPos = 51 - ((CurrentHand - 1) * 6);
    draw_rectangle(5, YPos, 68, YPos + 6, false);
}

draw_set_color(c_white);
draw_set_halign(fa_right);
draw_set_font(global.HUDFont2);

for (var Mul = 0; Mul < 5; Mul++)
{
    for (var i = 0; i < 9; i++)
        draw_text(91 + (Mul * 26), 4 + (i * 6), string(WinMul[9 - i] * (Mul + 1)));
}

draw_set_halign(fa_left);

for (var i = 0; i < 9; i++)
    draw_text(6, 4 + (i * 6), string_upper(Poker_HandString(9 - i)));

draw_set_font(global.ArcadeFont);
draw_set_halign(fa_left);
draw_text(5, CamH - 13, "BALANCE:" + string(global.Inventory_ItemData[UnknownEnum.Value_40].Amount));
var Button1X = 88;
var ButtonsY = 135;
draw_sprite(sPoker_Button_Bet, 0, Button1X, ButtonsY);
draw_set_font(global.HUDFont2);
draw_set_color(c_black);
draw_text(Button1X + 19, ButtonsY + 3, string(Bet + 1));
draw_set_color(c_white);
var Button2X = 125;
draw_sprite(sPoker_Button_Deal, 0, Button2X, ButtonsY);
var Button3X = 162;
draw_sprite(sPoker_Button_Hold, 0, Button3X, ButtonsY);
var CardX = 10;
var CardY = 80;

for (var i = 0; i < 5; i++)
{
    if (Hand[i] > -1)
        draw_sprite(sPoker_Cards, Hand[i], CardX + (i * 37), CardY);
}

switch (State)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_1:
        break;
    
    case UnknownEnum.Value_2:
        draw_set_font(global.ArcadeFont2);
        draw_set_halign(fa_center);
        draw_text(CamW_2, CamH_2 - 13, "VIDEO POKER");
        break;
    
    case UnknownEnum.Value_3:
        break;
    
    case UnknownEnum.Value_4:
        switch (GameState)
        {
            case UnknownEnum.Value_0:
                break;
            
            case UnknownEnum.Value_1:
                break;
            
            case UnknownEnum.Value_2:
                if (CurrentHand > UnknownEnum.Value_0)
                {
                    draw_set_font(global.ArcadeFont);
                    draw_set_halign(fa_center);
                    draw_text(CamW_2, 63, string_upper(CurrentHandStr));
                }
                
                draw_set_font(global.HUDFont2);
                draw_set_halign(fa_left);
                
                for (var i = 0; i < 5; i++)
                {
                    if (HeldCards[i])
                        draw_text(19 + (i * 37), 72, "HELD");
                }
                
                var ArrowX = 22 + (HoldPos * 37);
                var ArrowY = 126;
                draw_sprite(sPoker_Arrow, 0, ArrowX, ArrowY);
                break;
            
            case UnknownEnum.Value_3:
                break;
            
            case UnknownEnum.Value_4:
                break;
        }
        
        break;
    
    case UnknownEnum.Value_5:
        if (GameState == UnknownEnum.Value_4)
        {
            draw_set_font(global.ArcadeFont);
            draw_set_halign(fa_center);
            draw_text(CamW_2, 63, (WinAmount > 0) ? (string_upper(CurrentHandStr) + "! YOU WIN " + string(WinAmount) + "!") : "GAME OVER");
        }
        
        break;
}

surface_reset_target();

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_40 = 40
}
