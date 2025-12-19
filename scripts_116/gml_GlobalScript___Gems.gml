global.GemNames = ["Quartz", "Amethyst", "Citrine", "Turquoise", "Jade", "Diamond", "Ruby", "Sapphire", "Opal"];

function Gem_PickIndex()
{
    return choose(UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_5, UnknownEnum.Value_5, UnknownEnum.Value_5, UnknownEnum.Value_5, UnknownEnum.Value_5, UnknownEnum.Value_5, UnknownEnum.Value_6, UnknownEnum.Value_6, UnknownEnum.Value_6, UnknownEnum.Value_6, UnknownEnum.Value_6, UnknownEnum.Value_6, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_8, UnknownEnum.Value_8, UnknownEnum.Value_8, UnknownEnum.Value_8);
}

function InitGemPrizes()
{
    global.GemPrize[0][0] = 
    {
        Class: UnknownEnum.Value_35,
        Index: 0,
        Amount: 2
    };
    global.GemPrize[1][0] = 
    {
        Class: UnknownEnum.Value_13,
        Index: 2,
        Amount: 2
    };
    global.GemPrize[1][1] = 
    {
        Class: UnknownEnum.Value_33,
        Index: UnknownEnum.Value_2,
        Amount: 1
    };
    global.GemPrize[2][0] = 
    {
        Class: UnknownEnum.Value_35,
        Index: 0,
        Amount: 3
    };
    global.GemPrize[2][1] = 
    {
        Class: UnknownEnum.Value_1,
        Index: 0,
        Amount: 60
    };
    global.GemPrize[2][2] = 
    {
        Class: UnknownEnum.Value_33,
        Index: UnknownEnum.Value_0,
        Amount: 4
    };
    global.GemPrize[3][0] = 
    {
        Class: UnknownEnum.Value_13,
        Index: 4,
        Amount: 2
    };
    global.GemPrize[3][1] = 
    {
        Class: UnknownEnum.Value_5,
        Index: 0,
        Amount: 10
    };
    global.GemPrize[3][2] = 
    {
        Class: UnknownEnum.Value_27,
        Index: 0,
        Amount: 2
    };
    global.GemPrize[3][3] = 
    {
        Class: UnknownEnum.Value_33,
        Index: UnknownEnum.Value_1,
        Amount: 5
    };
    global.GemPrize[4][0] = 
    {
        Class: UnknownEnum.Value_36,
        Index: UnknownEnum.Value_1,
        Amount: 1
    };
    global.GemPrize[4][1] = 
    {
        Class: UnknownEnum.Value_36,
        Index: UnknownEnum.Value_3,
        Amount: 1
    };
    global.GemPrize[4][2] = 
    {
        Class: UnknownEnum.Value_39,
        Index: UnknownEnum.Value_0,
        Amount: 16
    };
    global.GemPrize[4][3] = 
    {
        Class: UnknownEnum.Value_39,
        Index: UnknownEnum.Value_3,
        Amount: 16
    };
    global.GemPrize[4][4] = 
    {
        Class: UnknownEnum.Value_39,
        Index: UnknownEnum.Value_5,
        Amount: 16
    };
    global.GemPrize[5][0] = 
    {
        Class: UnknownEnum.Value_36,
        Index: UnknownEnum.Value_4,
        Amount: 1
    };
    global.GemPrize[5][1] = 
    {
        Class: UnknownEnum.Value_38,
        Index: UnknownEnum.Value_0,
        Amount: 1
    };
    global.GemPrize[5][2] = 
    {
        Class: UnknownEnum.Value_38,
        Index: UnknownEnum.Value_3,
        Amount: 1
    };
    global.GemPrize[5][3] = 
    {
        Class: UnknownEnum.Value_38,
        Index: UnknownEnum.Value_2,
        Amount: 1
    };
    global.GemPrize[5][4] = 
    {
        Class: UnknownEnum.Value_38,
        Index: UnknownEnum.Value_1,
        Amount: 1
    };
    global.GemPrize[5][5] = 
    {
        Class: UnknownEnum.Value_7,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[6][0] = 
    {
        Class: UnknownEnum.Value_36,
        Index: UnknownEnum.Value_0,
        Amount: 1
    };
    global.GemPrize[6][1] = 
    {
        Class: UnknownEnum.Value_39,
        Index: UnknownEnum.Value_4,
        Amount: 16
    };
    global.GemPrize[6][2] = 
    {
        Class: UnknownEnum.Value_39,
        Index: UnknownEnum.Value_2,
        Amount: 16
    };
    global.GemPrize[6][3] = 
    {
        Class: UnknownEnum.Value_0,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[6][4] = 
    {
        Class: UnknownEnum.Value_15,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[6][5] = 
    {
        Class: UnknownEnum.Value_16,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[6][6] = 
    {
        Class: UnknownEnum.Value_18,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[7][0] = 
    {
        Class: UnknownEnum.Value_36,
        Index: UnknownEnum.Value_2,
        Amount: 1
    };
    global.GemPrize[7][1] = 
    {
        Class: UnknownEnum.Value_39,
        Index: UnknownEnum.Value_1,
        Amount: 16
    };
    global.GemPrize[7][2] = 
    {
        Class: UnknownEnum.Value_24,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[7][3] = 
    {
        Class: UnknownEnum.Value_4,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[7][4] = 
    {
        Class: UnknownEnum.Value_46,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[7][5] = 
    {
        Class: UnknownEnum.Value_41,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[7][6] = 
    {
        Class: UnknownEnum.Value_9,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[7][7] = 
    {
        Class: UnknownEnum.Value_2,
        Index: 0,
        Amount: 1
    };
    global.GemPrize[8][0] = 
    {
        Class: UnknownEnum.Value_34,
        Index: UnknownEnum.Value_1,
        Amount: 1
    };
    global.GemPrize[8][1] = 
    {
        Class: UnknownEnum.Value_34,
        Index: UnknownEnum.Value_4,
        Amount: 1
    };
    global.GemPrize[8][2] = 
    {
        Class: UnknownEnum.Value_34,
        Index: UnknownEnum.Value_6,
        Amount: 1
    };
    global.GemPrize[8][3] = 
    {
        Class: UnknownEnum.Value_34,
        Index: UnknownEnum.Value_2,
        Amount: 1
    };
    global.GemPrize[8][4] = 
    {
        Class: UnknownEnum.Value_34,
        Index: UnknownEnum.Value_7,
        Amount: 1
    };
    global.GemPrize[8][5] = 
    {
        Class: UnknownEnum.Value_34,
        Index: UnknownEnum.Value_3,
        Amount: 1
    };
    global.GemPrize[8][6] = 
    {
        Class: UnknownEnum.Value_34,
        Index: UnknownEnum.Value_0,
        Amount: 1
    };
    global.GemPrize[8][7] = 
    {
        Class: UnknownEnum.Value_34,
        Index: UnknownEnum.Value_5,
        Amount: 1
    };
    global.GemPrize[8][8] = 
    {
        Class: UnknownEnum.Value_44,
        Index: 0,
        Amount: 1
    };
}

function GemsInPond(arg0)
{
    var _GemCount = 0;
    
    for (var i = 0; i < 9; i++)
        _GemCount += arg0.GemCount[i];
    
    return _GemCount;
}

function GetGemCombo(arg0)
{
    var _GemCount = 0;
    GemCombo = array_create(2);
    
    for (var i = 0; i < 9; i++)
    {
        if (arg0.GemCount[i] > 0)
        {
            GemCombo[_GemCount++] = i;
            arg0.GemCount[i]--;
            
            if (arg0.GemCount[i] > 0)
                i--;
            
            if (_GemCount == 2)
            {
                if (GemCombo[1] > GemCombo[0])
                {
                    var _Combo0 = GemCombo[1];
                    GemCombo[1] = GemCombo[0];
                    GemCombo[0] = _Combo0;
                }
                
                return GemCombo;
            }
        }
    }
    
    return -1;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_18 = 18,
    Value_24 = 24,
    Value_27 = 27,
    Value_33 = 33,
    Value_34,
    Value_35,
    Value_36,
    Value_38 = 38,
    Value_39,
    Value_41 = 41,
    Value_44 = 44,
    Value_46 = 46
}
