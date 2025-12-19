global.Time_PlayingStart = 0;
global.Time_PausedStart = -1;
global.Time_PausedTotal = 0;
global.Time_PlayingTotalEnd = 0;
global.Time_PlayingTotalSaved = 0;

function Time_Str(arg0)
{
    arg0 = arg0 / 1000000;
    var _MSecs = floor(frac(arg0) * 100);
    var _Secs = floor(arg0 % 60);
    var _Mins = floor(arg0 / 60) % 60;
    var _Hours = floor(arg0 / 3600);
    var _ShowHours = _Hours > 0;
    var _ShowMins = _Mins > 0 || _ShowHours;
    var _MinScoreText = _ShowHours;
    var _SecScoreText = _ShowMins;
    var _TimeStr = "";
    
    if (_ShowHours)
        _TimeStr += (string(_Hours) + ":");
    
    if (_ShowMins)
    {
        if (_MinScoreText)
            _TimeStr += (ScoreText(_Mins, 2) + ":");
        else
            _TimeStr += (string(_Mins) + ":");
    }
    
    if (_SecScoreText)
        _TimeStr += ScoreText(_Secs, 2);
    else
        _TimeStr += string(_Secs);
    
    _TimeStr += ("." + ScoreText(_MSecs, 2));
    return _TimeStr;
}

function Time_PlayingStart()
{
    global.Time_PlayingTotalEnd = 0;
    global.Time_PlayingTotalSaved = 0;
    global.Time_PausedTotal = 0;
    global.Time_PlayingStart = get_timer();
}

function Time_PlayingTotal()
{
    return (get_timer() - global.Time_PlayingStart - global.Time_PausedTotal) + global.Time_PlayingTotalSaved;
}

function Time_PauseStart()
{
    global.Time_PausedStart = get_timer();
}

function Time_PauseEnd()
{
    if (global.Time_PausedStart == -1)
        exit;
    
    var _PauseTime = get_timer() - global.Time_PausedStart;
    global.Time_PausedTotal += _PauseTime;
    global.Time_PausedStart = -1;
}
