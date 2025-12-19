event_inherited();
Size = UnknownEnum.Value_1;
Speed = 1;
Angle = 0;
ChargeAngle = 0;
RotateSpeed = 3;
ChangeDirDelayMin = 10;
ChangeDirDelayMax = 40;
PushbackTimeLen = 15;
UpdateFacingSpriteDelayMin = 5;
UpdateFacingSpriteDelayMax = 10;
alarm[2] = irandom_range(15, 60);
Enemy_UpdateState(UnknownEnum.Value_2);
Helmasaur_UpdateDir();

enum UnknownEnum
{
    Value_1 = 1,
    Value_2
}
