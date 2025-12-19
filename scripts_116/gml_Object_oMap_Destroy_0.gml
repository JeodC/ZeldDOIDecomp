sprite_delete(MapSprite);
sprite_delete(LinkSprite);
global.MapInst = -4;
global.Paused = false;

with (oLink)
    UpdateState(UnknownEnum.Value_1);

enum UnknownEnum
{
    Value_1 = 1
}
