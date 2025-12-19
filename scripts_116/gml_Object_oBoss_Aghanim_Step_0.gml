event_inherited();
Lighting_UpdateLight_Radius(RoomIndex, LightIndex, LightRadius[irandom(4)]);

if (Intro)
{
    if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
    {
        ObjPause();
        exit;
    }
    else
    {
        image_speed = LastImageSpeed;
    }
    
    if (IntroMsg1)
    {
        if (!instance_exists(oDialogueBox))
        {
            with (oLink)
                UpdateState(UnknownEnum.Value_0);
            
            TakeItems = true;
            alarm[7] = 30;
            IntroMsg1 = false;
        }
    }
    
    if (TakeItems)
    {
        if (TakeItems_ShowBag && !TakeItems_ShowShield)
        {
            TakeItems_BagPosY -= TakeItems_BagV;
            TakeItems_BagV += TakeItems_BagA;
            
            if (TakeItems_BagPosY < (y + 12))
            {
                TakeItems_BagPosY = y + 12;
                TakeItems_BagV = 0;
                TakeItems_BagA = 0;
                audio_play_sound(Sound_AghanimCharge, 1, false);
                alarm[8] = 100;
                TakeItems_ShowShield = true;
                Lighting_UpdateLight_Pos(RoomIndex, LightIndex, x, y + 4);
                Lighting_UpdateLight_Visible(RoomIndex, LightIndex, true);
            }
        }
    }
    
    if (IntroMsg2)
    {
        if (!instance_exists(oDialogueBox))
        {
            Intro = false;
            
            with (oLink)
                UpdateState(UnknownEnum.Value_1);
            
            Lighting_UpdateLight_Visible(RoomIndex, LightIndex_Body, false);
        }
    }
    
    exit;
}

if (Hit_Started)
    image_index = 0;

if (KnockBackDone)
{
    Enemy_UpdateState(UnknownEnum.Value_0);
    alarm[0] = -1;
    alarm[2] = -1;
    ScriptIndex = ScriptIndexBombMove;
    ScriptNext = true;
}

if (Energy <= 4)
{
    KnockBackEnabled = false;
    Hit_Sound = Sound_Boss_Destroy;
}

if (State != UnknownEnum.Value_19 && Energy <= 0)
{
    global.Time_PlayingTotalEnd = Time_PlayingTotal();
    global.GameBeaten = true;
    Enemy_UpdateState(UnknownEnum.Value_19);
    
    with (oLink)
    {
        UpdateState(UnknownEnum.Value_0);
        audio_stop_sound(LowHealthSound);
    }
    
    image_index = 0;
    alarm[0] = -1;
    alarm[2] = -1;
    alarm[4] = 30;
    
    with (oBomb)
    {
        instance_create_layer(x, y, EffectLayer(1), oEnemy_Destroy);
        instance_destroy(id);
    }
    
    global.StatsToAdd[UnknownEnum.Value_1]++;
    global.StatsToAdd[UnknownEnum.Value_3]++;
}

if (State != UnknownEnum.Value_19)
{
    if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
    {
        ObjPause();
        exit;
    }
    else
    {
        image_speed = LastImageSpeed;
    }
}

