event_inherited();

switch (global.Level.Index)
{
    case UnknownEnum.Value_1:
        Size = UnknownEnum.Value_2;
        ColorIndex = UnknownEnum.Value_1;
        HeadIndex = UnknownEnum.Value_0;
        Weapon = UnknownEnum.Value_0;
        Enemy_SetEnergy(2);
        Attack = 0.5;
        break;
    
    case UnknownEnum.Value_2:
        Size = UnknownEnum.Value_2;
        ColorIndex = UnknownEnum.Value_0;
        HeadIndex = UnknownEnum.Value_0;
        Weapon = UnknownEnum.Value_0;
        Enemy_SetEnergy(2);
        Attack = 0.5;
        break;
    
    case UnknownEnum.Value_3:
        Size = UnknownEnum.Value_3;
        ColorIndex = UnknownEnum.Value_3;
        HeadIndex = UnknownEnum.Value_1;
        Weapon = UnknownEnum.Value_1;
        Enemy_SetEnergy(3);
        Attack = 0.75;
        break;
    
    case UnknownEnum.Value_4:
        Size = UnknownEnum.Value_3;
        ColorIndex = UnknownEnum.Value_3;
        HeadIndex = UnknownEnum.Value_3;
        Weapon = UnknownEnum.Value_3;
        Enemy_SetEnergy(3);
        Attack = 0.75;
        break;
    
    case UnknownEnum.Value_9:
        Size = UnknownEnum.Value_3;
        ColorIndex = UnknownEnum.Value_0;
        HeadIndex = UnknownEnum.Value_6;
        Weapon = UnknownEnum.Value_2;
        Enemy_SetEnergy(6);
        Attack = 1.75;
        break;
    
    case UnknownEnum.Value_12:
        Size = UnknownEnum.Value_3;
        ColorIndex = UnknownEnum.Value_2;
        Weapon = UnknownEnum.Value_0;
        HeadIndex = choose(UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_7);
        break;
}

Dir = RandomDir();
WalkSpeed = 0.5;
RunSpeed = 1;
HeadDir = Dir;
HeadSpr = -4;
StandingTurnHeadDir = 1;
StandinHeadTurnDelay = 30;
StandingHeadChecks = 6;
WeaponInst = instance_create_layer(x, y, layer, oSoldierWeapon);
WeaponInst.SoldierInst = id;
WeaponInst.FloorLevel = FloorLevel;
Strafe = false;
StrafeDir = 3;
StrafeTime = 60;
Sight = true;
SightDist = 100;
SightOffset = 10;
LinkHitSword = false;
PlayRunSound = true;
CheckForWater = true;
InWaterSprYOffset = -3;
Setup = true;
SaveVariables = ["HeadIndex", "Weapon", "Attack"];
Enemy_UpdateState(UnknownEnum.Value_3);

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
    Value_9 = 9,
    Value_12 = 12
}
