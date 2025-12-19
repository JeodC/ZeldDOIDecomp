global.AghanimHandPos[1] = [-9, -28, 9, -28];
global.AghanimHandPos[2] = [11, -22, -11, -22];
global.AghanimHandPos[3] = [-8, -17, -8, -23];
global.AghanimHandPos[4] = [8, -23, 8, -17];
global.AghanimHandPos[8] = [-3, -14, -11, -22];
global.AghanimHandPos[9] = [11, -22, 3, -14];

function Aghanim_FacingLinkDir()
{
    var _Dir = point_direction(x, y, oLink.x, oLink.y);
    
    if (_Dir >= 45 && _Dir < 135)
        return 1;
    else if ((_Dir >= 0 && _Dir < 45) || (_Dir >= 330 && _Dir <= 360))
        return 4;
    else if (_Dir >= 135 && _Dir < 210)
        return 3;
    else if (_Dir >= 210 && _Dir < 235)
        return 8;
    else if (_Dir >= 235 && _Dir < 305)
        return 2;
    else if (_Dir >= 305 && _Dir < 330)
        return 9;
}

function Aghanim_SetSprite()
{
    switch (Dir)
    {
        case 1:
            sprite_index = sBoss_Aghanim_Up;
            break;
        
        case 2:
            sprite_index = sBoss_Aghanim_Down;
            break;
        
        case 3:
            sprite_index = sBoss_Aghanim_Left;
            break;
        
        case 4:
            sprite_index = sBoss_Aghanim_Right;
            break;
        
        case 8:
            sprite_index = sBoss_Aghanim_DownLeft;
            break;
        
        case 9:
            sprite_index = sBoss_Aghanim_DownRight;
            break;
    }
}

function Aghanim_UpdateCharge()
{
    var _Lerp = clamp(Charge_PosIndex - 0.25, 0, Charge_Lerp);
    
    if (Charge_PosIndex < 0.5)
        Charge_ImageIndex = 2;
    else if (Charge_PosIndex < 0.75)
        Charge_ImageIndex = 1;
    else
        Charge_ImageIndex = 0;
    
    var _HandPosLX = global.AghanimHandPos[Dir][0];
    var _HandPosLY = global.AghanimHandPos[Dir][1];
    var _HandPosRX = global.AghanimHandPos[Dir][2];
    var _HandPosRY = global.AghanimHandPos[Dir][3];
    
    with (Charge_InstL)
    {
        switch (other.Dir)
        {
            case 3:
                depth = other.depth - 5;
                break;
            
            case 1:
            case 4:
                depth = other.depth + 5;
                break;
            
            case 9:
                depth = other.depth - 3;
                break;
            
            default:
                depth = other.depth - 5;
                break;
        }
        
        x = other.x + lerp(_HandPosLX, _HandPosRX, _Lerp);
        y = other.y + lerp(_HandPosLY, _HandPosRY, _Lerp);
        image_index = other.Charge_ImageIndex;
    }
    
    with (Charge_InstR)
    {
        switch (other.Dir)
        {
            case 3:
                depth = other.depth + 5;
                break;
            
            case 1:
                depth = other.depth + 5;
                break;
            
            case 8:
                depth = other.depth - 3;
                break;
            
            default:
                depth = other.depth - 5;
                break;
        }
        
        x = other.x + lerp(_HandPosRX, _HandPosLX, _Lerp);
        y = other.y + lerp(_HandPosRY, _HandPosLY, _Lerp);
        image_index = other.Charge_ImageIndex;
    }
}

function Aghanim_DropBomb(arg0, arg1)
{
    var _BombInst = instance_create_layer(arg0, arg1, "Objs_Upper", oBomb);
    
    with (_BombInst)
    {
        z = 48;
        vz = -0.5;
        State = UnknownEnum.Value_4;
        Red = true;
        ObjSetY(y);
        alarm[0] = 55;
    }
    
    var _PoofInst = instance_create_layer(arg0, arg1 - 32, EffectLayer(1), oPoof_NoSound);
    audio_play_sound(Sound_SwordBeam, 1, false);
    audio_play_sound(Sound_Fall, 1, false);
}

function Aghanim_TakingItems()
{
    if (global.Level.Index == UnknownEnum.Value_13)
    {
        with (oBoss_Aghanim)
        {
            if (Intro && TakeItems && TakeItems_ShowBag)
                return true;
        }
    }
    
    return false;
}

enum UnknownEnum
{
    Value_4 = 4,
    Value_13 = 13
}
