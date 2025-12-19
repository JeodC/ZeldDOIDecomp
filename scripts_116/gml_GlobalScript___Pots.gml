function Pot_Create(arg0, arg1, arg2, arg3, arg4 = false)
{
    var FloorLevelStr = GetFloorLevelString(arg1, arg2);
    var FloorLevel = GetFloorLevelID(FloorLevelStr);
    var WaterLevelTMID = GetFloorLevelTMID("Tiles_Water", arg1, arg2);
    var LayerDoors = "ObjsDoors_" + FloorLevelStr;
    var LayerFloor = "ObjsFloor_" + FloorLevelStr;
    DrawTileBlock(WaterLevelTMID, arg1, arg2, 1, 2, 2, 2);
    
    if (global.Switch_Add && (global.Level.Rooms[arg0].Switch.Type == UnknownEnum.Value_2 || global.Level.Rooms[arg0].Switch.Type == UnknownEnum.Value_3))
    {
        global.Level.Rooms[arg0].Switch.Inst = instance_create_layer(arg1, arg2, LayerFloor, oFloorSwitch);
        global.Level.Rooms[arg0].Switch.Inst.Action = global.Level.Rooms[arg0].Switch.Action;
        global.Level.Rooms[arg0].Switch.Inst.RoomIndex = arg0;
        global.Switch_Add = false;
        arg3 = -1;
    }
    
    var PotInst = instance_create_layer(arg1 + 8, arg2 + 12, LayerDoors, oPot);
    
    if (arg3 != -1)
        PotInst.ContentsObj = arg3;
    
    PotInst.Index = global.Level.PotStyle;
    PotInst.FloorLevel = FloorLevel;
    PotInst.InSection = arg4;
    var WallInst = WallObj_Create(LayerFloor, arg1, arg2, 2, 2);
    WallInst.FloorLevel = FloorLevel;
    WallInst.BlockItems = false;
    WallInst.BlockProjectiles = false;
    PotInst.WallObj = WallInst;
    return PotInst;
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3
}
