var _PosX = x;
var _PosY = y;

switch (SpawnDir)
{
    case 1:
        _PosY -= 20;
        break;
    
    case 2:
        _PosY += 20;
        break;
    
    case 3:
        _PosX -= 20;
        break;
    
    case 4:
        _PosX += 20;
        break;
}

instance_create_layer(_PosX, _PosY, "Objs_" + FloorLevelStr, oMineCart, 
{
    Dir: SpawnDir
});
alarm[0] = SpawnDelay;
