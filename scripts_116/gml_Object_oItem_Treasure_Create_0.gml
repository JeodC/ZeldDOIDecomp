event_inherited();

if (!variable_instance_exists(id, "From"))
    From = UnknownEnum.Value_2;

if (!variable_instance_exists(id, "ContentsFrom"))
    ContentsFrom = UnknownEnum.Value_2;

ContentsObj = -99;
InSection = false;
IsSwitchTreasure = false;
visible = true;
Get_WhenLinkCollides = false;
Get_Sound = -4;
WallInst = -4;
ShadowSpr = sEmptyMask;

enum UnknownEnum
{
    Value_2 = 2
}
