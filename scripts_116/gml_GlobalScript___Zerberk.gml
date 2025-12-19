global.GridDirX = [0, 0, 1, -1];
global.GridDirY = [-1, 1, 0, 0];
global.GridDirOpposite = [UnknownEnum.Value_1, UnknownEnum.Value_0, UnknownEnum.Value_3, UnknownEnum.Value_2];
global.ZerberkRobotPhraseArray = [Sound_Zerberk_Robot_Phrase_Alert, Sound_Zerberk_Robot_Phrase_Charge, Sound_Zerberk_Robot_Phrase_FightHuman, Sound_Zerberk_Robot_Phrase_HumanDetected, Sound_Zerberk_Robot_Phrase_HumanEscape, Sound_Zerberk_Robot_Phrase_IntruderDetected, Sound_Zerberk_Robot_Phrase_IntruderEscape, Sound_Zerberk_Robot_Phrase_KillHuman, Sound_Zerberk_Robot_Phrase_KillIntruder, Sound_Zerberk_Robot_Phrase_ShootIntruder];
global.ZerberkRobotPhraseIndexes = [];

function Zerberk_Level_Reset()
{
    Zerberk_Level_Destroy();
    LevelGrid = array_create(3);
    
    for (var _GridY = 0; _GridY < 3; _GridY++)
        LevelGrid[_GridY] = array_create(3);
    
    var _SpawnArcade = !SpawnedArcade && Score >= SpawnArcadeScore;
    
    if (State == UnknownEnum.Value_2 || _SpawnArcade)
    {
        WallStatusX = array_create(12);
        WallStatusY = array_create(12);
        WallStatusX[0] = 1;
        WallStatusX[1] = 1;
        WallStatusX[2] = 1;
        WallStatusX[9] = 1;
        WallStatusX[10] = 1;
        WallStatusX[11] = 1;
        WallStatusY[0] = 1;
        WallStatusY[3] = 1;
        WallStatusY[4] = 1;
        WallStatusY[7] = 1;
        WallStatusY[8] = 1;
        WallStatusY[11] = 1;
    }
    else
    {
        Zerberk_Level_Create(irandom(2), irandom(2), LevelGrid);
        WallStatusX = array_create(12, 1);
        WallStatusY = array_create(12, 1);
        
        for (var _GridY = 0; _GridY < 3; _GridY++)
        {
            for (var _GridX = 0; _GridX < 3; _GridX++)
            {
                var _Walls = LevelGrid[_GridY][_GridX];
                var _WallN = (_Walls & 1) != 1;
                var _WallS = (_Walls & 2) != 2;
                var _WallE = (_Walls & 4) != 4;
                var _WallW = (_Walls & 8) != 8;
                var _GridIndex = (_GridY * 3) + _GridX;
                WallStatusX[_GridIndex] = _WallN ? 1 : 0;
                WallStatusX[_GridIndex + 3] = _WallS ? 1 : 0;
                WallStatusY[_GridIndex + _GridY] = _WallW ? 1 : 0;
                WallStatusY[_GridIndex + _GridY + 1] = _WallE ? 1 : 0;
            }
        }
        
        var _ProbKeepWall = 0.8;
        WallStatusX[4] = (WallStatusX[4] == 1) ? (Prob(_ProbKeepWall) ? 1 : 0) : 0;
        WallStatusX[7] = (WallStatusX[7] == 1) ? (Prob(_ProbKeepWall) ? 1 : 0) : 0;
        WallStatusY[5] = (WallStatusY[5] == 1) ? (Prob(_ProbKeepWall) ? 1 : 0) : 0;
        WallStatusY[6] = (WallStatusY[6] == 1) ? (Prob(_ProbKeepWall) ? 1 : 0) : 0;
    }
    
    DoorStart = NextDoorStart;
    DoorEnd = Zerberk_Level_PickEndDoor(DoorStart);
    Zerberk_Level_SetDoors(DoorStart, DoorEnd);
    NextDoorStart = Zerberk_Level_GetOppositeDoor(DoorEnd);
    StartWallData = Zerberk_Level_GetWallIndex(DoorStart);
    EndWallData = Zerberk_Level_GetWallIndex(DoorEnd);
    Hero = instance_create_layer(0, 0, "System", oZerberk_Hero);
    Zerberk_SetHeroStartPos(Hero, DoorStart);
    
    if (_SpawnArcade)
    {
        MiniArcade = instance_create_layer(LevelCornersX[1] + (WallWidth[1] / 2), CamH / 2, "System", oZerberk_MiniArcade);
        EndWallData[0][EndWallData[1]] = 0;
        SpawnedArcade = true;
    }
    else if (State != UnknownEnum.Value_2)
    {
        Level++;
        var _SectionList = ds_list_create_sequence_shuffled(0, 8);
        var _HeroSection = Zerberk_GetSection(Hero.x, Hero.y);
        var _Robots = min(2 + ceil(Level / 4), 8);
        
        while (_Robots > 0)
        {
            var _SectionIndex = ds_list_find_value(_SectionList, 0);
            ds_list_delete(_SectionList, 0);
            
            if (_SectionIndex == _HeroSection)
                continue;
            
            var _XIndex = _SectionIndex % 3;
            var _YIndex = _SectionIndex div 3;
            var _PosX = LevelCornersX[_XIndex] + irandom_range(16, WallWidth[_XIndex] - 16);
            var _PosY = LevelCornersY[_YIndex] + irandom_range(24, WallHeight[_YIndex] - 12);
            var RobotInst = instance_create_layer(_PosX, _PosY, "System", oZerberk_Robot);
            RobotInst.alarm[0] = irandom_range(100, 200);
            RobotInst.alarm[1] = irandom_range(50, 70);
            _Robots--;
        }
        
        ds_list_destroy(_SectionList);
        
        if (array_length(global.ZerberkRobotPhraseIndexes) == 0)
            global.ZerberkRobotPhraseIndexes = array_create_sequence_shuffled(0, 9);
        
        var _PhraseIndex = array_pop(global.ZerberkRobotPhraseIndexes);
        audio_play_sound(global.ZerberkRobotPhraseArray[_PhraseIndex], 1, false);
    }
}

