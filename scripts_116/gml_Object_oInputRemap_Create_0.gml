global.BindingRemap_InputIndex = InputIndex;
global.BindingRemap_VerbIndex = 0;
InputID = GetInputID(global.BindingRemap_InputIndex);
Bindings_Clear(InputIndex);
Bindings_GetIcons(InputIndex);

switch (global.BindingRemap_InputIndex)
{
    case UnknownEnum.Value_0:
        input_binding_scan_params_set([32785, 32786, 32787, 32788, 32783, 32784, 32781, 32782], [32769, 32770, 32771, 32772, 32777, 32778, 32773, 32774, 32775, 32776, 32779, 32780]);
        break;
    
    case UnknownEnum.Value_1:
        input_binding_scan_params_set([37, 39, 38, 40, 27], [162, 163, 164, 165, 32, 16, 13, 36, 35, 33, 34, 45, 46, 188, 190, 220, 222, 189, 187, 186, 222, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 110, 111, 106, 109, 107, "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]);
        break;
}

oMenu.Bindings_Remap = true;
oMenu.Menu_Active = false;
global.BindingRemap_Next = true;

enum UnknownEnum
{
    Value_0,
    Value_1
}
