with (TongueInst)
{
    StartX = other.x + OffsetX;
    StartY = (other.y - 5) + OffsetY;
    x = StartX + lengthdir_x(Dist, Angle);
    y = StartY + lengthdir_y(Dist, Angle);
    Hit = other.State == UnknownEnum.Value_10;
}

enum UnknownEnum
{
    Value_10 = 10
}