function Zerberk_Level_Create(arg0, arg1, arg2)
{
    var DirList = ds_list_create();
    ds_list_add(DirList, 0, 1, 2, 3);
    ds_list_shuffle(DirList);
    
    for (var _DirIndex = 0; _DirIndex < 4; _DirIndex++)
    {
        var _Dir = ds_list_find_value(DirList, _DirIndex);
        var _GridX_Next = arg0 + global.GridDirX[_Dir];
        var _GridY_Next = arg1 + global.GridDirY[_Dir];
        
        if (_GridX_Next >= 0 && _GridX_Next < 3 && _GridY_Next >= 0 && _GridY_Next < 3 && arg2[_GridY_Next][_GridX_Next] == 0)
        {
            arg2[arg1][arg0] |= power(2, _Dir);
            arg2[_GridY_Next][_GridX_Next] |= power(2, global.GridDirOpposite[_Dir]);
            Zerberk_Level_Create(_GridX_Next, _GridY_Next, arg2);
        }
    }
    
    ds_list_destroy(DirList);
}

function Zerberk_Level_PickEndDoor(arg0)
{
    var _MinDoor = arg0 + 3;
    var _MaxDoor = _MinDoor + 6;
    return ((irandom_range(_MinDoor, _MaxDoor) - 1) % 12) + 1;
}

function Zerberk_Level_SetDoors(arg0, arg1)
{
    Positions[0] = arg0;
    Positions[1] = arg1;
    
    for (var _PositionIndex = 0; _PositionIndex < 2; _PositionIndex++)
    {
        WallData = Zerberk_Level_GetWallIndex(Positions[_PositionIndex]);
        WallData[0][WallData[1]] = 2;
    }
}

function Zerberk_SetHeroStartPos(arg0, arg1)
{
    switch (arg1)
    {
        case 11:
        case 12:
        case 1:
            var _CornerIndexX = StartWallData[1] % 3;
            var _CornerIndexY = StartWallData[1] div 3;
            var _WallX = LevelCornersX[_CornerIndexX];
            var _WallY = LevelCornersY[_CornerIndexY];
            var _WallW = WallWidth[_CornerIndexX];
            arg0.x = (_WallX + (_WallW / 2)) - 1;
            arg0.y = _WallY + 26;
            break;
        
        case 5:
        case 6:
        case 7:
            var _CornerIndexX = StartWallData[1] % 3;
            var _CornerIndexY = StartWallData[1] div 3;
            var _WallX = LevelCornersX[_CornerIndexX];
            var _WallY = LevelCornersY[_CornerIndexY];
            var _WallW = WallWidth[_CornerIndexX];
            arg0.x = (_WallX + (_WallW / 2)) - 1;
            arg0.y = _WallY - 6;
            break;
        
        case 2:
        case 3:
        case 4:
            var _CornerIndexX = StartWallData[1] % 4;
            var _CornerIndexY = StartWallData[1] div 4;
            var _WallX = LevelCornersX[_CornerIndexX];
            var _WallY = LevelCornersY[_CornerIndexY];
            var _WallH = WallHeight[_CornerIndexY];
            arg0.x = _WallX - 12;
            arg0.y = _WallY + (_WallH / 2) + 4;
            arg0.Dir = -1;
            break;
        
        case 8:
        case 9:
        case 10:
            var _CornerIndexX = StartWallData[1] % 4;
            var _CornerIndexY = StartWallData[1] div 4;
            var _WallX = LevelCornersX[_CornerIndexX];
            var _WallY = LevelCornersY[_CornerIndexY];
            var _WallH = WallHeight[_CornerIndexY];
            arg0.x = _WallX + 13;
            arg0.y = _WallY + (_WallH / 2) + 4;
            arg0.Dir = 1;
            break;
    }
}

