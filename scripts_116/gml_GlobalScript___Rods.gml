global.RodNames = ["Stone", "Ice", "Fire", "Bombs", "Hearts", "Wealth"];
global.RodChargerSignText = "Place a rod into the slot to charge it from your magic meter.";

function Rod_Shoot()
{
    var _ItemIndex = global.Inventory[global.Inventory_SlotIndex_Equiped].ItemIndex;
    var _FloorLevelStr = GetFloorLevelString(FloorLevel);
    var _RodLayerName = (Facing == 1) ? "ObjsDoors_" : "ObjsHigher_";
    var _WeaponInst = instance_create_layer(x, y, _RodLayerName + _FloorLevelStr, oRod_Cane, 
    {
        Index: _ItemIndex,
        Facing: Facing,
        FloorLevel: FloorLevel
    });
    var _BeamInst;
    
    switch (_ItemIndex)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_2:
            _BeamInst = instance_create_layer(x, y, "ObjsHigher_" + _FloorLevelStr, oRodBeam, 
            {
                FloorLevel: FloorLevel
            });
            break;
        
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_5:
            _BeamInst = instance_create_layer(x, y, "ObjsHigher_" + _FloorLevelStr, oCaneBeam, 
            {
                FloorLevel: FloorLevel
            });
            break;
    }
    
    _BeamInst.Index = _ItemIndex;
    
    with (_BeamInst)
        Rod_SetLightIndex();
    
    switch (Facing)
    {
        case 3:
            _WeaponInst.x = x - 19;
            _WeaponInst.y = y - 24;
            break;
        
        case 4:
            _WeaponInst.x = x - 2;
            _WeaponInst.y = y - 24;
            break;
        
        case 1:
            _WeaponInst.x = x - 10;
            _WeaponInst.y = y - 28;
            break;
        
        case 2:
            _WeaponInst.x = x;
            _WeaponInst.y = y - 26;
            break;
    }
    
    with (_BeamInst)
    {
        Dir = oLink.Facing;
        
        switch (Dir)
        {
            case 3:
                x -= 16;
                ObjSetY(y_base - 5);
                vx = -Speed;
                break;
            
            case 4:
                x += 16;
                ObjSetY(y_base - 5);
                vx = Speed;
                break;
            
            case 1:
                x -= 6;
                ObjSetY(y_base - 24);
                vy = -Speed;
                layer = layer_get_id("ObjsFloor_" + _FloorLevelStr);
                alarm[11] = 3;
                break;
            
            case 2:
                x += 4;
                ObjSetY(y_base + 2);
                vy = Speed;
                break;
        }
    }
}

function Rod_SetLightIndex()
{
    switch (Index)
    {
        case UnknownEnum.Value_0:
            LightIndex = Lighting_CreateLight(global.CurrentRoomIndex, x, y, 0.55, [0.7, 0.7, 0.7]);
            break;
        
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_3:
            LightIndex = Lighting_CreateLight(global.CurrentRoomIndex, x, y, 0.55, [0.1, 0.3, 0.8]);
            break;
        
        case UnknownEnum.Value_2:
            LightIndex = Lighting_CreateLight(global.CurrentRoomIndex, x, y, 0.55, [0.8, 0.3, 0.1]);
            break;
        
        case UnknownEnum.Value_4:
            LightIndex = Lighting_CreateLight(global.CurrentRoomIndex, x, y, 0.55, [0.8, 0.1, 0.2]);
            break;
        
        case UnknownEnum.Value_5:
            LightIndex = Lighting_CreateLight(global.CurrentRoomIndex, x, y, 0.55, [0.1, 0.8, 0.3]);
            break;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5
}
