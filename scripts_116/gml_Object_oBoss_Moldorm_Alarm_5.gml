var _BodyIndex = UnknownEnum.Value_3;

while (_BodyIndex >= UnknownEnum.Value_0)
{
    if (instance_exists(BodyInst[_BodyIndex]))
    {
        instance_create_layer(BodyInst[_BodyIndex].x, BodyInst[_BodyIndex].y, "ObjsHighest", oExplosion_Large, 
        {
            FloorLevel: FloorLevel
        });
        instance_destroy(BodyInst[_BodyIndex]);
        alarm[5] = (_BodyIndex == UnknownEnum.Value_0) ? 60 : 20;
        exit;
    }
    
    _BodyIndex--;
}

if (FinalExplosions > 0)
{
    instance_create_layer(x + irandom_range(-12, 12), y + irandom_range(-12, 12), "ObjsHighest", oExplosion_Large, 
    {
        FloorLevel: FloorLevel
    });
    
    if (FinalExplosions <= 2)
        ShowHead = false;
    
    FinalExplosions--;
    
    if (FinalExplosions == 0)
    {
        alarm[7] = 20;
        Curse_CheckTask(UnknownEnum.Value_0);
        global.StatsToAdd[UnknownEnum.Value_3]++;
    }
    else
    {
        alarm[5] = 10;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_3 = 3
}
