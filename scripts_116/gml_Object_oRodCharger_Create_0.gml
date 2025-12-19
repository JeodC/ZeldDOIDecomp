State = UnknownEnum.Value_0;
RodIndex = 3;
RodInserted = false;
MagicCost = 4;
ChargeDelay = 13;
FillError = false;
CanAddShot = true;
ChargeColor = 0;
ChargeColors = [[-3, -3, -3], [-1, -1, -1], [-2, -2, -2]];
BaseLightRadius = 0.75;
LightRadius = BaseLightRadius;
LightIndex = Lighting_CreateLight(RoomIndex, x, y + 1, LightRadius, [0.4, 0.4, 1.1]);
LightFrame = 0;

enum UnknownEnum
{
    Value_0
}
