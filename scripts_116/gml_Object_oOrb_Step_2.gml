switch (State)
{
    case UnknownEnum.Value_2:
        break;
    
    case UnknownEnum.Value_4:
        break;
    
    case UnknownEnum.Value_5:
        switch (Index)
        {
            case UnknownEnum.Value_0:
                instance_create_layer(x, y - 5, "ObjsHighest", oFireIceTower, 
                {
                    TowerObj: oFireTower
                });
                break;
            
            case UnknownEnum.Value_1:
                instance_create_layer(x, y - 5, "ObjsHighest", oFireIceTower, 
                {
                    TowerObj: oIceTower
                });
                break;
            
            case UnknownEnum.Value_2:
                instance_create_layer(x - 4, y - 5, layer, oItem_Fairy, 
                {
                    From: UnknownEnum.Value_0
                });
                instance_create_layer(x + 4, y - 5, layer, oItem_Fairy, 
                {
                    From: UnknownEnum.Value_0
                });
                break;
        }
        
        instance_create_layer(x, y - 8, "ObjsHighest", oPoof);
        instance_destroy(id);
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4,
    Value_5
}
