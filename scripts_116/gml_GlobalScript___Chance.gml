function Lighting_GetRoomStatus(arg0)
{
    if (!global.GlobalLighting)
        return false;
    
    if (global.SaveLevel)
        return true;
    
    if (global.Challenges[UnknownEnum.Value_4])
        return true;
    
    if (global.Level.Index == UnknownEnum.Value_6)
        return global.VillageLightingMap[global.Level.Rooms[arg0].GridY][global.Level.Rooms[arg0].GridX];
    
    if (global.Level.Index == UnknownEnum.Value_10)
        return global.Level.Rooms[arg0].TemplateSubClass != UnknownEnum.Value_1;
    
    if (TemplateCheck(arg0, UnknownEnum.Value_8, UnknownEnum.Value_0) || TemplateCheck(arg0, UnknownEnum.Value_8, UnknownEnum.Value_2) || TemplateCheck(arg0, UnknownEnum.Value_8, UnknownEnum.Value_1))
        return false;
    
    if (TemplateCheck(arg0, UnknownEnum.Value_9, UnknownEnum.Value_0, "Moldorm"))
        return true;
    
    if (global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_9)
        return false;
    
    var P = 0.4;
    
    switch (global.Level.Index)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_13:
            return false;
        
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_3:
            P = 0.35;
        
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_9:
            P = 0.45;
            break;
        
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_12:
            P = 0.55;
            break;
        
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_11:
            return true;
            break;
    }
    
    return Prob(P);
}

function Prob(arg0)
{
    return random(1) < arg0;
}

function FlipCoin_Bin()
{
    return choose(0, 1);
}

function FlipCoin_Bool()
{
    return choose(false, true);
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
    Value_8 = 8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13
}
