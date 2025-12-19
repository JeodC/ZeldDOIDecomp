SpinCount--;

if (SpinCount <= 0)
{
    oLink.sprite_index = global.LinkSpr_Dead;
    oLink.image_index = 0;
    Falling = true;
}
else
{
    switch (SpinDir)
    {
        case 1:
            SpinDir = 4;
            oLink.sprite_index = global.LinkSpr_Stand_Right;
            break;
        
        case 2:
            SpinDir = 3;
            oLink.sprite_index = global.LinkSpr_Stand_Left;
            break;
        
        case 3:
            SpinDir = 1;
            oLink.sprite_index = global.LinkSpr_Stand_Up;
            break;
        
        case 4:
            SpinDir = 2;
            oLink.sprite_index = global.LinkSpr_Stand_Down;
            break;
    }
    
    alarm[1] = SpinDelay;
}
