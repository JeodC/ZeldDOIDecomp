function StopStar()
{
    oLink.Invincible = false;
    oLink.StarActive = false;
    
    if (oLink.State != UnknownEnum.Value_19)
        exit;
    
    oLink.alarm[7] = -1;
    oLink.alarm[8] = -1;
    instance_destroy(oSword);
}

enum UnknownEnum
{
    Value_19 = 19
}
