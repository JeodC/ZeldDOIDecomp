event_inherited();
Dir = RandomDir();
Size = UnknownEnum.Value_2;

switch (global.Level.Index)
{
    case UnknownEnum.Value_1:
        HeadIndex = UnknownEnum.Value_0;
        ColorIndex = UnknownEnum.Value_1;
        Enemy_SetEnergy(1);
        Attack = 0.5;
        break;
    
    case UnknownEnum.Value_2:
        HeadIndex = UnknownEnum.Value_0;
        ColorIndex = UnknownEnum.Value_0;
        Enemy_SetEnergy(1);
        Attack = 0.5;
        break;
    
    case UnknownEnum.Value_3:
        HeadIndex = UnknownEnum.Value_0;
        ColorIndex = UnknownEnum.Value_3;
        Enemy_SetEnergy(2);
        Attack = 0.5;
        break;
}

HeadDir = Dir;
HeadSpr = -4;
HeadX = x;
WalkSpeed = 0.5;
RunSpeed = 1;
Enemy_UpdateState(UnknownEnum.Value_3);

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
