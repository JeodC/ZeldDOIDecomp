global.AltTab = false;
global.AltTab_OldGain = 0;
global.OldWinFocus = false;

function AltTabCheck()
{
    var CurrentWinFocus = window_has_focus();
    
    if (!global.OldWinFocus && CurrentWinFocus)
    {
        display_reset(0, true);
        display_set_timing_method(1);
    }
    
    global.OldWinFocus = CurrentWinFocus;
    
    if (!global.AltTabPause)
        exit;
    
    if (CurrentWinFocus && global.AltTab)
    {
        audio_set_master_gain(0, global.AltTab_OldGain);
        global.AltTab = false;
    }
    
    if (!CurrentWinFocus && !global.AltTab)
    {
        global.AltTab_OldGain = audio_get_master_gain(0);
        audio_set_master_gain(0, 0);
        global.AltTab = true;
    }
}

function EncodeDataToBuffer(arg0)
{
    var JSONStr = json_stringify(arg0);
    var Buffer = buffer_create(string_byte_length(JSONStr) + 1, buffer_fixed, 1);
    buffer_write(Buffer, buffer_string, JSONStr);
    return Buffer;
}

function RealToBool(arg0)
{
    return (arg0 != 0) ? true : false;
}

function AngleCheck(arg0)
{
    if (arg0 < 0)
        return arg0 + 360;
    
    if (arg0 >= 360)
        return arg0 - 360;
    
    return arg0;
}

function Array_Create2D(arg0, arg1, arg2 = 0)
{
    var NewArray = 0;
    
    for (var _y = 0; _y < arg1; _y++)
        NewArray[_y] = array_create(arg0, arg2);
    
    return NewArray;
}

function Array_Create3D(arg0, arg1, arg2, arg3 = 0)
{
    var NewArray = 0;
    
    for (var _z = 0; _z < arg2; _z++)
    {
        for (var _y = 0; _y < arg1; _y++)
            NewArray[_z][_y] = array_create(arg0, arg3);
    }
    
    return NewArray;
}

function Surface_Clear(arg0)
{
    surface_set_target(arg0);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
}

function Surface_ClearToColor(arg0, arg1)
{
    surface_set_target(arg0);
    draw_clear_alpha(arg1, 1);
    surface_reset_target();
}

function dec_to_hex(arg0, arg1 = 1)
{
    var hex = "";
    
    if (arg0 < 0)
        arg1 = max(arg1, ceil(logn(16, 2 * abs(arg0))));
    
    var dig = "0123456789ABCDEF";
    
    while (arg1-- || arg0)
    {
        hex = string_char_at(dig, (arg0 & 15) + 1) + hex;
        arg0 = arg0 >> 4;
    }
    
    return hex;
}

function audio_play_sound_stopall(arg0, arg1 = 1, arg2 = false)
{
    if (audio_is_playing(arg0))
        audio_stop_sound(arg0);
    
    audio_play_sound(arg0, arg1, arg2);
}

function InitPreviewCam()
{
    var _CamX1 = 100000;
    var _CamY1 = 100000;
    var _CamX2 = 0;
    var _CamY2 = 0;
    var _Rooms = array_length(global.Level.Rooms);
    
    for (var _RoomIndex = 0; _RoomIndex < _Rooms; _RoomIndex++)
    {
        var _Room = global.Level.Rooms[_RoomIndex];
        var _RoomX1 = _Room.GridX * 256;
        var _RoomY1 = _Room.GridY * 256;
        var _RoomX2 = _RoomX1 + (_Room.GridW * 256);
        var _RoomY2 = _RoomY1 + (_Room.GridH * 256);
        
        if (_RoomX1 < _CamX1)
            _CamX1 = _RoomX1;
        
        if (_RoomY1 < _CamY1)
            _CamY1 = _RoomY1;
        
        if (_RoomX2 > _CamX2)
            _CamX2 = _RoomX2;
        
        if (_RoomY2 > _CamY2)
            _CamY2 = _RoomY2;
    }
    
    var _CamW = _CamX2 - _CamX1;
    var _CamH = _CamY2 - _CamY1;
    
    if (_CamW > _CamH)
        _CamH = _CamW;
    
    if (_CamH > _CamW)
        _CamW = _CamH;
    
    camera_set_view_size(view_camera[4], _CamW, _CamH);
    camera_set_view_pos(view_camera[4], _CamX1, _CamY1);
}
