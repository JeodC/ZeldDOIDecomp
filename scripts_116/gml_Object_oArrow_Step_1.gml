if (Setup)
{
    switch (oLink.Facing)
    {
        case 3:
            x -= 4;
            ObjSetY(y_base - 6);
            vx = -Speed;
            image_angle = 90;
            break;
        
        case 4:
            x += 6;
            ObjSetY(y_base - 6);
            vx = Speed;
            image_angle = -90;
            break;
        
        case 1:
            ObjSetY(y_base - 14);
            vy = -Speed;
            image_angle = 0;
            layer = layer_get_id("ObjsFloor_" + FloorLevelStr);
            alarm[11] = 3;
            break;
        
        case 2:
            vy = Speed;
            image_angle = 180;
            break;
    }
    
    Setup = false;
}