if (ScriptNext)
{
    ScriptNext = false;
    var S = Script[ScriptIndex];
    ScriptIndex = (ScriptIndex + 1) % ScriptLen;
    alarm[0] = -1;
    
    switch (S[0])
    {
        case UnknownEnum.Value_0:
            State = UnknownEnum.Value_2;
            image_index = 0;
            alarm[0] = S[1];
            break;
        
        case UnknownEnum.Value_3:
            State = UnknownEnum.Value_6;
            image_index = 1;
            Charge_ImageIndex = 0;
            Charge_PosIndex = 0;
            Charge_Speed = 1 / S[1];
            Charge_Lerp = 0.5;
            Charge_InstL = instance_create_layer(x, y, "ObjsHigher_Upper", oAghanim_EnergyBall);
            Charge_InstR = instance_create_layer(x, y, "ObjsHigher_Upper", oAghanim_EnergyBall);
            Charge_InstL.DestroyAnimation = false;
            Charge_InstR.DestroyAnimation = false;
            audio_play_sound(Sound_AghanimChargeFast, 1, false);
            break;
        
        case UnknownEnum.Value_1:
            State = UnknownEnum.Value_6;
            image_index = 2;
            Charge_ImageIndex = 0;
            Charge_PosIndex = 0;
            Charge_Speed = 1 / S[1];
            Charge_Lerp = 0;
            Charge_InstL = instance_create_layer(x, y, "ObjsHigher_Upper", oAghanim_EnergyBall);
            Charge_InstL.DestroyAnimation = false;
            break;
        
        case UnknownEnum.Value_2:
            State = UnknownEnum.Value_6;
            image_index = 3;
            Charge_ImageIndex = 0;
            Charge_PosIndex = 0;
            Charge_Speed = 1 / S[1];
            Charge_Lerp = 0;
            Charge_InstR = instance_create_layer(x, y, "ObjsHigher_Upper", oAghanim_EnergyBall);
            Charge_InstR.DestroyAnimation = false;
            break;
        
        case UnknownEnum.Value_4:
            State = UnknownEnum.Value_7;
            image_index = 0;
            var _x, _y;
            
            if (instance_exists(Charge_InstL))
            {
                _x = Charge_InstL.x;
                _y = Charge_InstL.y;
            }
            else if (instance_exists(Charge_InstR))
            {
                _x = Charge_InstR.x;
                _y = Charge_InstR.y;
            }
            else
            {
                var _HandPosLX = global.AghanimHandPos[Dir][0];
                var _HandPosLY = global.AghanimHandPos[Dir][1];
                var _HandPosRX = global.AghanimHandPos[Dir][2];
                var _HandPosRY = global.AghanimHandPos[Dir][3];
                _x = x + lerp(_HandPosLX, _HandPosRX, 0.5);
                _y = y + lerp(_HandPosLY, _HandPosRY, 0.5);
            }
            
            instance_destroy(Charge_InstL);
            instance_destroy(Charge_InstR);
            
            switch (S[1])
            {
                case UnknownEnum.Value_0:
                    ShotInst = instance_create_layer(_x, _y, "ObjsHigher_Upper", oAghanim_EnergyBall, 
                    {
                        FloorLevel: 1
                    });
                    ShotInst.image_speed = 0;
                    var Angle = point_direction(_x, _y, oLink.x, oLink.y - 6);
                    ShotInst.vx = lengthdir_x(ShootSpeed, Angle);
                    ShotInst.vy = lengthdir_y(ShootSpeed, Angle);
                    ShotInst.alarm[0] = ShotInst.TrailDelay;
                    audio_play_sound(Sound_AghanimEnergyBeam, 1, false);
                    break;
                
                case UnknownEnum.Value_1:
                    ShotInst = instance_create_layer(_x, _y, "ObjsHigher_Upper", oAghanim_NewBlueBall, 
                    {
                        FloorLevel: 1
                    });
                    var Angle = point_direction(_x, _y, oLink.x, oLink.y - 6);
                    ShotInst.vx = lengthdir_x(ShootSpeed, Angle);
                    ShotInst.vy = lengthdir_y(ShootSpeed, Angle);
                    audio_play_sound(Sound_SwordBeam, 1, false);
                    break;
            }
            
            ScriptNext = true;
            break;
        
        case UnknownEnum.Value_5:
            State = UnknownEnum.Value_8;
            S[1] = array_shuffle(S[1]);
            MovePos = (array_length(S[1]) > 1 && CurrentPos == S[1][0]) ? S[1][1] : S[1][0];
            break;
        
        case UnknownEnum.Value_6:
            State = UnknownEnum.Value_7;
            Dir = 2;
            Aghanim_SetSprite();
            image_index = 2;
            BombIndex = 0;
            BombPosIndex = array_shuffle(BombPosIndex);
            alarm[2] = 1;
            ScriptIndexBombMove = ScriptIndex + 1;
            break;
        
        case UnknownEnum.Value_7:
            State = UnknownEnum.Value_7;
            GravityBall = true;
            Dir = 1;
            Aghanim_SetSprite();
            image_index = 1;
            GravityBallInst = instance_create_layer(x, y - 54, "ObjsHighest", oAghanim_GravityBall);
            alarm[6] = GravityBallTime;
            instance_destroy(Charge_InstL);
            instance_destroy(Charge_InstR);
            break;
    }
}

switch (State)
{
    case UnknownEnum.Value_2:
        Dir = Aghanim_FacingLinkDir();
        Aghanim_SetSprite();
        break;
    
    case UnknownEnum.Value_6:
        Dir = Aghanim_FacingLinkDir();
        Aghanim_SetSprite();
        Aghanim_UpdateCharge();
        Charge_PosIndex += Charge_Speed;
        
        if (Charge_PosIndex >= 1)
            ScriptNext = true;
        
        break;
    
    case UnknownEnum.Value_7:
        if (GravityBall && oLink.State == UnknownEnum.Value_20)
            alarm[6] = 1;
        
        break;
    
    case UnknownEnum.Value_8:
        BlackballMorph -= MorphToSpeed;
        
        if (BlackballMorph <= 0)
        {
            BlackballMorph = 0;
            State = UnknownEnum.Value_0;
            instance_create_layer(x, y - 16, "ObjsHigher_Upper", oAghanim_MorphBall, 
            {
                MoveX: MovePosX[MovePos % 3],
                MoveY: MovePosY[MovePos div 3]
            });
        }
        
        break;
    
    case UnknownEnum.Value_1:
        BlackballMorph += MorphToSpeed;
        Dir = Aghanim_FacingLinkDir();
        Aghanim_SetSprite();
        
        if (BlackballMorph >= 255)
        {
            BlackballMorph = 255;
            State = UnknownEnum.Value_2;
            CurrentPos = MovePos;
            ScriptNext = true;
        }
        
        break;
    
    case UnknownEnum.Value_19:
        if (!instance_exists(oDialogueBox) && FinalExplosionsInit)
        {
            alarm[3] = 1;
            
            with (oLink)
                UpdateState(UnknownEnum.Value_0);
            
            Music_Stop();
            FinalExplosionsInit = false;
        }
        
        KnockBackColorFrame = (KnockBackColorFrame + 1) % global.KnockBackColorFrames;
        break;
    
    case UnknownEnum.Value_0:
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17,
    Value_19 = 19,
    Value_20
}
