function Bow_Set()
{
    BowSprite = sBow;
    BowArrow = UnknownEnum.Value_0;
    
    if (global.Inventory_SlotIndex_Equiped != -1)
    {
        switch (global.Inventory[global.Inventory_SlotIndex_Equiped].ItemIndex)
        {
            case UnknownEnum.Value_1:
                BowSprite = sBow_Spread;
                BowArrow = UnknownEnum.Value_1;
                break;
        }
    }
}

function Arrow_Create()
{
    switch (BowArrow)
    {
        default:
            instance_create_layer(x, y, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oArrow);
            break;
        
        case UnknownEnum.Value_1:
            var _A = instance_create_layer(x, y, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oArrow);
            _A.Index = 2;
            var _V = 1.25;
            _A = instance_create_layer(x, y, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oArrow);
            _A.Index = 2;
            
            switch (Facing)
            {
                case 1:
                case 2:
                    _A.vx -= _V;
                    break;
                
                case 3:
                case 4:
                    _A.vy -= _V;
                    break;
            }
            
            _A = instance_create_layer(x, y, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oArrow);
            _A.Index = 2;
            
            switch (Facing)
            {
                case 1:
                case 2:
                    _A.vx += _V;
                    break;
                
                case 3:
                case 4:
                    _A.vy += _V;
                    break;
            }
            
            break;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
