event_inherited();
x = oLink.x;
ObjSetY(oLink.y - 6);
FloorLevel = oLink.FloorLevel;
FloorLevelStr = GetFloorLevelString(FloorLevel);
OutsideCameraDestroy = true;
Speed = 4.5;

switch (oLink.Facing)
{
    case 1:
        vy = -Speed;
        break;
    
    case 2:
        vy = Speed;
        break;
    
    case 3:
        vx = -Speed;
        break;
    
    case 4:
        vx = Speed;
        break;
}

AllowCollision = false;
alarm[0] = 4;
BeamEffectInst = instance_create_layer(x, y, layer, oSwordBeam_Effect, 
{
    RoomIndex: RoomIndex,
    Speed: Speed,
    FloorLevel: FloorLevel
});
