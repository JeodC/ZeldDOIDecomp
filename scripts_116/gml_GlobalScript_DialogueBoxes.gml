global.DB_Inst = -4;
global.DB_ExitCode = 0;
global.DB_MsgBoxQueue = ds_queue_create();

function MsgBox(arg0, arg1 = false, arg2 = -4, arg3 = undefined, arg4 = 144)
{
    var _Inst = -4;
    
    if (global.DB_Inst != -4)
    {
        ds_queue_enqueue(global.DB_MsgBoxQueue, [arg0, arg1, arg2, arg3]);
    }
    else
    {
        _Inst = instance_create_layer(0, 0, "System", oDialogueBox_Msg, 
        {
            Msg: arg0,
            YesNo: arg1,
            Method: arg3,
            Y: arg4
        });
        
        if (arg2 != -4)
            audio_play_sound_stopall(arg2);
    }
    
    return _Inst;
}

function DialogueCycle(arg0, arg1)
{
    var _Dialogues = array_length(arg0);
    var _SavedArraySize = array_length(arg1);
    
    if (_SavedArraySize >= _Dialogues)
        array_delete(arg1, 0, _SavedArraySize);
    
    var _UnusedDialogues = [];
    
    for (var i = 0; i < _Dialogues; i++)
    {
        if (!array_contains(arg1, i))
            array_push(_UnusedDialogues, i);
    }
    
    _UnusedDialogues = array_shuffle(_UnusedDialogues);
    var _DialogueIndex = _UnusedDialogues[0];
    array_push(arg1, _DialogueIndex);
    User_Save();
    return _DialogueIndex;
}
