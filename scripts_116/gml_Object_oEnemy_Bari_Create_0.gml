event_inherited();
Size = UnknownEnum.Value_1;
Type = (global.Level.Index == UnknownEnum.Value_12) ? 1 : 0;

switch (Type)
{
    case 0:
        Enemy_SetEnergy(3);
        Attack = 1.25;
        Speed = 0.25;
        break;
    
    case 1:
        Enemy_SetEnergy(5);
        Attack = 2.25;
        Speed = 0.65;
        break;
}

LightIndex = Lighting_CreateLight(RoomIndex, x, y, 0.8, [0.8, 0.8, 0.8], false);
z = 8;
ObjSetY(y_base);
Bari_UpdateDir(irandom(360), choose(-1, 1));
Enemy_UpdateState(UnknownEnum.Value_3);

enum UnknownEnum
{
    Value_1 = 1,
    Value_3 = 3,
    Value_12 = 12
}
