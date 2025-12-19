event_inherited();
visible = true;
RoomX = global.Level.Rooms[RoomIndex].x;
RoomY = global.Level.Rooms[RoomIndex].y;
Dir = 270;
DirV = 0;
EyeA = 270;
Speed[0] = 1.6;
Speed[1] = 2.2;
SpeedIndex = 0;
LowEnergy = 7;
KnockBackEnabled = false;
WallCollide_Bounce = true;
CanHurtLink = false;
HuntLink = false;
var VarStruct = 
{
    FloorLevel: 1,
    ItemHolding: -1,
    SectionID: 0,
    RoomIndex: RoomIndex
};
BodyInst[UnknownEnum.Value_0] = instance_create_layer(x, y, "ObjsHigher_Upper", oBoss_Moldorm_BodyL, VarStruct);
BodyInst[UnknownEnum.Value_1] = instance_create_layer(x, y, "ObjsHigher_Upper", oBoss_Moldorm_BodyL, VarStruct);
BodyInst[UnknownEnum.Value_2] = instance_create_layer(x, y, "ObjsHigher_Upper", oBoss_Moldorm_BodyS, VarStruct);
BodyInst[UnknownEnum.Value_3] = instance_create_layer(x, y, "ObjsHigher_Upper", oBoss_Moldorm_Tail, VarStruct);
BodyInst[UnknownEnum.Value_0].depth = depth + 1;
BodyInst[UnknownEnum.Value_1].depth = depth + 2;
BodyInst[UnknownEnum.Value_2].depth = depth + 3;
BodyInst[UnknownEnum.Value_3].depth = depth + 4;
PPX = array_create(49, x);
PPY = array_create(49, y);
PP[UnknownEnum.Value_0][0] = 16;
PP[UnknownEnum.Value_0][1] = 10;
PP[UnknownEnum.Value_1][0] = 29;
PP[UnknownEnum.Value_1][1] = 19;
PP[UnknownEnum.Value_2][0] = 40;
PP[UnknownEnum.Value_2][1] = 26;
PP[UnknownEnum.Value_3][0] = 48;
PP[UnknownEnum.Value_3][1] = 31;
FinalExplosions = 8;
ShowHead = true;
BossDestroyed = false;
HeartCollected = false;
Sound = -4;
SoundPaused = false;
ObjSetImageSpeed(image_speed);
Enemy_UpdateState(UnknownEnum.Value_8);
alarm[0] = 200;
Init = true;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_8 = 8
}