function Zerberk_Hero_Death()
{
    with (oZerberk_Hero)
    {
        sprite_index = sZerberk_Hero_Dead;
        Dead = true;
    }
    
    global.Arcade_ActiveInst.alarm[2] = 150;
    audio_play_sound(Sound_Zerberk_Hero_Dead, 1, false);
}

function Zerberk_Level_GetWallIndex(arg0)
{
    switch (arg0)
    {
        case 1:
            return [WallStatusX, 2];
        
        case 2:
            return [WallStatusY, 3];
        
        case 3:
            return [WallStatusY, 7];
        
        case 4:
            return [WallStatusY, 11];
        
        case 5:
            return [WallStatusX, 11];
        
        case 6:
            return [WallStatusX, 10];
        
        case 7:
            return [WallStatusX, 9];
        
        case 8:
            return [WallStatusY, 8];
        
        case 9:
            return [WallStatusY, 4];
        
        case 10:
            return [WallStatusY, 0];
        
        case 11:
            return [WallStatusX, 0];
        
        case 12:
            return [WallStatusX, 1];
    }
}

function Zerberk_Level_GetOppositeDoor(arg0)
{
    switch (arg0)
    {
        case 1:
            return 5;
        
        case 2:
            return 10;
        
        case 3:
            return 9;
        
        case 4:
            return 8;
        
        case 5:
            return 1;
        
        case 6:
            return 12;
        
        case 7:
            return 11;
        
        case 8:
            return 4;
        
        case 9:
            return 3;
        
        case 10:
            return 2;
        
        case 11:
            return 7;
        
        case 12:
            return 6;
    }
}

function Zerberk_Level_Destroy()
{
    with (oZerberk_Hero)
        instance_destroy(id);
    
    with (oZerberk_Robot)
        instance_destroy(id);
    
    with (oZerberk_Robot_Destroyed)
        instance_destroy(id);
    
    with (oZerberk_Laser)
        instance_destroy(id);
    
    with (oZerberk_MiniArcade)
        instance_destroy(id);
    
    audio_stop_sound(Sound_Zerberk_Hero_Dead);
    alarm[2] = -1;
}

function Zerberk_InLevel(arg0, arg1)
{
    return point_in_rectangle(arg0, arg1, global.Arcade_ActiveInst.CamX, global.Arcade_ActiveInst.CamY, global.Arcade_ActiveInst.CamX + global.Arcade_ActiveInst.CamW, global.Arcade_ActiveInst.CamY + global.Arcade_ActiveInst.CamH);
}

function Zerberk_GetSection(arg0, arg1)
{
    var _SectionIndex = 0;
    
    for (var _SectionY = 0; _SectionY < 3; _SectionY++)
    {
        for (var _SectionX = 0; _SectionX < 3; _SectionX++)
        {
            var _SectionX1 = LevelCornersX[_SectionX];
            var _SectionY1 = LevelCornersY[_SectionY];
            var _SectionX2 = (_SectionX1 + WallWidth[_SectionX]) - 1;
            var _SectionY2 = (_SectionY1 + WallHeight[_SectionY]) - 1;
            
            if (point_in_rectangle(arg0, arg1, _SectionX1, _SectionY1, _SectionX2, _SectionY2))
                return _SectionIndex;
            
            _SectionIndex++;
        }
    }
    
    return -1;
}

function Zerberk_WallCollisionX(arg0)
{
    for (var _WallX = 0; _WallX < 12; _WallX++)
    {
        if (global.Arcade_ActiveInst.WallStatusX[_WallX] == 0)
            continue;
        
        var _CornerIndexX = _WallX % 3;
        var _CornerIndexY = _WallX div 3;
        var _WallX1 = global.Arcade_ActiveInst.LevelCornersX[_CornerIndexX];
        var _WallY1 = global.Arcade_ActiveInst.LevelCornersY[_CornerIndexY];
        var _WallX2 = (_WallX1 + global.Arcade_ActiveInst.WallWidth[_CornerIndexX]) - 1;
        var _WallY2 = _WallY1 + 3;
        
        if (collision_rectangle(_WallX1, _WallY1, _WallX2, _WallY2, arg0, false, false) != -4)
            return true;
    }
    
    return false;
}

function Zerberk_WallCollisionY(arg0)
{
    for (var _WallY = 0; _WallY < 12; _WallY++)
    {
        if (global.Arcade_ActiveInst.WallStatusY[_WallY] == 0)
            continue;
        
        var _CornerIndexX = _WallY % 4;
        var _CornerIndexY = _WallY div 4;
        var _WallX1 = global.Arcade_ActiveInst.LevelCornersX[_CornerIndexX];
        var _WallY1 = global.Arcade_ActiveInst.LevelCornersY[_CornerIndexY];
        var _WallX2 = _WallX1 + 3;
        var _WallY2 = (_WallY1 + global.Arcade_ActiveInst.WallHeight[_CornerIndexY]) - 1;
        
        if (collision_rectangle(_WallX1, _WallY1, _WallX2, _WallY2, arg0, false, false) != -4)
            return true;
    }
    
    return false;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
