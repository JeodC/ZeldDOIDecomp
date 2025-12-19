Talking = true;
var _Gem1 = GemCombo[0];
var _Gem2 = GemCombo[1];
GemPrize = global.GemPrize[_Gem1][_Gem2];
var _Rupees = false;

switch (global.ItemData[GemPrize.Class].Type)
{
    case UnknownEnum.Value_1:
    case UnknownEnum.Value_4:
        if (global.Inventory_ItemData[GemPrize.Class].Owns[GemPrize.Index])
            _Rupees = true;
        
        break;
    
    case UnknownEnum.Value_2:
        if (global.Inventory_ItemData[GemPrize.Class].Index >= global.Inventory_ItemData[GemPrize.Class].Index_Max)
            _Rupees = true;
        
        break;
}

switch (GemPrize.Class)
{
    case UnknownEnum.Value_18:
        if (global.Inventory_ItemData[UnknownEnum.Value_18].Amount >= (global.Challenges[UnknownEnum.Value_0] ? 5 : 16))
            _Rupees = true;
        
        break;
    
    case UnknownEnum.Value_24:
        if (global.Challenges[UnknownEnum.Value_4])
            _Rupees = true;
        
        break;
    
    case UnknownEnum.Value_34:
        if (global.Challenges[UnknownEnum.Value_3] && GemPrize.Index == UnknownEnum.Value_4)
            _Rupees = true;
        
        break;
    
    case UnknownEnum.Value_2:
        if (global.Challenges[UnknownEnum.Value_1])
            _Rupees = true;
        
        break;
    
    case UnknownEnum.Value_44:
        if (global.Swordless)
            _Rupees = true;
        
        break;
    
    case UnknownEnum.Value_7:
        if (global.Inventory_ItemData[UnknownEnum.Value_7].Index >= 0)
            _Rupees = true;
        
        break;
}

if (_Rupees)
{
    var _MinAmount = max((_Gem1 + 1) * (_Gem2 + 1), 25);
    var _MaxAmount = _MinAmount * 3;
    var _Amount = irandom_range(_MinAmount, _MaxAmount);
    var _RupeeAmount = round(_Amount / 5) * 5;
    GemPrize = 
    {
        Class: UnknownEnum.Value_40,
        Index: 0,
        Amount: _RupeeAmount
    };
}

PrizeClass = GemPrize.Class;
PrizeIndex = GemPrize.Index;

switch (PrizeClass)
{
    case UnknownEnum.Value_13:
        PrizeIndex = Food_PickItem(PrizeIndex);
        break;
    
    case UnknownEnum.Value_35:
        PrizeIndex = irandom(global.PopFlavors - 1);
        break;
}

MsgBox("Thank you for the gems.\\Here's an item.");

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_7 = 7,
    Value_13 = 13,
    Value_18 = 18,
    Value_24 = 24,
    Value_34 = 34,
    Value_35,
    Value_40 = 40,
    Value_44 = 44
}
