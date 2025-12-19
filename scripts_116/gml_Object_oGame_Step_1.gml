AltTabCheck();

if (input_check_pressed("hud"))
{
    global.Users[global.UserIndex].Prefs[UnknownEnum.Value_2] = !global.Users[global.UserIndex].Prefs[UnknownEnum.Value_2];
    User_Save();
}

var NormalLinkState = !global.ArcadeVP_Show && (oLink.State == UnknownEnum.Value_1 || oLink.State == UnknownEnum.Value_2 || oLink.State == UnknownEnum.Value_24) && !global.LinkDead && oLink.State != UnknownEnum.Value_4;

if (NormalLinkState && !global.FinalBoss)
{
    if (input_check_pressed("inventory") && !input_check("action"))
    {
        if (!instance_exists(oDialogueBox) && global.DB_Inst == -4)
        {
            if (!instance_exists(oMap) && !instance_exists(oMenu_Game) && oCamera.RoomTransition == 0)
            {
                if (instance_exists(oInventory))
                {
                    global.InventoryInst.Close = true;
                }
                else
                {
                    global.InventoryInst = instance_create_layer(0, 0, layer, oInventory);
                    
                    with (oLink)
                        UpdateState(UnknownEnum.Value_24);
                }
            }
        }
    }
    
    if (input_check_pressed("map"))
    {
        if (!instance_exists(oDialogueBox) && global.DB_Inst == -4)
        {
            if (!instance_exists(oInventory) && !instance_exists(oMenu_Game) && oCamera.RoomTransition == 0)
            {
                if (instance_exists(oMap))
                {
                    if (!global.MapInst.Open)
                    {
                        global.MapInst.Close = true;
                        audio_play_sound(Sound_Throw, 1, false);
                    }
                }
                else
                {
                    global.MapInst = instance_create_layer(0, 0, layer, oMap);
                    
                    with (oLink)
                        UpdateState(UnknownEnum.Value_24);
                }
            }
        }
    }
}

if (NormalLinkState)
{
    if (input_check_pressed("menu_access") || global.AltTab)
    {
        if (!instance_exists(oDialogueBox) && !instance_exists(oInventory) && !instance_exists(oMap) && oCamera.RoomTransition == 0)
        {
            if (!instance_exists(oMenu_Game))
            {
                global.MenuInst = instance_create_layer(0, 0, layer, oMenu_Game);
                
                with (oLink)
                    UpdateState(UnknownEnum.Value_24);
            }
        }
    }
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_4 = 4,
    Value_24 = 24
}
