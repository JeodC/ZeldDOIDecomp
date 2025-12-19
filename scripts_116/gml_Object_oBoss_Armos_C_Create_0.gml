State = UnknownEnum.Value_0;
RoomX = global.Level.Rooms[RoomIndex].x;
RoomY = global.Level.Rooms[RoomIndex].y;
alarm[1] = 160;
vz = 0;
z = 0;
MoveSpeed = 1.25;
JumpSpeed = 3;
ShakeOffset = 0;
ShakeDir = 1;
ArmosCount = 6;
ArmosLeft = ArmosCount;
WaypointPatterns = 4;
WaypointsX = array_create(WaypointPatterns);
WaypointsY = array_create(WaypointPatterns);
WaypointsX[UnknownEnum.Value_0] = array_create(ArmosCount);
WaypointsY[UnknownEnum.Value_0] = array_create(ArmosCount);
WaypointsX[UnknownEnum.Value_1] = array_create(ArmosCount);
WaypointsY[UnknownEnum.Value_1] = array_create(ArmosCount);
WaypointsX[UnknownEnum.Value_2] = array_create(ArmosCount);
WaypointsY[UnknownEnum.Value_2] = array_create(ArmosCount);
WaypointsX[UnknownEnum.Value_3] = array_create(ArmosCount);
WaypointsY[UnknownEnum.Value_3] = array_create(ArmosCount);
WaypointScript = ds_grid_create(2, WaypointPatterns);
var Line = 0;
ds_grid_set(WaypointScript, 0, Line, UnknownEnum.Value_0);
ds_grid_set(WaypointScript, 1, Line, 130);
Line++;
ds_grid_set(WaypointScript, 0, Line, UnknownEnum.Value_1);
ds_grid_set(WaypointScript, 1, Line, 460);
Line++;
ds_grid_set(WaypointScript, 0, Line, UnknownEnum.Value_2);
ds_grid_set(WaypointScript, 1, Line, 170);
Line++;
ds_grid_set(WaypointScript, 0, Line, UnknownEnum.Value_3);
ds_grid_set(WaypointScript, 1, Line, 120);
WaypointScriptIndex = 0;
CircleX = RoomX + 128;
CircleY = RoomY + 128;
CircleRadius = 75;
CircleRadiusMin = 40;
CircleRadiusMax = 75;
CircleAngleStart[0] = -120;
CircleAngleStart[1] = -60;
CircleAngleStart[2] = 0;
CircleAngleStart[3] = -180;
CircleAngleStart[4] = -240;
CircleAngleStart[5] = -300;
CircleRotate = false;
CircleShrink = false;
CircleExpand = false;
LastArmos_Inst = -4;
LastArmos_Jump = false;
LastArmos_JumpTime = 22;
LastArmos_JumpZ = 30;
LastArmos_Stomp = false;
LastArmos_VZ_Jump = LastArmos_JumpZ / LastArmos_JumpTime;
LastArmos_VZ_Stomp = -4;
LastArmos_HeartSpawned = false;
LastArmos_X = 0;
LastArmos_Y = 0;
BossDestroyed = false;
var VarStruct = 
{
    FloorLevel: 1,
    ItemHolding: -1,
    SectionID: SectionID,
    RoomIndex: RoomIndex
};

for (var i = 0; i < ArmosCount; i++)
{
    ArmosInst[i] = instance_create_layer(RoomX + 80 + ((i % 3) * 48), RoomY + 100 + ((i div 3) * 48), "ObjsHighest", oBoss_Armos, VarStruct);
    ArmosInst[i].ID = i;
    ArmosStatus[i] = true;
    WaypointsX[UnknownEnum.Value_0][i] = round(CircleX + (CircleRadius * dcos(CircleAngleStart[i])));
    WaypointsY[UnknownEnum.Value_0][i] = round(CircleY + (CircleRadius * dsin(CircleAngleStart[i])));
    WaypointsX[UnknownEnum.Value_1][i] = round(CircleX + (CircleRadius * dcos(CircleAngleStart[i])));
    WaypointsY[UnknownEnum.Value_1][i] = round(CircleY + (CircleRadius * dsin(CircleAngleStart[i])));
    WaypointsX[UnknownEnum.Value_2][i] = RoomX + 53 + (i * 30);
    WaypointsY[UnknownEnum.Value_2][i] = RoomY + 64;
    WaypointsX[UnknownEnum.Value_3][i] = RoomX + 53 + (i * 30);
    WaypointsY[UnknownEnum.Value_3][i] = RoomY + 216;
}

Sound = -4;
SoundPaused = false;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
