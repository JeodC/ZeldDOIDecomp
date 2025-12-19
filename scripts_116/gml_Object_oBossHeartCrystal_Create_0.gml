SpawnedHeart = false;
SpawnCrystal = false;
CrystalDelay = 70;

if (Item_Allowed(UnknownEnum.Value_18, 0, UnknownEnum.Value_14))
    alarm[0] = 10;
else
    alarm[1] = CrystalDelay;

enum UnknownEnum
{
    Value_14 = 14,
    Value_18 = 18
}
