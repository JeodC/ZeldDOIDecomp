if (global.Arcade_ActiveInst.Harry.Killed && global.Arcade_ActiveInst.State != UnknownEnum.Value_5)
    exit;

x += vx;
y += vy;

if (x < (global.Arcade_ActiveInst.CamX - 20))
    instance_destroy(id);

if (global.Arcade_ActiveInst.State == UnknownEnum.Value_5)
    exit;

if (x < (global.Arcade_ActiveInst.Harry.x - 10) && !AddedPoints)
{
    global.Arcade_ActiveInst.Score += Points;
    AddedPoints = true;
}

enum UnknownEnum
{
    Value_5 = 5
}
