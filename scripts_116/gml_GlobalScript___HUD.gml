function ScoreText(arg0, arg1)
{
    var ValueStr = string(arg0);
    return string_repeat("0", arg1 - string_length(ValueStr)) + ValueStr;
}

function HUD_SetPositions(arg0)
{
    with (oHUD)
    {
        if (arg0 == 3)
            MainSide = HUD_Left;
        else
            MainSide = HUD_Right;
        
        MapSide = (MainSide == HUD_Left) ? HUD_Right : HUD_Left;
        SmallMapX = MapSide + 4;
        SmallMapY = 4;
        HeartsTLX = MainSide + 5;
        HeartsTLY = 12;
        HeartsX = array_create(16);
        HeartsY = array_create(16);
        
        for (var i = 0; i < 16; i++)
        {
            HeartsX[i] = HeartsTLX + ((i % 8) * 8);
            HeartsY[i] = HeartsTLY + ((i div 8) * 8);
        }
        
        MMX = MainSide + 4;
        MMY = HeartsTLY + 28;
        ItemX = MainSide + 4;
        ItemY = MMY + 12;
        AttackX = MainSide + 39;
        AttackY = 54;
        DefenseX = MainSide + 60;
        DefenseY = 54;
        RupeesX = MainSide + 38;
        RupeesY = 67;
        ArrowsX = MainSide + 10;
        ArrowsY = 80;
        BombsX = MainSide + 36;
        BombsY = 80;
        KeysX = MainSide + 61;
        KeysY = 80;
        Window1X = MainSide + 3;
        Window1Y = 93;
        SwordX = Window1X + 6;
        SwordY = Window1Y + 3;
        TunicX = Window1X + 26;
        TunicY = Window1Y + 4;
        ShieldX = Window1X + 47;
        ShieldY = Window1Y + 3;
        MapItemX = Window1X + 6;
        MapItemY = Window1Y + 20;
        CompassX = Window1X + 27;
        CompassY = Window1Y + 21;
        GlovesX = Window1X + 47;
        GlovesY = Window1Y + 20;
        MoonPearlX = Window1X + 7;
        MoonPearlY = Window1Y + 40;
        LampX = Window1X + 49;
        LampY = Window1Y + 38;
        MasterKeyX = Window1X + 26;
        MasterKeyY = Window1Y + 37;
        
        for (var i = 0; i < 8; i++)
        {
            PendantsX[i] = MainSide + 6 + ((i % 4) * 15);
            PendantsY[i] = 158 + ((i div 4) * 19);
        }
        
        CrystalsY = 205;
        
        for (var i = 0; i < 3; i++)
            CrystalsX[i] = MainSide + 12 + (i * 19);
        
        DungeonX = MapSide + 2;
        DungeonY = 73;
        DungeonLinkX = DungeonX + 12;
        DungeonLinkY = DungeonY + 31;
        DungeonIconsX = DungeonX + 26;
        DungeonIconsX_Save = DungeonIconsX + 23;
        DungeonIconsY[0] = DungeonY + 26;
        DungeonIconsY[1] = DungeonIconsY[0] + 40;
        DungeonIconsY[2] = DungeonIconsY[1] + 40;
        DungeonIconsY[3] = DungeonIconsY[1] - 10;
        DungeonIconsY[4] = DungeonIconsY[2] - 10;
        DungeonIconsY[5] = DungeonIconsY[0] + 4;
        DungeonIconsY[6] = DungeonIconsY[5] + 20;
        DungeonIconsY[7] = DungeonIconsY[6] + 20;
        DungeonIconsY[8] = DungeonIconsY[7] + 20;
        DungeonIconsY[9] = DungeonIconsY[8] + 20;
    }
}

function HUD_DungeonLinkY()
{
    return DungeonY + 23 + (max(global.Level.Index - 1, 0) * 10) + (global.SaveLevel ? 4 : 0) + ((global.Level.Index == UnknownEnum.Value_13) ? 5 : 0);
}

enum UnknownEnum
{
    Value_13 = 13
}
