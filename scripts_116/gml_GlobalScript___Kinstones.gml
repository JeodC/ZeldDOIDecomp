global.KinstoneColorNames[UnknownEnum.Value_0] = "Green";
global.KinstoneColorNames[UnknownEnum.Value_1] = "Blue";
global.KinstoneColorNames[UnknownEnum.Value_2] = "Red";
global.KinstoneColorNames[UnknownEnum.Value_3] = "Gold";
global.KinstoneSignText = "Bring me the other half of this kinstone piece and I shall grant you a reward.";

function KinstoneMain_SetIndex(arg0)
{
    Item_SetIndex(arg0);
    var r = 0;
    var g = 0;
    var b = 0;
    
    switch (image_index)
    {
        case UnknownEnum.Value_0:
            g = 0.5;
            r = 0.15;
            b = 0.15;
            break;
        
        case UnknownEnum.Value_1:
            b = 0.6;
            r = 0.2;
            g = 0.2;
            break;
        
        case UnknownEnum.Value_2:
            r = 0.65;
            g = 0.25;
            b = 0.25;
            break;
        
        case UnknownEnum.Value_3:
            r = 0.6;
            g = 0.5;
            b = 0.1;
            break;
    }
    
    Lighting_UpdateLight_RGB(RoomIndex, LightIndex, [r, g, b]);
}

function Kinstone_PickIndex()
{
    return choose(0, 0, 0, 0, 1, 1, 1, 2, 2, 3);
}

function Kinstone_Update()
{
    SpriteY = BaseY - (4 * dsin(t)) - 4;
    t = (t + 5) % 360;
    Lighting_UpdateLight_Radius(RoomIndex, LightIndex, 1 + ((BaseY - SpriteY) / 30));
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
