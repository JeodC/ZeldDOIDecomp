function INIT()
{
    math_set_epsilon(0.000001);
    randomize();
    Data_InitGlobals();
    Dungeon_LoadTemplates();
    RoomTemplates_Load();
    Items_InitData();
    Inventory_InitData();
    Enemies_InitData();
    RupeePatterns_Init();
    PixelRender_Init();
    Music_InitData();
}

function Data_InitGlobals()
{
    Data_InitDoorCoordinates();
    global.RoomSizeIndex[1][1] = UnknownEnum.Value_0;
    global.RoomSizeIndex[1][2] = UnknownEnum.Value_1;
    global.RoomSizeIndex[2][1] = UnknownEnum.Value_2;
    global.RoomSizeIndex[2][2] = UnknownEnum.Value_3;
    global.VillageLightingMap[0] = [1, 1, 1, 1, 0, 0, 0, 0];
    global.VillageLightingMap[1] = [1, 1, 1, 1, 0, 0, 1, 1];
    global.VillageLightingMap[2] = [1, 0, 0, 0, 0, 0, 0, 1];
    global.VillageLightingMap[3] = [1, 0, 0, 0, 0, 0, 0, 1];
    global.VillageLightingMap[4] = [1, 0, 0, 0, 0, 0, 0, 0];
    global.VillageLightingMap[5] = [1, 0, 0, 0, 0, 0, 0, 0];
    global.VillageLightingMap[6] = [0, 1, 0, 0, 0, 0, 1, 0];
    global.VillageLightingMap[7] = [0, 0, 0, 0, 0, 0, 0, 0];
    global.MainTemplates_Mine[0] = [-1, -1, -1, -1, -1, -1, 0, -1];
    global.MainTemplates_Mine[1] = [-1, -1, -1, -1, -1, 1, 0, -1];
    global.MainTemplates_Mine[2] = [-1, -1, -1, 2, 2, 3, 3, 4];
    global.MainTemplates_Mine[3] = [-1, -1, -1, 2, 2, 3, 3, -1];
    global.MainTemplates_Mine[4] = [8, 9, 10, 11, 5, 6, 6, 12];
    global.MainTemplates_Mine[5] = [13, 14, 15, 16, 17, 18, 19, 20];
    global.MainTemplates_Mine[6] = [21, 22, 23, 24, 25, 26, 27, 28];
    global.MainTemplates_Mine[7] = [29, 30, 31, 32, 33, 34, 35, 36];
    global.LargeMapItems = ds_list_create();
    global.UnusedPrisoners = ds_list_create();
    global.UnusedShopKeepers = ds_list_create();
    InitGemPrizes();
    global.Continue = false;
    global.SaveLevel = false;
    global.ContinueLevel = 0;
    global.CrashSoundID = 0;
    global.InWaterSprite = sInWater;
    var i = 0;
    global.DungeonNames[i++] = "Destroy Agahnim";
    global.DungeonNames[i++] = "Hyrule Castle";
    global.DungeonNames[i++] = "Castle Basement";
    global.DungeonNames[i++] = "Castle Prison";
    global.DungeonNames[i++] = "Catacombs";
    global.DungeonNames[i++] = "Sewers";
    global.DungeonNames[i++] = "Rebel Village";
    global.DungeonNames[i++] = "Lanmola's Lair";
    global.DungeonNames[i++] = "Ancient Ruins";
    global.DungeonNames[i++] = "Water Temple";
    global.DungeonNames[i++] = "Dwarven Mining Town";
    global.DungeonNames[i++] = "Moldorm's Lair";
    global.DungeonNames[i++] = "Agahnim's Fortress";
    global.DungeonNames[i++] = "Agahnim";
}

