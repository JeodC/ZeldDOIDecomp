SoundPaused = ObjPauseSound(Sound, SoundPaused);

if (global.Paused)
{
    ObjPause();
    exit;
}

switch (State)
{
    case UnknownEnum.Value_1:
        ShakeOffset += ShakeDir;
        
        if (ShakeOffset >= 1 || ShakeOffset <= -1)
            ShakeDir *= -1;
        
        break;
    
    case UnknownEnum.Value_5:
        if (ArmosLeft <= 0)
        {
            if (instance_exists(oBoss_Armos))
            {
                with (oBoss_Armos)
                    instance_destroy(id);
                
                MsgBox("Something went wrong, report bug to dev: code 1");
            }
            
            State = UnknownEnum.Value_19;
            break;
        }
        
        vz -= 0.2;
        z += vz;
        
        if (z <= 0)
        {
            z = 0;
            oCamera.alarm[0] = 4;
            oCamera.ShakeAmount = 0.8;
            audio_play_sound(Sound_DoorClose, 1, false);
            
            if (ArmosLeft == 1)
            {
                State = UnknownEnum.Value_7;
                
                with (LastArmos_Inst)
                {
                    Enemy_UpdateState(UnknownEnum.Value_7);
                    vx = 0;
                    vy = 0;
                    z = other.z;
                }
                
                vz = 0;
                alarm[6] = 15;
                break;
            }
            else
            {
                vz = JumpSpeed;
            }
        }
        
        for (var i = 0; i < ArmosCount; i++)
        {
            if (instance_exists(ArmosInst[i]) && ArmosStatus[i])
                ArmosInst[i].z = z;
        }
        
        if (WaypointScriptIndex == UnknownEnum.Value_1)
        {
            if (CircleShrink)
            {
                CircleRadius -= 0.75;
                
                if (CircleRadius <= CircleRadiusMin)
                    CircleRadius = CircleRadiusMin;
            }
            
            if (CircleExpand)
            {
                CircleRadius += 0.75;
                
                if (CircleRadius >= CircleRadiusMax)
                    CircleRadius = CircleRadiusMax;
            }
            
            for (var i = 0; i < ArmosCount; i++)
            {
                if (instance_exists(ArmosInst[i]) && ArmosStatus[i])
                {
                    ArmosInst[i].CircleAngle = (ArmosInst[i].CircleAngle - MoveSpeed - (((CircleRadiusMax - CircleRadius) / CircleRadiusMin) * 0.4)) % 360;
                    ArmosInst[i].WaypointX = round(CircleX + (CircleRadius * dcos(ArmosInst[i].CircleAngle)));
                    ArmosInst[i].WaypointY = round(CircleY + (CircleRadius * dsin(ArmosInst[i].CircleAngle)));
                    
                    if (ArmosInst[i].State != UnknownEnum.Value_10)
                        Armos_Waypoints_Calculate(ArmosInst[i]);
                }
            }
        }
        
        break;
    
    case UnknownEnum.Value_7:
        if (ArmosLeft <= 0)
        {
            State = UnknownEnum.Value_19;
            break;
        }
        
        if (LastArmos_Inst.State == UnknownEnum.Value_10)
        {
            vz = -3;
            alarm[5] = -1;
            alarm[6] = -1;
            LastArmos_Jump = false;
            LastArmos_Stomp = false;
            
            if (audio_is_playing(Sound_Fall))
                audio_stop_sound(Sound_Fall);
        }
        
        z += vz;
        
        if (z <= 0)
        {
            vz = 0;
            z = 0;
        }
        
        LastArmos_Inst.z = z;
        LastArmos_Inst.CanHurtLink = z < 10;
        
        if (LastArmos_Jump)
        {
            if (Armos_MoveToWaypoint(LastArmos_Inst) && z >= LastArmos_JumpZ)
            {
                z = LastArmos_JumpZ;
                LastArmos_Jump = false;
                vz = 0;
                alarm[5] = 5;
            }
        }
        
        if (LastArmos_Stomp)
        {
            if (z == 0)
            {
                vz = 0;
                oCamera.alarm[0] = 6;
                oCamera.ShakeAmount = 1.2;
                audio_play_sound(Sound_DoorClose, 1, false);
                alarm[6] = 15;
                LastArmos_Stomp = false;
                LastArmos_Inst.Hit_Allowed = true;
            }
        }
        
        break;
    
    case UnknownEnum.Value_19:
        if (instance_number(oBoss_Armos_Explosion) == 0)
        {
            instance_create_layer(LastArmos_X, LastArmos_Y, "System", oBossHeartCrystal);
            instance_destroy(id);
        }
        
        break;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_5 = 5,
    Value_7 = 7,
    Value_10 = 10,
    Value_19 = 19
}
