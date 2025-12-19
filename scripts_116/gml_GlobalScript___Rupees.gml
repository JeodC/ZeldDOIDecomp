function Rupee_PickAmount(arg0)
{
    var _Amount = 1;
    
    switch (arg0)
    {
        default:
            _Amount = choose(1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 10, 10, 10, 10, 20, 20);
            break;
        
        case UnknownEnum.Value_15:
            _Amount = choose(1, 1, 1, 1, 1, 1, 5, 5, 10);
            break;
        
        case UnknownEnum.Value_16:
            _Amount = choose(1, 1, 1, 1, 1, 1, 5, 5, 5, 10, 10, 20);
            break;
        
        case UnknownEnum.Value_17:
            _Amount = choose(1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 10, 10, 10, 20, 20, 40);
            break;
        
        case UnknownEnum.Value_18:
            _Amount = choose(1, 1, 5, 5, 5, 5, 5, 5, 5, 10, 10, 10, 10, 10, 10, 10, 20, 20, 20, 40, 40);
            break;
        
        case UnknownEnum.Value_2:
            _Amount = choose(1, 5, 5, 10, 10, 10, 20, 20, 20, 20, 20, 25, 25, 25, 25, 25, 25, 25, 30, 30, 30, 30, 30, 30, 30, 30, 30, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 100, 100, 100, 100, 100, 100, 100, 100, 125, 125, 125, 125, 150, 150, choose(150, 150, 150, 175, 175, 175, 200, 200, 225, 250, 275, 300));
            
            if (global.Level.Index <= UnknownEnum.Value_2 && _Amount > 150)
                _Amount = 150;
            
            break;
        
        case UnknownEnum.Value_3:
            _Amount = choose(125, 150, 175, 200, 225, 250);
            break;
        
        case UnknownEnum.Value_5:
            _Amount = choose(60, 75, 80);
            break;
        
        case UnknownEnum.Value_6:
            _Amount = choose(80, 100);
            break;
        
        case UnknownEnum.Value_7:
            _Amount = choose(100, 125, 150);
            break;
        
        case UnknownEnum.Value_8:
            _Amount = choose(150, 150, 150, 150, 175, 175, 175, 200, 200, 225, 250, 275, 300);
            break;
        
        case UnknownEnum.Value_21:
            _Amount = 1;
            break;
    }
    
    return _Amount;
}

function Rupee_GetIndex(arg0)
{
    if (arg0 < 5)
        return 0;
    else if (arg0 >= 5 && arg0 < 20)
        return 1;
    else if (arg0 >= 20 && arg0 <= 60)
        return 2;
    else if (arg0 > 60 && arg0 <= 100)
        return 3;
    else if (arg0 > 100 && arg0 < 200)
        return 4;
    else if (arg0 >= 200)
        return 5;
}

function Rupee_Init(arg0)
{
    Amount = arg0;
    ShowAmount = Amount > 5;
    Index = Rupee_GetIndex(arg0);
}

function RupeePatterns_Init()
{
    global.RupeePatternSizeID[1][1] = UnknownEnum.Value_0;
    global.RupeePatternSizeID[5][5] = UnknownEnum.Value_1;
    global.RupeePatternSizeID[3][7] = UnknownEnum.Value_2;
    var i = 0;
    global.RupeePatterns[UnknownEnum.Value_0][0] = ["0"];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".000.", "00000", "00000", "00000", ".000."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["00000", "00000", "00000", "00000", "00000"];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".000.", ".000.", ".000.", ".000.", ".000."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".....", "00000", "00000", "00000", "....."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".....", ".000.", ".000.", ".000.", "....."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".....", ".000.", ".000.", ".000.", "....."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".....", ".000.", ".000.", ".000.", "....."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["0.0.0", ".0.0.", "0.0.0", ".0.0.", "0.0.0"];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".0.0.", "0.0.0", ".0.0.", "0.0.0", ".0.0."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["..0..", "..0..", "00000", "..0..", "..0.."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["0.0.0", ".000.", "00000", ".000.", "0.0.0"];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["0.0.0", "0.0.0", "0.0.0", "0.0.0", "0.0.0"];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["00000", ".....", "00000", ".....", "00000"];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["00000", ".000.", "00000", ".000.", "00000"];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["0.0.0", "00000", "00000", "00000", "0.0.0"];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".....", ".000.", "00000", ".000.", "....."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".....", ".000.", "00000", ".000.", "....."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".....", ".000.", "00000", ".000.", "....."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["..0..", ".000.", ".000.", ".000.", "..0.."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["..0..", ".000.", ".000.", ".000.", "..0.."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["..0..", ".000.", ".000.", ".000.", "..0.."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".000.", "00000", ".000.", "00000", ".000."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["0...0", "00000", ".000.", "00000", "0...0"];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = [".....", "00000", ".000.", "00000", "....."];
    global.RupeePatterns[UnknownEnum.Value_1][i++] = ["0...0", ".000.", ".000.", ".000.", "0...0"];
    i = 0;
    global.RupeePatterns[UnknownEnum.Value_2][i++] = [".0.", "000", "000", "000", "000", "000", ".0."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["000", "000", "000", "000", "000", "000", "000"];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0"];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["0.0", ".0.", "0.0", ".0.", "0.0", ".0.", "0.0"];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = [".0.", "0.0", ".0.", "0.0", ".0.", "0.0", ".0."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["...", "000", "000", "000", "000", "000", "..."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["...", ".0.", "000", "000", "000", ".0.", "..."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["...", ".0.", "000", "000", "000", ".0.", "..."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["...", ".0.", "000", "000", "000", ".0.", "..."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["000", "000", "...", "...", "...", "000", "000"];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = [".0.", "000", ".0.", "...", ".0.", "000", ".0."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = [".0.", ".0.", ".0.", ".0.", ".0.", ".0.", ".0."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["000", "...", "000", "...", "000", "...", "000"];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["...", "000", "...", "000", "...", "000", "..."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["...", "000", "...", "000", "...", "000", "..."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["...", "...", "000", "000", "000", "...", "..."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = ["...", "...", "000", "000", "000", "...", "..."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = [".0.", ".0.", ".0.", "000", ".0.", ".0.", ".0."];
    global.RupeePatterns[UnknownEnum.Value_2][i++] = [".0.", ".0.", ".0.", "000", ".0.", ".0.", ".0."];
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_5 = 5,
    Value_6,
    Value_7,
    Value_8,
    Value_15 = 15,
    Value_16,
    Value_17,
    Value_18,
    Value_21 = 21
}
