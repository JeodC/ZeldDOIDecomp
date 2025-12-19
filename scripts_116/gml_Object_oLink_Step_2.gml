if (InitNewDungeon)
{
    Time_PauseStart();
    
    if (Dungeon_IsSaveLevel(global.Level.Index + 1) && !global.SaveLevel)
    {
        global.SaveLevel = true;
        Dungeon_InitSaveLevel(global.Level.Index);
    }
    else
    {
        global.SaveLevel = false;
        Dungeon_InitLevel(++global.Level.Index);
    }
    
    if (global.Level.StartDir == 1)
        sprite_index = global.LinkSpr_Descending_Bottom2;
    else
        sprite_index = global.LinkSpr_Descending_Top2;
    
    with (oDoor)
    {
        if (!Entrance)
            continue;
        
        var _LinkPosY = y + ((global.Level.StartDir == 1) ? 15 : 23);
        other.y = _LinkPosY;
        var TMID = (FloorLevel == 1) ? global.TMID_Decor_Upper : global.TMID_Decor_Lower;
        
        switch (Location)
        {
            case "Top":
                DrawTileBlock(TMID, x, y + 8, 70, 4 + ((global.Level.Index - 1) * 6), 1, 2);
                DrawTileBlock(TMID, x + 24, y + 8, 71, 4 + ((global.Level.Index - 1) * 6), 1, 2);
                DrawTileBlock(TMID, x + 8, y + 8, 58, 4 + ((global.Level.Index - 1) * 6) + 2, 2, 2);
                break;
            
            case "Bottom":
                var _TilesY = (global.Level.Index == UnknownEnum.Value_13) ? 70 : (4 + ((global.Level.Index - 1) * 6));
                DrawTileBlock(TMID, x, y, 72, _TilesY + 2, 1, 2);
                DrawTileBlock(TMID, x + 24, y, 73, _TilesY + 2, 1, 2);
                DrawTileBlock(TMID, x + 8, y, 60, _TilesY + 4, 2, 2);
                break;
        }
    }
    
    if (DescendingPhase == 2)
        alarm[9] = 4;
    
    Time_PauseEnd();
    InitNewDungeon = false;
}

if (State == UnknownEnum.Value_23 && !global.MosaicDo)
{
    Warp_Engage = false;
    UpdateState(UnknownEnum.Value_1);
}

AghanimTakingItems = Aghanim_TakingItems();

if (AghanimTakingItems && Cape)
    instance_destroy(oCape);

if (global.Level.Rooms[global.CurrentRoomIndex].TemplateName == "Arcade")
{
    Lighting_UpdateLinkLight(undefined, undefined, [0, 0, 0]);
    exit;
}

Lighting_UpdateLinkLight([x, y - 6]);
LampFlickerDist += (LampFlickerDir * 0.005);

if (LampFlickerDir == 1 && LampFlickerDist >= LampMaxFlickerLen)
{
    LampFlickerDist = LampMaxFlickerLen;
    LampFlickerDir *= -1;
    LampMaxFlickerLen = random_range(0.01, LampFlickerMaxLen);
}
else if (LampFlickerDir == -1 && LampFlickerDist <= 0)
{
    LampFlickerDist = 0;
    LampFlickerDir *= -1;
}

var LinkLampStrength = LampStrength[global.Inventory_ItemData[UnknownEnum.Value_24].Owns[0] ? 1 : 0] + LampFlickerDist;
var DoorFadeFactor = 1;

if (InDoorPassage != 0)
{
    var FadeSpeed = 28;
    var FadeFactor1, FadeFactor2;
    
    switch (PassageOrientation)
    {
        case 0:
            FadeFactor1 = clamp(1 - (((DoorPassage[3] - y) + 15) / FadeSpeed), 0, 1);
            FadeFactor2 = clamp(1 - ((y - DoorPassage[1] - 5) / FadeSpeed), 0, 1);
            break;
        
        case 1:
            FadeFactor1 = clamp(1 - (((DoorPassage[2] + 7) - x) / FadeSpeed), 0, 1);
            FadeFactor2 = clamp(1 - (((x - DoorPassage[0]) + 7) / FadeSpeed), 0, 1);
            break;
    }
    
    DoorFadeFactor = FadeFactor1 + FadeFactor2;
    var _LightX = x;
    var _LightY = y;
    
    switch (PassageOrientation)
    {
        case 0:
            var DistToBottom = abs(y - 6 - DoorPassage[3]);
            var DistToTop = abs(y - 6 - DoorPassage[1]);
            
            if (DistToBottom < DistToTop)
                _LightY = DoorPassage[3] + 10;
            else
                _LightY = DoorPassage[1] - 8;
            
            break;
        
        case 1:
            var DistToRight = abs(x - DoorPassage[2]);
            var DistToLeft = abs(x - DoorPassage[0]);
            
            if (DistToRight < DistToLeft)
            {
                _LightX = DoorPassage[2] + 10;
                _LightY = y - 6;
            }
            else
            {
                _LightX = DoorPassage[0] - 8;
                _LightY = y - 6;
            }
            
            break;
    }
    
    Lighting_UpdateLinkLight([_LightX, _LightY]);
    LinkLampStrength *= DoorFadeFactor;
    
    if (BounceBack)
    {
        vx = 0;
        vy = 0;
    }
}

var MinFade = (InDoorPassage != 0) ? 0 : (0.4 - ((global.Inventory_ItemData[UnknownEnum.Value_24].Owns[0] ? 1 : 0) * 0.075));

if (State == UnknownEnum.Value_19)
{
    LinkLampStrength = LampStrength[2];
    var _StarLightIndex = floor(StarLightIndex);
    var _r = StarLightColors[_StarLightIndex][0];
    var _g = StarLightColors[_StarLightIndex][1];
    var _b = StarLightColors[_StarLightIndex][2];
    
    if (_r < 0)
        _r = 1;
    
    if (_g < 0)
        _g = 1;
    
    if (_b < 0)
        _b = 1;
    
    LampLightR = clamp(_r * DoorFadeFactor, MinFade, _r);
    LampLightG = clamp(_g * DoorFadeFactor, MinFade, _g);
    LampLightB = clamp(_b * DoorFadeFactor, MinFade, _b);
}
else if (global.Level.Rooms[global.CurrentRoomIndex].Heat)
{
    LampLightR = clamp(LampLightMaxR * DoorFadeFactor * 1.25, MinFade, LampLightMaxR * 1.25);
    LampLightG = clamp((LampLightMaxG / 2) * DoorFadeFactor, MinFade, LampLightMaxG / 2);
    LampLightB = clamp((LampLightMaxB / 2) * DoorFadeFactor, MinFade, LampLightMaxB / 2);
}
else
{
    LampLightR = clamp(LampLightMaxR * DoorFadeFactor, MinFade, LampLightMaxR);
    LampLightG = clamp(LampLightMaxG * DoorFadeFactor, MinFade, LampLightMaxG);
    LampLightB = clamp(LampLightMaxB * DoorFadeFactor, MinFade, LampLightMaxB);
}

if (House_Leaving || Castle_Entering)
    LinkLampStrength = 0;

Lighting_UpdateLinkLight(undefined, LinkLampStrength, [LampLightR, LampLightG, LampLightB]);

enum UnknownEnum
{
    Value_1 = 1,
    Value_13 = 13,
    Value_19 = 19,
    Value_23 = 23,
    Value_24
}
