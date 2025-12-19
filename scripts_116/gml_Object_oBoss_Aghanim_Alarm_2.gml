if (BombIndex >= BombsTotal)
{
    ScriptNext = true;
    exit;
}

image_index = 2 + (BombIndex % 2);
var _HandPosX, _HandPosY;

switch (image_index)
{
    case 2:
        _HandPosX = x + global.AghanimHandPos[Dir][0];
        _HandPosY = y + global.AghanimHandPos[Dir][1];
        break;
    
    case 3:
        _HandPosX = x + global.AghanimHandPos[Dir][2];
        _HandPosY = y + global.AghanimHandPos[Dir][3];
}

instance_create_layer(_HandPosX, _HandPosY, EffectLayer(1), oSwordBeamHit);
var _BombX = MovePosX[BombPosIndex[BombIndex] % 3];
var _BombY = MovePosY[BombPosIndex[BombIndex] div 3];
Aghanim_DropBomb(_BombX + irandom_range(-16, 16), _BombY + irandom_range(-16, 16));
BombIndex++;
alarm[2] = BombDelay;
