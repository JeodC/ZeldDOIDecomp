function String_Shuffle(arg0)
{
    var ShuffledStr = "";
    var i = 1;
    
    repeat (string_length(arg0))
    {
        ShuffledStr = string_insert(string_char_at(arg0, i), ShuffledStr, irandom(i));
        i += 1;
    }
    
    return ShuffledStr;
}

function SplitStrToArray(arg0, arg1, arg2 = false)
{
    var SplitsArray = array_create(0);
    var slot = 0;
    var str2 = "";
    
    for (var i = 1; i < (string_length(arg0) + 1); i++)
    {
        var currStr = string_copy(arg0, i, 1);
        
        if (currStr == arg1)
        {
            SplitsArray[slot] = arg2 ? real(str2) : str2;
            slot++;
            str2 = "";
        }
        else
        {
            str2 = str2 + currStr;
            SplitsArray[slot] = arg2 ? real(str2) : str2;
        }
    }
    
    return SplitsArray;
}

function CSVToList(arg0)
{
    var SplitList = ds_list_create();
    ds_list_clear(SplitList);
    var temp_str = "";
    
    for (var i = 1; i <= string_length(arg0); i++)
    {
        temp_str += string_char_at(arg0, i);
        
        if (string_char_at(arg0, i + 1) == ",")
        {
            ds_list_add(SplitList, temp_str);
            temp_str = "";
            i++;
        }
    }
    
    ds_list_add(SplitList, temp_str);
    return SplitList;
}

function ArrayToCSV(arg0)
{
    var _ArrayLen = array_length(arg0);
    var _CSV = "";
    
    for (var _ArrayIndex = 0; _ArrayIndex < _ArrayLen; _ArrayIndex++)
        _CSV = string_concat(_CSV, string(arg0[_ArrayIndex]), (_ArrayIndex == (_ArrayLen - 1)) ? "" : ",");
    
    return _CSV;
}

function SplitSentenceToArray(arg0, arg1, arg2)
{
    arg0 += " ";
    var Array = [];
    var SentenceLen = string_length(arg0);
    var LineNo = 0;
    var LineStart = 1;
    draw_set_font(arg1);
    var WordStart;
    
    do
    {
        var LineDone = false;
        var Line = "";
        WordStart = LineStart;
        
        do
        {
            var NextSpace = string_pos_ext(" ", arg0, WordStart);
            var LineTry = string_copy(arg0, LineStart, NextSpace - LineStart);
            var StrW = string_width(LineTry);
            
            if (StrW >= arg2)
            {
                LineStart += (string_length(Line) + 1);
                WordStart = LineStart;
                LineDone = true;
            }
            else
            {
                Line = LineTry;
                WordStart = LineStart + string_length(Line) + 1;
            }
        }
        until (LineDone || WordStart > SentenceLen);
        
        Array[LineNo++] = Line;
    }
    until (WordStart > SentenceLen);
    
    return Array;
}
