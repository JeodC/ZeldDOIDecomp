if (Setup)
{
    var _Dir = (W > 16) ? 1 : 2;
    
    switch (_Dir)
    {
        case 1:
            var _TileW = W / 8;
            x += (irandom(_TileW - 2) * 8);
            vx = Speed;
            break;
        
        case 2:
            var _TileH = H / 8;
            ObjSetY(y + (irandom(_TileH - 2) * 8));
            vy = Speed;
            break;
    }
    
    Setup = false;
}
