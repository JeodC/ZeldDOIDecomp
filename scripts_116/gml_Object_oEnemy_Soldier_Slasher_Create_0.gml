event_inherited();
ColorIndex = irandom(4);
HeadIndex = irandom(3);
Weapon = UnknownEnum.Value_0;
Size = UnknownEnum.Value_3;
Dir = RandomDir();
RunSpeed = 1.1;
HeadDir = Dir;
HeadSpr = -4;
WeaponInst = instance_create_layer(x, y, layer, oSoldierWeapon);
WeaponInst.SoldierInst = self;
WeaponInst.FloorLevel = FloorLevel;
Strafe = false;
StrafeDir = 3;
StrafeTime = 60;
LinkHitSword = false;
PlayRunSound = true;
SaveVariables = ["ColorIndex", "HeadIndex"];
Enemy_UpdateState(UnknownEnum.Value_4);

enum UnknownEnum
{
    Value_0,
    Value_3 = 3,
    Value_4
}
