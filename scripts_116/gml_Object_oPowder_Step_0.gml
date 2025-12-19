if (Transformed)
    exit;

var inst = instance_place(x, y, oVillager_Treeman);

if (inst != -4)
{
    if (!global.Paused && !inst.Transform && !inst.Transformed)
        inst.TransformInit = true;
    
    Transformed = true;
    exit;
}

if (image_index >= 6)
{
    inst = instance_place(x, y, oEnemy);
    
    if (inst != -4)
    {
        with (inst)
        {
            if (Enemy_IsBoss(object_index))
                exit;
            
            if (Enemy_LinkWeaponHit(UnknownEnum.Value_10, 0, inst, x, y, 0))
            {
                instance_create_layer(ObjCenterX(), ObjCenterY(), "ObjsHigher_" + GetFloorLevelString(FloorLevel), oPoof);
                instance_destroy(id);
                var _layer = "Objs_" + GetFloorLevelString(FloorLevel);
                
                switch (object_index)
                {
                    case oEnemy_Bubble:
                        instance_create_layer(x, y_base, _layer, oItem_Fairy, 
                        {
                            From: UnknownEnum.Value_0
                        });
                        break;
                    
                    case oEnemy_Rat:
                        ItemExplosion(x, y_base, FloorLevel, UnknownEnum.Value_14, undefined, 1, undefined, ItemHolding);
                        break;
                    
                    default:
                        var _FloorLevel = GetFloorLevelID(x, y_base - 4);
                        var RatInst = instance_create_layer(x, y_base - 4, _layer, oEnemy_Rat, 
                        {
                            FloorLevel: _FloorLevel,
                            ItemHolding: ItemHolding,
                            SectionID: SectionID,
                            RoomIndex: RoomIndex
                        });
                        
                        with (RatInst)
                            Enemy_UpdateState(UnknownEnum.Value_2);
                        
                        break;
                }
            }
        }
        
        Transformed = true;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_10 = 10,
    Value_14 = 14
}
