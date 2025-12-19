global.SwordName = ["Basic", "Steel", "Long", "Dragon", "Blood", "Master"];
global.SwordCollisionList = ds_list_create();

function SwordLevel(arg0)
{
    return global.Inventory_ItemData[UnknownEnum.Value_44].Index >= arg0;
}

function SwordCollision(arg0, arg1 = -4)
{
    switch (oLink.State)
    {
        case UnknownEnum.Value_12:
            if (arg1 == -4)
                return ObjCollision(x, y, arg0, FloorLevel);
            else
                ObjCollision_List(arg1, x, y, arg0, FloorLevel);
            
            break;
        
        case UnknownEnum.Value_19:
            if (arg1 == -4)
                return ObjCollision_Circle(StarCollisionX, StarCollisionY, StarCollisionRadius, arg0, FloorLevel);
            else
                ObjCollision_Circle_List(arg1, StarCollisionX, StarCollisionY, StarCollisionRadius, arg0, FloorLevel);
            
            break;
    }
    
    return -4;
}

enum UnknownEnum
{
    Value_12 = 12,
    Value_19 = 19,
    Value_44 = 44
}
