instance_create_layer(oCamera.X + 32 + irandom(192), oCamera.Y + 16 + irandom(192), "ObjsHighest", oExplosion_Large);
Explosions--;

if (Explosions == 0)
{
    with (oEnemy)
    {
        if (Enemy_IsBoss(object_index))
            continue;
        
        Enemy_LinkWeaponHit(UnknownEnum.Value_6, 0, self, x, y, 0);
    }
    
    if (instance_exists(oMedallion))
        instance_destroy(oMedallion);
    
    instance_destroy(id);
}
else
{
    alarm[0] = 8;
}

enum UnknownEnum
{
    Value_6 = 6
}
