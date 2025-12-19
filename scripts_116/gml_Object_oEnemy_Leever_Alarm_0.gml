if (!InitialWakeDone || oLink.Cape)
{
    InitialWakeDone = true;
}
else
{
    var _Buffer = 64;
    x = clamp(oLink.x, global.Level.Rooms[RoomIndex].x + _Buffer, global.Level.Rooms[RoomIndex].x2 - _Buffer);
    var _y = clamp(oLink.y, global.Level.Rooms[RoomIndex].y + _Buffer, global.Level.Rooms[RoomIndex].y2 - _Buffer);
    ObjSetY(_y);
}

Enemy_UpdateState(UnknownEnum.Value_1);

enum UnknownEnum
{
    Value_1 = 1
}
