FloorLevel = GetFloorLevelID(x, y);
FloorLevelStr = GetFloorLevelString(FloorLevel);
X2 = (x + W) - 1;
Y2 = (y + H) - 1;
CenterX = x + (W / 2);
GemCount = array_create(9);
WishStone = false;

switch (GID)
{
    case UnknownEnum.Value_262:
        Palette = 0;
        break;
    
    case UnknownEnum.Value_314:
        Palette = 1;
        break;
}

enum UnknownEnum
{
    Value_262 = 262,
    Value_314 = 314
}
