event_inherited();
SoundPaused = ObjPauseSound(Sound, SoundPaused);

if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

if (oLink.State != UnknownEnum.Value_21 && oLink.State != UnknownEnum.Value_20 && State != UnknownEnum.Value_19)
{
    if ((Hit_Started && Hit_LinkWeaponClass == UnknownEnum.Value_0) || ObjCollision(x, y, oLink, FloorLevel))
    {
        sprite_index = sBoss_Moldorm_Head_Hit;
        alarm[4] = 30;
        
        with (oLink)
        {
            LinkThrow();
            LinkBounceBack(point_direction(other.x, other.y, x, y), 3, 14);
        }
    }
}

if (State != UnknownEnum.Value_19)
{
    var PreviousPoints = array_length(PPX);
    var i = PreviousPoints - 1;
    
    while (i > 0)
    {
        PPX[i] = PPX[i - 1];
        i--;
    }
    
    PreviousPoints = array_length(PPY);
    i = PreviousPoints - 1;
    
    while (i > 0)
    {
        PPY[i] = PPY[i - 1];
        i--;
    }
    
    PPX[0] = x;
    PPY[0] = y;
}

for (var _SectionIndex = 0; _SectionIndex < 4; _SectionIndex++)
{
    if (instance_exists(BodyInst[_SectionIndex]))
    {
        BodyInst[_SectionIndex].x = PPX[PP[_SectionIndex][SpeedIndex]];
        
        with (BodyInst[_SectionIndex])
            ObjSetY(other.PPY[other.PP[_SectionIndex][other.SpeedIndex]]);
    }
}

if (WallCollide_X || WallCollide_Y)
    Dir = point_direction(0, 0, vx, vy);

switch (State)
{
    case UnknownEnum.Value_3:
        vx = lengthdir_x(Speed[SpeedIndex], Dir);
        vy = lengthdir_y(Speed[SpeedIndex], Dir);
        Dir = (Dir + (DirV * 5)) % 360;
        
        if (HuntLink)
        {
            if (collision_line(x, y, x + lengthdir_x(128, Dir), y + lengthdir_y(128, Dir), oLink, false, true))
            {
                DirV = 0;
                alarm[1] = irandom_range(40, 60);
                alarm[8] = -1;
                HuntLink = false;
            }
        }
        
        if (!audio_is_playing(Sound) || Sound == -4)
            Sound = audio_play_sound(Sound_MoldormSkitter, 1, true);
        
        HitAllowed = true;
        
        with (oBoss_Moldorm_Tail)
            Hit_Allowed = true;
        
        break;
    
    case UnknownEnum.Value_12:
    case UnknownEnum.Value_19:
        KnockBackColorFrame = (KnockBackColorFrame + 1) % global.KnockBackColorFrames;
    
    case UnknownEnum.Value_0:
        EyeA = (EyeA + 30) % 360;
        vx = 0;
        vy = 0;
        HitAllowed = false;
        
        with (oBoss_Moldorm_Tail)
            Hit_Allowed = false;
        
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_3 = 3,
    Value_10 = 10,
    Value_11,
    Value_12,
    Value_13,
    Value_15 = 15,
    Value_16,
    Value_17,
    Value_19 = 19,
    Value_20,
    Value_21
}
