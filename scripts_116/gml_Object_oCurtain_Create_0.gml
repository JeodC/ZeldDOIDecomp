FloorLevel = 1;
sprite_index = asset_get_index("sCurtain_" + Location);

switch (global.Level.Index)
{
    case UnknownEnum.Value_1:
        LevelIndex = 0;
        break;
    
    case UnknownEnum.Value_3:
        LevelIndex = 1;
        break;
    
    case UnknownEnum.Value_5:
        BeamTileX = 121;
        LevelIndex = 2;
        break;
    
    case UnknownEnum.Value_8:
        BeamTileX = 125;
        LevelIndex = 3;
        break;
}

image_index = LevelIndex;
Revealed = false;
RevealedDone = false;

with (DoorInst)
{
    CurtainInst = other;
    Status = UnknownEnum.Value_10;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_3 = 3,
    Value_5 = 5,
    Value_8 = 8,
    Value_10 = 10
}
