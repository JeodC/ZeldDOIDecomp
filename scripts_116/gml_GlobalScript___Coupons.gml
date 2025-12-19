global.CouponModifier[UnknownEnum.Value_0] = 0.85;
global.CouponModifier[UnknownEnum.Value_1] = 0.7;
global.CouponModifier[UnknownEnum.Value_2] = 0.5;
global.CouponModifier[UnknownEnum.Value_3] = 0;
global.CouponModifier[UnknownEnum.Value_4] = 0;
global.CouponModifier[UnknownEnum.Value_5] = 0;

function Coupon_PickIndex(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_2:
            return choose(UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_2);
        
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_15:
        case UnknownEnum.Value_16:
        case UnknownEnum.Value_17:
            return choose(UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_5);
        
        case UnknownEnum.Value_18:
            return choose(UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_5);
    }
    
    return choose(UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_1);
}

function Coupon_NewPrice(arg0, arg1, arg2)
{
    if (global.Inventory_SlotIndex_Equiped == -1)
        return arg0;
    
    if (global.Inventory[global.Inventory_SlotIndex_Equiped].ItemClass != UnknownEnum.Value_48)
        return arg0;
    
    var _NewPrice = arg0;
    var _CouponIndex = global.Inventory[global.Inventory_SlotIndex_Equiped].ItemIndex;
    var _ApplyCoupon = false;
    
    switch (_CouponIndex)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_2:
            _ApplyCoupon = true;
            break;
        
        case UnknownEnum.Value_3:
            switch (arg1)
            {
                case UnknownEnum.Value_27:
                    _ApplyCoupon = true;
                    break;
                
                case UnknownEnum.Value_36:
                    switch (arg2)
                    {
                        case UnknownEnum.Value_1:
                        case UnknownEnum.Value_2:
                            _ApplyCoupon = true;
                            break;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (arg1)
            {
                case UnknownEnum.Value_13:
                case UnknownEnum.Value_35:
                case UnknownEnum.Value_18:
                    _ApplyCoupon = true;
                    break;
                
                case UnknownEnum.Value_36:
                    switch (arg2)
                    {
                        case UnknownEnum.Value_4:
                        case UnknownEnum.Value_0:
                        case UnknownEnum.Value_2:
                            _ApplyCoupon = true;
                            break;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_5:
            _ApplyCoupon = arg1 == UnknownEnum.Value_45;
            break;
    }
    
    if (_ApplyCoupon)
        _NewPrice = round(_NewPrice * global.CouponModifier[_CouponIndex]);
    
    return _NewPrice;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17,
    Value_18,
    Value_27 = 27,
    Value_35 = 35,
    Value_36,
    Value_45 = 45,
    Value_48 = 48
}
