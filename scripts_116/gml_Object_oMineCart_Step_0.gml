if (global.Paused)
{
    image_speed = 0;
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

if (DirSwitch)
{
    if (instance_exists(DirSwitchInst))
    {
        exit;
    }
    else
    {
        DirSwitch = false;
        DirSwitchInst = -4;
        Dir = DirSwitchNextDir;
    }
}

vx = 0;
vy = 0;

switch (Dir)
{
    case 3:
        vx = -Speed;
        break;
    
    case 4:
        vx = Speed;
        break;
    
    case 1:
        vy = -Speed;
        break;
    
    case 2:
        vy = Speed;
        break;
}

var _MineCartActionInst = instance_place(x + vx, y + vy, oMineCartAction);

if (_MineCartActionInst != -4)
{
    switch (_MineCartActionInst.Action)
    {
        case "Destroy":
            instance_destroy(id);
            exit;
            break;
        
        case "DirSwitch":
            switch (Dir)
            {
                case 3:
                    x = _MineCartActionInst.bbox_right;
                    DirSwitchInst = instance_create_layer(x, y, layer, oMineCartDirSwitch, 
                    {
                        sprite_index: (_MineCartActionInst.Value1 == 1) ? sMineCartDirSwitch_LeftToUp : sMineCartDirSwitch_LeftToDown
                    });
                    break;
                
                case 4:
                    x = _MineCartActionInst.bbox_left - sprite_width;
                    DirSwitchInst = instance_create_layer(x, y, layer, oMineCartDirSwitch, 
                    {
                        sprite_index: (_MineCartActionInst.Value1 == 1) ? sMineCartDirSwitch_RightToUp : sMineCartDirSwitch_RightToDown
                    });
                    break;
                
                case 1:
                    y = _MineCartActionInst.bbox_bottom;
                    DirSwitchInst = instance_create_layer(x, y, layer, oMineCartDirSwitch, 
                    {
                        sprite_index: (_MineCartActionInst.Value1 == 3) ? sMineCartDirSwitch_UpToLeft : sMineCartDirSwitch_UpToRight
                    });
                    break;
                
                case 2:
                    y = _MineCartActionInst.bbox_top - sprite_height;
                    DirSwitchInst = instance_create_layer(x, y, layer, oMineCartDirSwitch, 
                    {
                        sprite_index: (_MineCartActionInst.Value1 == 3) ? sMineCartDirSwitch_DownToLeft : sMineCartDirSwitch_DownToRight
                    });
                    break;
            }
            
            DirSwitch = true;
            DirSwitchNextDir = _MineCartActionInst.Value1;
            exit;
            break;
    }
}
else
{
    x += vx;
    y += vy;
}

switch (Dir)
{
    case 3:
        sprite_index = sMineCart_Left;
        DwarfSprite = sMineCart_Dwarf_Left;
        RockSprite = sMineRocks_H;
        RockDirX = -1;
        break;
    
    case 4:
        sprite_index = sMineCart_Right;
        DwarfSprite = sMineCart_Dwarf_Right;
        RockSprite = sMineRocks_H;
        RockDir = 1;
        break;
    
    case 1:
        sprite_index = sMineCart_Up;
        DwarfSprite = sMineCart_Dwarf_Up;
        RockSprite = sMineRocks_V;
        RockDirX = 1;
        break;
    
    case 2:
        sprite_index = sMineCart_Down;
        DwarfSprite = sMineCart_Dwarf_Down;
        RockSprite = sMineRocks_V;
        RockDirX = 1;
        break;
}
