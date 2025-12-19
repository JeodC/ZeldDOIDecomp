RoomTransition = 0;
RoomTransitionInit = false;
global.CurrentRoomIndex = -1;
global.TransitionRoomIndex = -1;
TransitionEndX = 0;
TransitionEndY = 0;
OpenTransition = false;
X = 0;
Y = 0;
W = camera_get_view_width(view_camera[1]);
H = camera_get_view_height(view_camera[1]);
W_2 = W / 2;
H_2 = H / 2;
X2 = 0;
Y2 = 0;
DungeonGridX = -1;
DungeonGridY = -1;
MoveSpeed = 8;
ShakeAmount = 0;
Override = false;
ResetEnemies = false;

function SetToRoomIndex(arg0, arg1 = false, arg2 = true)
{
    if (arg1)
        Dungeon_RoomActivate(arg0);
    
    if (argument_count == 5)
    {
        X = argument[1];
        Y = argument[2];
    }
    
    if (arg2)
        Enemy_Reset(arg0);
    
    if (global.Level.Index != UnknownEnum.Value_0)
        Dungeon_RoomDeActivate(global.CurrentRoomIndex);
    
    SetCurrentRoom(arg0);
}

function SetCurrentRoom(arg0)
{
    global.CurrentRoom = global.Level.DungeonTemplate.Rooms[arg0];
    global.CurrentRoomIndex = arg0;
    global.CurrentRoomX = global.CurrentRoom.x;
    global.CurrentRoomY = global.CurrentRoom.y;
    global.CurrentRoomW = global.CurrentRoom.width;
    global.CurrentRoomH = global.CurrentRoom.height;
}

function InView(arg0, arg1)
{
    return point_in_rectangle(arg0, arg1, X, Y, X2, Y2);
}

function Cam_UpdatePos()
{
    Cam_SetPos(oLink.x - W_2, oLink.y - H_2 - 22);
    
    if (X < global.CurrentRoom.x)
        X = global.CurrentRoom.x;
    
    if (Y < global.CurrentRoom.y)
        Y = global.CurrentRoom.y;
    
    if ((X + W) > (global.CurrentRoom.x + global.CurrentRoom.width))
        X = (global.CurrentRoom.x + global.CurrentRoom.width) - W;
    
    if ((Y + H) > ((global.CurrentRoom.y + global.CurrentRoom.height) - 16))
        Y = (global.CurrentRoom.y + global.CurrentRoom.height) - H - 16;
    
    DungeonGridX = round(X / 256);
    DungeonGridY = round(Y / 256);
}

function Cam_InitTransitionRoom(arg0, arg1 = false)
{
    if (arg1)
    {
        MoveSpeed = 8;
        oCamera.OpenTransition = true;
    }
    else
    {
        oLink.x = round(oLink.x / 2) * 2;
        oLink.y = round(oLink.y / 2) * 2;
        MoveSpeed = 4;
    }
    
    Cam_UpdatePos();
    var DirX = 0;
    var DirY = 0;
    
    switch (arg0)
    {
        case 3:
            DirX = -1;
            break;
        
        case 4:
            DirX = 1;
            break;
        
        case 1:
            DirY = -1;
            break;
        
        case 2:
            DirY = 1;
            break;
    }
    
    TransitionEndX = X + (DirX * 256);
    TransitionEndY = Y + (DirY * 240);
    DungeonGridX += DirX;
    DungeonGridY += DirY;
    oLink.AutoMoveDirX = DirX;
    oLink.AutoMoveDirY = DirY;
    RoomTransition = arg0;
    global.TransitionRoomIndex = global.Level.Map_RoomIndex[DungeonGridY][DungeonGridX];
    
    if (global.TransitionRoomIndex == -1)
    {
        RoomTransition = 0;
        exit;
    }
    
    global.TransitionRoom = global.Level.DungeonTemplate.Rooms[global.TransitionRoomIndex];
    StopStar();
    
    with (oLink)
        Link_SetAutoMove(DirX, DirY, AutoMoveSpeed);
    
    var NextRoomSongIndex = global.Level.Rooms[global.TransitionRoomIndex].RoomSongIndex;
    
    if (oMusic.SongPlaying_Index != NextRoomSongIndex)
        Music_Fade(0, 70, NextRoomSongIndex);
}

function Cam_SetPos(arg0, arg1)
{
    X = arg0;
    Y = arg1;
    X2 = (X + W) - 1;
    Y2 = (Y + H) - 1;
}

enum UnknownEnum
{
    Value_0
}
