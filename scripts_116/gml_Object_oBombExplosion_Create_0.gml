event_inherited();
CollisionList = ds_list_create();
Exploded_Curtains = false;
Exploded_Doors = false;
BlastRadius_Doors = 16;
BlastRadius_Link = 24;
BlastRadius_Enemies = (global.Level.Index == UnknownEnum.Value_13) ? 24 : 32;
BlastRadius_PickupObjs = 32;
MaxDamage = 2;
LastImageSpeed = 1;
ExplosionLightInst = instance_create_layer(x, y, layer, oExplosionLight, 
{
    FloorLevel: FloorLevel
});
audio_play_sound(Sound_BombBlow, 1, false);

enum UnknownEnum
{
    Value_13 = 13
}
