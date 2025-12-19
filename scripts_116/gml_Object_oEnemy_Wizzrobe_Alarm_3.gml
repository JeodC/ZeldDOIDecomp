var inst;

switch (Dir)
{
    case 3:
        inst = instance_create_layer(x - 8, y - 7, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oBeam, 
        {
            Type: Type
        });
        inst.vx = -inst.Speed;
        inst.sprite_index = sBeam_Left;
        break;
    
    case 4:
        inst = instance_create_layer(x + 8, y - 7, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oBeam, 
        {
            Type: Type
        });
        inst.vx = inst.Speed;
        inst.sprite_index = sBeam_Right;
        break;
    
    case 1:
        inst = instance_create_layer(x, y - 14, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oBeam, 
        {
            Type: Type
        });
        inst.vy = -inst.Speed;
        inst.sprite_index = sBeam_Up;
        Hit_AllowedTimer = 3;
        break;
    
    case 2:
        inst = instance_create_layer(x, y + 6, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oBeam, 
        {
            Type: Type
        });
        inst.vy = inst.Speed;
        inst.sprite_index = sBeam_Down;
        break;
}

inst.image_index = Type;
inst.Damage = Attack;

if (oCamera.InView(inst.x, inst.y) && !audio_is_playing(Sound_Medusa))
    audio_play_sound(Sound_Medusa, 1, false);

Enemy_UpdateState(UnknownEnum.Value_8);

enum UnknownEnum
{
    Value_8 = 8
}
