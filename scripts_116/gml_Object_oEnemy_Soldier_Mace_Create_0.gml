event_inherited();

switch (global.Level.Index)
{
    case UnknownEnum.Value_3:
        ColorIndex = UnknownEnum.Value_3;
        HeadIndex = UnknownEnum.Value_1;
        Enemy_SetEnergy(4);
        Attack = 1;
        break;
    
    case UnknownEnum.Value_12:
        ColorIndex = UnknownEnum.Value_4;
        HeadIndex = UnknownEnum.Value_2;
        Enemy_SetEnergy(9);
        Attack = 3.25;
        break;
}

Size = UnknownEnum.Value_3;
Dir = RandomDir();
WalkSpeed = 0.75;
HeadDir = Dir;
HeadSpr = -4;
WeaponInst = instance_create_layer(x, y, layer, oSoldierWeapon_Mace);
WeaponInst.SoldierInst = id;
WeaponInst.depth = depth - 1;
WeaponInst.FloorLevel = FloorLevel;
WeaponInst.FloorLevelStr = GetFloorLevelString(FloorLevel);
WeaponInst.IdleLayer = layer_get_id("ObjsHigher_" + WeaponInst.FloorLevelStr);
Strafe = false;
StrafeDir = 3;
StrafeTime = 120;
SpinAllowed = true;
SpinStartDist = 30;
IdleDelay = 24;
LinkNotVisibleDist = 80;
CheckForWater = true;
Enemy_UpdateState(UnknownEnum.Value_2);

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_4,
    Value_12 = 12
}
