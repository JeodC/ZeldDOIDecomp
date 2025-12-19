function Warp_Create(arg0, arg1, arg2, arg3)
{
    var WarpInst = instance_create_layer(arg1, arg2, "ObjsFloor_" + GetFloorLevelString(arg3), oWarp, 
    {
        RoomIndex: arg0,
        FloorLevel: arg3
    });
    
    if (global.Switch_Add)
    {
        global.Level.Rooms[arg0].Switch.HiddenObjInst = WarpInst;
        WarpInst.visible = false;
        WarpInst.IsSwitchWarp = true;
        
        for (var i = 0; i < 3; i++)
            Lighting_UpdateLight_Visible(arg0, WarpInst.LightIndex[i], false);
    }
    else
    {
        ds_list_add(global.LargeMapItems, WarpInst);
    }
    
    return WarpInst;
}