function InitLayers()
{
    global.LayerID_System = layer_get_id("System");
    global.LayerID_ObjsHighest = layer_get_id("ObjsHighest");
    global.LayerID_Tiles_Ceiling = layer_get_id("Tiles_Ceiling");
    global.LayerID_Tiles_Highest = layer_get_id("Tiles_Highest");
    global.LayerID_ObjsHigher_Upper = layer_get_id("ObjsHigher_Upper");
    global.LayerID_Tiles_Higher = layer_get_id("Tiles_Higher");
    global.LayerID_Objs_Upper = layer_get_id("Objs_Upper");
    global.LayerID_ObjsFloor_Upper = layer_get_id("ObjsFloor_Upper");
    global.LayerID_ObjsDoors_Upper = layer_get_id("ObjsDoors_Upper");
    global.LayerID_Tiles_Decor_Upper = layer_get_id("Tiles_Decor_Upper");
    global.LayerID_Tiles_Walls_Upper = layer_get_id("Tiles_Walls_Upper");
    global.LayerID_Tiles_StairMonumentsDecor = layer_get_id("Tiles_StairMonumentsDecor");
    global.LayerID_Tiles_StairMonuments = layer_get_id("Tiles_StairMonuments");
    global.LayerID_Tiles_Water_Upper = layer_get_id("Tiles_Water_Upper");
    global.LayerID_Tiles_Floor_Upper = layer_get_id("Tiles_Floor_Upper");
    global.LayerID_ObjsHigher_Lower = layer_get_id("ObjsHigher_Lower");
    global.LayerID_Objs_Lower = layer_get_id("Objs_Lower");
    global.LayerID_ObjsFloor_Lower = layer_get_id("ObjsFloor_Lower");
    global.LayerID_ObjsDoors_Lower = layer_get_id("ObjsDoors_Lower");
    global.LayerID_Tiles_Decor_Lower = layer_get_id("Tiles_Decor_Lower");
    global.LayerID_Tiles_Walls_Lower = layer_get_id("Tiles_Walls_Lower");
    global.LayerID_Tiles_Water_Lower = layer_get_id("Tiles_Water_Lower");
    global.LayerID_Tiles_Floor_Lower = layer_get_id("Tiles_Floor_Lower");
    global.LayerID_Tiles_Pit = layer_get_id("Tiles_Pit");
    global.LayerID_Tiles_Lava = layer_get_id("Tiles_Lava");
    global.LayerID_Starfield = layer_get_id("Starfield");
    global.TMID_Tiles_Ceiling = layer_tilemap_get_id(global.LayerID_Tiles_Ceiling);
    global.TMID_Tiles_Highest = layer_tilemap_get_id(global.LayerID_Tiles_Highest);
    global.TMID_Tiles_Higher = layer_tilemap_get_id(global.LayerID_Tiles_Higher);
    global.TMID_Decor_Upper = layer_tilemap_get_id(global.LayerID_Tiles_Decor_Upper);
    global.TMID_Walls_Upper = layer_tilemap_get_id(global.LayerID_Tiles_Walls_Upper);
    global.TMID_StairMonumentsDecor = layer_tilemap_get_id(global.LayerID_Tiles_StairMonumentsDecor);
    global.TMID_StairMonuments = layer_tilemap_get_id(global.LayerID_Tiles_StairMonuments);
    global.TMID_Water_Upper = layer_tilemap_get_id(global.LayerID_Tiles_Water_Upper);
    global.TMID_Floor_Upper = layer_tilemap_get_id(global.LayerID_Tiles_Floor_Upper);
    global.TMID_Decor_Lower = layer_tilemap_get_id(global.LayerID_Tiles_Decor_Lower);
    global.TMID_Walls_Lower = layer_tilemap_get_id(global.LayerID_Tiles_Walls_Lower);
    global.TMID_Water_Lower = layer_tilemap_get_id(global.LayerID_Tiles_Water_Lower);
    global.TMID_Floor_Lower = layer_tilemap_get_id(global.LayerID_Tiles_Floor_Lower);
    global.TMID_Pit = layer_tilemap_get_id(global.LayerID_Tiles_Pit);
    global.TMID_Lava = layer_tilemap_get_id(global.LayerID_Tiles_Lava);
    global.TMID[UnknownEnum.Value_0] = global.TMID_Lava;
    global.TMID[UnknownEnum.Value_1] = global.TMID_Pit;
    global.TMID[UnknownEnum.Value_2] = global.TMID_Floor_Lower;
    global.TMID[UnknownEnum.Value_3] = global.TMID_Water_Lower;
    global.TMID[UnknownEnum.Value_4] = global.TMID_Walls_Lower;
    global.TMID[UnknownEnum.Value_5] = global.TMID_Decor_Lower;
    global.TMID[UnknownEnum.Value_6] = global.TMID_Floor_Upper;
    global.TMID[UnknownEnum.Value_7] = global.TMID_Water_Upper;
    global.TMID[UnknownEnum.Value_8] = global.TMID_StairMonuments;
    global.TMID[UnknownEnum.Value_9] = global.TMID_StairMonumentsDecor;
    global.TMID[UnknownEnum.Value_10] = global.TMID_Walls_Upper;
    global.TMID[UnknownEnum.Value_11] = global.TMID_Decor_Upper;
    global.TMID[UnknownEnum.Value_12] = global.TMID_Tiles_Higher;
    global.TMID[UnknownEnum.Value_13] = global.TMID_Tiles_Highest;
    global.TMID[UnknownEnum.Value_14] = global.TMID_Tiles_Ceiling;
    layer_script_begin(global.LayerID_Tiles_Ceiling, PixelRender_Tiles_Ceiling);
    layer_script_end(global.LayerID_Tiles_Ceiling, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Highest, PixelRender_Tiles_Simple);
    layer_script_end(global.LayerID_Tiles_Highest, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Higher, PixelRender_Tiles_Simple);
    layer_script_end(global.LayerID_Tiles_Higher, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Decor_Upper, PixelRender_Tiles_Simple);
    layer_script_end(global.LayerID_Tiles_Decor_Upper, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Walls_Upper, PixelRender_Tiles_Simple);
    layer_script_end(global.LayerID_Tiles_Walls_Upper, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_StairMonuments, PixelRender_Tiles_Floor_Upper);
    layer_script_end(global.LayerID_Tiles_StairMonuments, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_StairMonumentsDecor, PixelRender_Tiles_Floor_Upper);
    layer_script_end(global.LayerID_Tiles_StairMonumentsDecor, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Water_Upper, PixelRender_Tiles_Floor_Upper);
    layer_script_end(global.LayerID_Tiles_Water_Upper, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Floor_Upper, PixelRender_Tiles_Floor_Upper);
    layer_script_end(global.LayerID_Tiles_Floor_Upper, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Decor_Lower, PixelRender_Tiles_Simple);
    layer_script_end(global.LayerID_Tiles_Decor_Lower, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Walls_Lower, PixelRender_Tiles_Simple);
    layer_script_end(global.LayerID_Tiles_Walls_Lower, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Water_Lower, PixelRender_Tiles_Floor_Lower);
    layer_script_end(global.LayerID_Tiles_Water_Lower, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Floor_Lower, PixelRender_Tiles_Floor_Lower);
    layer_script_end(global.LayerID_Tiles_Floor_Lower, PixelRender_Tiles_End);
    layer_script_begin(global.LayerID_Tiles_Pit, PixelRender_Tiles_Simple);
    layer_script_end(global.LayerID_Tiles_Pit, PixelRender_Tiles_End);
}

