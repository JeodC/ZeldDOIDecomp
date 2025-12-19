function Switch_Activate(arg0, arg1)
{
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            with (oDoor)
            {
                if (RoomIndex == global.CurrentRoomIndex && Status == UnknownEnum.Value_1 && !Entrance)
                    Open = true;
            }
            
            return true;
            break;
        
        case UnknownEnum.Value_2:
            if (arg1 == -4)
                break;
            
            arg1.visible = true;
            audio_play_sound(Sound_ChestAppear, 1, false);
            
            switch (global.Level.Rooms[arg1.RoomIndex].Switch.HiddenObjType)
            {
                case UnknownEnum.Value_1:
                    arg1.WallInst.BlockLink = true;
                    arg1.WallInst.BlockProjectiles = true;
                    arg1.WallInst.BlockEnemies = true;
                    arg1.IsSwitchTreasure = false;
                    arg1.sprite_index = sItem_Treasure;
                    return true;
                
                case UnknownEnum.Value_2:
                    arg1.WallInst.BlockLink = true;
                    arg1.WallInst.BlockProjectiles = true;
                    arg1.WallInst.BlockEnemies = true;
                    arg1.IsSwitchCrystal = false;
                    arg1.sprite_index = sCrystalSwitch;
                    Crystal_CreateLight(arg1);
                    arg1.alarm[1] = 1;
                    ds_list_add(global.LargeMapItems, arg1);
                    return true;
                
                case UnknownEnum.Value_3:
                    arg1.IsSwitchWarp = false;
                    
                    for (var i = 0; i < 3; i++)
                        Lighting_UpdateLight_Visible(RoomIndex, arg1.LightIndex[i], true);
                    
                    ds_list_add(global.LargeMapItems, arg1);
                    return true;
                
                case UnknownEnum.Value_4:
                    return true;
            }
            
            break;
    }
    
    return false;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_4
}
