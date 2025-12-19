visible = false;
x += sprite_get_xoffset(sprite_index);
y += sprite_get_yoffset(sprite_index);
FloorLevel = GetFloorLevelID(x, y);
RoomIndex = Dungeon_GetRoomIndex(x, y);
State = UnknownEnum.Value_0;
SprUp = asset_get_index("s" + Name + "_Up");
SprDown = asset_get_index("s" + Name + "_Down");
SprLeft = asset_get_index("s" + Name + "_Left");
SprRight = asset_get_index("s" + Name + "_Right");
WallInst = -4;
Dir = 2;
vx = 0;
vy = 0;
CanPauseObj = true;
LastImageSpeed = image_speed;
DB_Init = false;
DB_Init_Child = false;
DB_Init_GrandChild = false;
DB_InitDone = false;
DB_Started = false;
DB_Started_Child = false;
DB_Started_GrandChild = false;
DB_Delay = false;
DB_Delay_Len = 8;
DialogueIndex = 0;
ResponseIndex = -1;
DialogueIgnore = false;
ItemHolding = -4;
GiveItem = false;

function Dialogue_GetCurrentSentence()
{
    return (ResponseIndex > -1) ? Response[ResponseIndex] : Dialogue[DialogueIndex];
}

function ScriptFunction_Dialogue_NPC_IsQuestion()
{
    var Sentence = Dialogue_GetCurrentSentence();
    return string_char_at(Sentence, 1) == "?";
}

function ScriptFunction_Dialogue_NPC()
{
    var Sentence = Dialogue_GetCurrentSentence();
    
    if (string_char_at(Sentence, 1) == "?")
        Sentence = string_copy(Sentence, 2, string_length(Sentence) - 1);
    
    if (ResponseIndex == -1)
        DialogueIndex = (DialogueIndex + 1) % array_length(Dialogue);
    
    return Sentence;
}

DB_Script = ds_grid_create(4, 5);
var i = 0;
var Addr = 0;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, Addr, method(self, ScriptFunction_Dialogue_NPC_IsQuestion));
ds_grid_set(DB_Script, ++i, Addr, 1);
ds_grid_set(DB_Script, ++i, Addr, 2);
i = 0;
Addr++;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_1);
ds_grid_set(DB_Script, ++i, Addr, method(self, ScriptFunction_Dialogue_NPC));
ds_grid_set(DB_Script, ++i, Addr, 4);
ds_grid_set(DB_Script, ++i, Addr, 3);
i = 0;
Addr++;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, method(self, ScriptFunction_Dialogue_NPC));
ds_grid_set(DB_Script, ++i, Addr, 3);
i = 0;
Addr++;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 0);
i = 0;
Addr++;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;
Addr++;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_5 = 5,
    Value_7 = 7
}
