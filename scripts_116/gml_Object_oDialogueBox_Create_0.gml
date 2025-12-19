if (!variable_instance_exists(id, "Y"))
    Y = 144;

TextColor = 16777215;
Surface = -1;
SurfaceW = 186;
SurfaceH = 0;
SurfaceMaxH = 48;
SurfaceY = 0;
SurfaceShiftDelay = 0;
SurfaceShiftDelayLastState = 0;
CenterText = false;
BoxCenter = SurfaceW / 2;
ShowBox = true;
Script = -1;
ScriptPos = 0;
ScriptCode = 0;
ScriptNext = true;
InputChoice = 0;
InputChoices = 0;
DialogueArray = "";
LinesLeft = 0;
Status = -1;
GotoFlag = false;
depth = -2000;

if (variable_instance_exists(id, "Method"))
{
    if (Method != undefined)
        Method();
}

CameraExists = instance_exists(oCamera);

if (!CameraExists)
    exit;

if (oCamera.RoomTransition == 0 && oLink.State != UnknownEnum.Value_5)
{
    with (oLink)
        UpdateState(UnknownEnum.Value_25);
    
    global.Paused = true;
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_25 = 25
}
