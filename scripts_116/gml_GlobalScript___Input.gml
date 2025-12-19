global.BindingVerbs[UnknownEnum.Value_0] = [UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_6, UnknownEnum.Value_7];
global.BindingVerbs[UnknownEnum.Value_1] = [UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_7];
global.BindingIconCount[UnknownEnum.Value_0] = array_length(global.BindingVerbs[UnknownEnum.Value_0]);
global.BindingIconCount[UnknownEnum.Value_1] = array_length(global.BindingVerbs[UnknownEnum.Value_1]);
global.BindingIcons[UnknownEnum.Value_0] = array_create(global.BindingIconCount[UnknownEnum.Value_0]);
global.BindingIcons[UnknownEnum.Value_1] = array_create(global.BindingIconCount[UnknownEnum.Value_1]);
global.BindingRemap_InputIndex = UnknownEnum.Value_0;
global.BindingRemap_VerbIndex = 0;
global.BindingRemap_Next = false;

function GetInputIndexStr(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return "gamepad";
        
        case UnknownEnum.Value_1:
            return "keyboard";
    }
}

function GetInputID(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return __input_global().__source_gamepad;
        
        case UnknownEnum.Value_1:
            return __input_global().__source_keyboard;
    }
}

function GetInputVerbStr(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return "sword";
        
        case UnknownEnum.Value_1:
            return "action";
        
        case UnknownEnum.Value_2:
            return "item";
        
        case UnknownEnum.Value_4:
            return "strafe";
        
        case UnknownEnum.Value_3:
            return "map";
        
        case UnknownEnum.Value_5:
            return "inventory";
        
        case UnknownEnum.Value_6:
            return "menu_access";
        
        case UnknownEnum.Value_7:
            return "hud";
    }
}

function Bindings_GetIcons(arg0)
{
    var InputIndexStr = GetInputIndexStr(arg0);
    
    for (var i = 0; i < global.BindingIconCount[arg0]; i++)
    {
        var VerbStr = GetInputVerbStr(global.BindingVerbs[arg0][i]);
        var Icon = input_binding_get_icon(input_binding_get(VerbStr, undefined, undefined, InputIndexStr));
        global.BindingIcons[arg0][i] = (Icon == "unknown") ? "" : Icon;
        global.BindingIcons[arg0][i] = string_replace(global.BindingIcons[arg0][i], "empty", "");
        global.BindingIcons[arg0][i] = string_replace(global.BindingIcons[arg0][i], "Empty", "");
        global.BindingIcons[arg0][i] = string_replace(global.BindingIcons[arg0][i], "thumbstick l", "LTS");
        global.BindingIcons[arg0][i] = string_replace(global.BindingIcons[arg0][i], "thumbstick r", "RTS");
        global.BindingIcons[arg0][i] = string_replace(global.BindingIcons[arg0][i], "thumbstick", "TS");
    }
}

function Bindings_Clear(arg0)
{
    var InputIndexStr = GetInputIndexStr(arg0);
    
    for (var i = 0; i < global.BindingIconCount[arg0]; i++)
        input_binding_set(GetInputVerbStr(global.BindingVerbs[arg0][i]), input_binding_empty(), undefined, undefined, InputIndexStr);
}

function input_binding_scan_set_Success(arg0)
{
    switch (arg0.__value)
    {
        default:
            var VerbStr = GetInputVerbStr(global.BindingVerbs[global.BindingRemap_InputIndex][global.BindingRemap_VerbIndex]);
            var InputIndexStr = GetInputIndexStr(global.BindingRemap_InputIndex);
            input_binding_set(VerbStr, arg0, undefined, undefined, InputIndexStr);
            BindingsRemap_CheckNext();
            break;
    }
}

function input_binding_scan_set_Failure(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_m10:
        case UnknownEnum.Value_m11:
        case UnknownEnum.Value_m21:
            global.BindingRemap_Next = true;
            break;
        
        case UnknownEnum.Value_m20:
        case UnknownEnum.Value_m16:
        case UnknownEnum.Value_m15:
            BindingsRemap_Exit();
            break;
        
        default:
            input_binding_set(GetInputVerbStr(global.BindingRemap_VerbIndex), input_binding_empty(), undefined, undefined, GetInputIndexStr(global.BindingRemap_InputIndex));
            BindingsRemap_CheckNext();
            break;
    }
}

function BindingsRemap_CheckNext()
{
    if (global.BindingRemap_VerbIndex < (global.BindingIconCount[global.BindingRemap_InputIndex] - 1))
    {
        global.BindingRemap_VerbIndex++;
        global.BindingRemap_Next = true;
    }
    else
    {
        User_SaveControls();
        BindingsRemap_Exit();
    }
    
    Bindings_GetIcons(global.BindingRemap_InputIndex);
}

function BindingsRemap_Exit()
{
    oMenu.Bindings_Remap = false;
    oMenu.Menu_Active = true;
    input_binding_scan_abort();
    input_binding_scan_params_clear();
    io_clear();
    input_clear_momentary(true);
    instance_destroy(oInputRemap);
}

enum UnknownEnum
{
    Value_m21 = -21,
    Value_m20,
    Value_m16 = -16,
    Value_m15,
    Value_m11 = -11,
    Value_m10,
    Value_0 = 0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7
}
