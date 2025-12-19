instance_create_layer(oLink.x, oLink.y, "ObjsHighest", oFireTower_MultiExplosion);
alarm[0] = 36;
alarm[1] = 150;
oCamera.alarm[0] = 300;
oCamera.ShakeAmount = 0.8;
global.Paused = true;

if (instance_exists(oSword))
    instance_destroy(oSword);

if (instance_exists(oRod_Cane))
    instance_destroy(oRod_Cane);

with (oLink)
    UpdateState(UnknownEnum.Value_0);

enum UnknownEnum
{
    Value_0
}
