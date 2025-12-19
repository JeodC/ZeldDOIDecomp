function WallObj_Create(arg0, arg1, arg2, arg3, arg4, arg5 = 0, arg6 = 0, arg7 = oWall)
{
    WallInst = instance_create_layer(arg1, arg2, arg0, arg7);
    WallInst.image_xscale = arg3;
    WallInst.image_yscale = arg4;
    WallInst.Position = arg5;
    WallInst.GID = arg6;
    
    if (string_pos("Lower", arg0) != 0)
        WallInst.FloorLevel = 0;
    
    return WallInst;
}

function WallObj_Cutout_H(arg0, arg1, arg2)
{
    var LeftWallX1 = arg0.x;
    var LeftWallX2 = arg1 - 1;
    var RightWallX1 = arg2 + 1;
    var RightWallX2 = (arg0.x + arg0.sprite_width) - 1;
    arg0.image_xscale = ((LeftWallX2 - LeftWallX1) + 1) / 8;
    var RightWallInst = WallObj_Create(arg0.layer, RightWallX1, arg0.y, ((RightWallX2 - RightWallX1) + 1) / 8, arg0.sprite_height / 8, arg0.Position, arg0.GID);
    RightWallInst.FloorLevel = arg0.FloorLevel;
    RightWallInst.BlockLink = arg0.BlockLink;
    RightWallInst.BlockLinkCarry = arg0.BlockLinkCarry;
    RightWallInst.BlockEnemies = arg0.BlockEnemies;
    RightWallInst.BlockProjectiles = arg0.BlockProjectiles;
    RightWallInst.BlockItems = arg0.BlockItems;
}

function WallObj_Cutout_V(arg0, arg1, arg2)
{
    var TopWallY1 = arg0.y;
    var TopWallY2 = arg1 - 1;
    var BottomWallY1 = arg2 + 1;
    var BottomWallY2 = (arg0.y + arg0.sprite_height) - 1;
    arg0.image_yscale = ((TopWallY2 - TopWallY1) + 1) / 8;
    var BottomWallInst = WallObj_Create(arg0.layer, arg0.x, BottomWallY1, arg0.sprite_width / 8, ((BottomWallY2 - BottomWallY1) + 1) / 8, arg0.Position, arg0.GID);
    BottomWallInst.FloorLevel = arg0.FloorLevel;
    BottomWallInst.BlockLink = arg0.BlockLink;
    BottomWallInst.BlockLinkCarry = arg0.BlockLinkCarry;
    BottomWallInst.BlockEnemies = arg0.BlockEnemies;
    BottomWallInst.BlockProjectiles = arg0.BlockProjectiles;
    BottomWallInst.BlockItems = arg0.BlockItems;
}