function Data_InitDoorCoordinates()
{
    global.DoorCoordinates = Array_Create2D(24, 4);
    XYArray[UnknownEnum.Value_0] = [168, 16, 216, 56, 216, 112, 216, 168, 168, 216, 112, 216, 56, 216, 16, 168, 16, 112, 16, 56, 56, 16, 112, 16, 152, 40, 192, 72, 192, 112, 192, 152, 152, 192, 112, 192, 72, 192, 40, 152, 40, 112, 40, 72, 72, 40, 112, 40];
    XYArray[UnknownEnum.Value_1] = [168, 16, 216, 112, 216, 240, 216, 368, 168, 472, 112, 472, 56, 472, 16, 368, 16, 240, 16, 112, 56, 16, 112, 16, 152, 40, 192, 112, 192, 240, 192, 368, 152, 448, 112, 448, 72, 448, 40, 368, 40, 240, 40, 112, 72, 40, 112, 40];
    XYArray[UnknownEnum.Value_2] = [368, 16, 472, 56, 472, 112, 472, 168, 368, 216, 240, 216, 112, 216, 16, 168, 16, 112, 16, 56, 112, 16, 240, 16, 368, 40, 448, 72, 448, 112, 448, 152, 368, 192, 240, 192, 112, 192, 40, 152, 40, 112, 40, 72, 112, 40, 240, 40];
    XYArray[UnknownEnum.Value_3] = [368, 16, 472, 112, 472, 240, 472, 368, 368, 472, 240, 472, 112, 472, 16, 368, 16, 240, 16, 112, 112, 16, 240, 16, 368, 40, 448, 112, 448, 240, 448, 368, 368, 448, 240, 448, 112, 448, 40, 368, 40, 240, 40, 112, 112, 40, 240, 40];
    
    for (var _RoomSize = 0; _RoomSize < 4; _RoomSize++)
    {
        for (var _Position = 0; _Position < 24; _Position++)
        {
            var _x = XYArray[_RoomSize][_Position * 2];
            var _y = XYArray[_RoomSize][(_Position * 2) + 1];
            global.DoorCoordinates[_RoomSize][_Position + 1] = new Data_CreateStruct_DoorCoordinate(_x, _y, _Position + 1);
        }
    }
}

function Data_CreateStruct_DoorCoordinate(arg0, arg1, arg2) constructor
{
    x = arg0;
    y = arg1;
    Level = (arg2 <= 12) ? "Upper" : "Lower";
    
    switch (arg2)
    {
        case 11:
        case 12:
        case 1:
        case 23:
        case 24:
        case 13:
            Location = "Top";
            break;
        
        case 2:
        case 3:
        case 4:
        case 14:
        case 15:
        case 16:
            Location = "Right";
            break;
        
        case 5:
        case 6:
        case 7:
        case 17:
        case 18:
        case 19:
            Location = "Bottom";
            break;
        
        case 8:
        case 9:
        case 10:
        case 20:
        case 21:
        case 22:
            Location = "Left";
            break;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14
}
