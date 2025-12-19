event_inherited();
image_speed = 0;
AnimationEndDestroy = false;
RotDist = 16;
RotSpeed = 45;
RotDir = 1;
RotAngle = 0;
BeamPosX = array_create(4, x);
BeamPosY = array_create(4, y);
BeamColor = 0;
BeamSprites[0] = sSwordBeam_0;
BeamSprites[1] = sSwordBeam_1;
BeamSprite = BeamSprites[BeamColor];
BeamSoundDelay = 14;
alarm[0] = 1;
BeamColorDelay = 8;
alarm[1] = BeamColorDelay;
BeamHit = false;
BeamSound = -4;
vx = 0;
vy = 0;

switch (oLink.Facing)
{
    case 1:
        vy = -Speed;
        break;
    
    case 2:
        vy = Speed;
        RotAngle = 180;
        break;
    
    case 3:
        vx = -Speed;
        RotAngle = 90;
        break;
    
    case 4:
        vx = Speed;
        RotAngle = 90;
        RotDir = -1;
        break;
}

LightIndex = Lighting_CreateLight(RoomIndex, x, y, 1, [0.7, 0.7, 0.7]);
