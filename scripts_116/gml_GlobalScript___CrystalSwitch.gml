function Crystal_Create(arg0, arg1, arg2)
{
    var FloorLevelStr = GetFloorLevelString(arg1, arg2);
    var Layer = "ObjsFloor_" + FloorLevelStr;
    var inst = instance_create_layer(arg1 + 8, arg2 + 16, Layer, oCrystalSwitch, 
    {
        RoomIndex: arg0
    });
    inst.WallInst = WallObj_Create(Layer, arg1, arg2, 2, 2);
    inst.WallInst.FloorLevel = GetFloorLevelID(FloorLevelStr);
    
    if (global.Switch_Add)
    {
        global.Level.Rooms[arg0].Switch.HiddenObjInst = inst;
        inst.visible = false;
        inst.IsSwitchCrystal = true;
        inst.WallInst.BlockLink = false;
        inst.WallInst.BlockEnemies = false;
        inst.WallInst.BlockProjectiles = false;
        inst.WallInst.IsHiddenObj = true;
        inst.alarm[1] = -1;
    }
    else
    {
        Crystal_CreateLight(inst);
        ds_list_add(global.LargeMapItems, inst);
    }
    
    return inst;
}

function Crystal_CreateLight(arg0)
{
    with (arg0)
    {
        LightID = Lighting_CreateLight(RoomIndex, x, y - 8, 0.9, RedColor);
        Crystal_UpdateLightColor();
    }
}

function Crystal_UpdateLightColor()
{
    image_index = global.Level.SwitchBlock_ActiveColor;
    
    switch (image_index)
    {
        case 0:
            Lighting_UpdateLight_RGB(RoomIndex, LightID, RedColor);
            break;
        
        case 1:
            Lighting_UpdateLight_RGB(RoomIndex, LightID, BlueColor);
            break;
    }
}
