switch (State)
{
    case UnknownEnum.Value_1:
        if (DialogueActive)
        {
            if (!instance_exists(global.DB_Inst))
            {
                if (DialogueIndex < array_length(Dialogue))
                    alarm[4] = 45;
                else
                    Intro_ShowLink();
            }
        }
        
        break;
    
    case UnknownEnum.Value_2:
        DarkScreenAlpha -= 0.075;
        
        if (DarkScreenAlpha <= 0)
        {
            DarkScreenAlpha = 0;
            oHUD.ShowLevelName = true;
            State = UnknownEnum.Value_3;
        }
        
        break;
    
    case UnknownEnum.Value_3:
        if (!CreatedWall && oLink.State != UnknownEnum.Value_5)
        {
            oLink.Castle_EntranceWallInst = WallObj_Create("Objs_Upper", oCamera.X, oCamera.Y + 212, 32, 4);
            CreatedWall = true;
        }
        
        if (!oCastleWallDoor.Opened)
        {
            if (!NoMoreBombs && instance_number(oBush) == 0 && instance_number(oBush_Destroy) == 0 && instance_number(oItem_Bombs) == 0 && instance_number(oBomb) == 0 && instance_number(oBombExplosion) == 0 && global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] == 0)
            {
                MsgBox(NoMoreBombsText);
                NoMoreBombs = true;
            }
        }
        
        break;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_5 = 5
}
