function Gurus_GetType()
{
    switch (global.Level.Index)
    {
        case UnknownEnum.Value_9:
            return 1;
        
        case UnknownEnum.Value_11:
        case UnknownEnum.Value_12:
            return 2;
    }
    
    return 0;
}

function Gurus_Update()
{
    for (var i = 0; i < GuruCount; i++)
    {
        GuruInst[i].State = State;
        GuruInst[i].x = CenterX + lengthdir_x(BlockSeperation + (i * SeperationDist), Angle);
        GuruInst[i].y_base = CenterY + lengthdir_y(BlockSeperation + (i * SeperationDist), Angle);
        GuruInst[i].y = GuruInst[i].y_base;
        Lighting_UpdateLight_Visible(RoomIndex, GuruInst[i].LightIndex, State == UnknownEnum.Value_3);
        Lighting_UpdateLight_Pos(RoomIndex, GuruInst[i].LightIndex, GuruInst[i].x, GuruInst[i].y);
        Lighting_UpdateLight_Radius(RoomIndex, GuruInst[i].LightIndex, choose(0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58));
    }
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_9 = 9,
    Value_11 = 11,
    Value_12
}
