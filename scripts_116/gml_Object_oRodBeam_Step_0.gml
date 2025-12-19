if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

x += vx;
ObjSetY(y_base + vy);
Lighting_UpdateLight_Pos(RoomIndex, LightIndex, x, y);
Lighting_UpdateLight_Radius(RoomIndex, LightIndex, random_range(0.55, 0.63));
var inst = CheckProjectileCollision(FloorLevel);

if (inst != -4)
{
    if (inst.object_index != oBush && inst.object_index != oPot)
        instance_destroy(id);
}

event_inherited();

if (WallCollided)
{
    inst = instance_create_layer(x, y_base, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oRodFireEffect, 
    {
        Index: Index,
        FloorLevel: FloorLevel
    });
    instance_destroy(id);
}
