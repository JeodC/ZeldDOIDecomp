if (State == UnknownEnum.Value_0)
    exit;

surface_copy_part(global.ArcadeVP_Surface, 0, 0, GameSurface, CamX, 0, CamW, CamH);
surface_set_target(global.ArcadeVP_Surface);
draw_set_font(global.ArcadeFont);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center);

switch (State)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_1:
        break;
    
    case UnknownEnum.Value_2:
        draw_set_font(global.ArcadeFont2);
        draw_text(CamW_2, CamW_3, "PITFALL");
        draw_set_font(global.ArcadeFont);
        draw_text(CamW_2, CamH_2 + 5, "HI-SCORE");
        draw_text(CamW_2, CamH_2 + 15, string(Hiscore));
        draw_set_halign(fa_left);
        draw_text(3, CamH - 10, "CREDITS " + string(Credits));
        draw_set_halign(fa_right);
        
        if (CreditsFlash)
        {
            if (Credits == 0)
                draw_text(CamW - 3, CamH - 10, "INSERT RUPEE");
            else
                draw_text(CamW - 3, CamH - 10, "PRESS START");
        }
        
        break;
    
    case UnknownEnum.Value_3:
        break;
    
    case UnknownEnum.Value_4:
        for (var LifeIndex = 0; LifeIndex < (Harry.Lives - 1); LifeIndex++)
            draw_sprite(sPitfall_Life, 0, 8 + (LifeIndex * 8), 4);
        
        var NewHighScore = (Score > Hiscore) ? "!" : "";
        draw_text(CamW_2, 4, NewHighScore + ScoreText(Score, 6) + NewHighScore);
        break;
    
    case UnknownEnum.Value_5:
        draw_text(CamW_2, CamH_3 + 13, "GAME OVER");
        
        if (ShowNewHiscore)
        {
            draw_text(CamW_2, CamH_2 + 5, "NEW HI-SCORE");
            draw_text(CamW_2, CamH_2 + 15, string(Hiscore));
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
    Value_5
}
