function Moldorm_CheckLinkHit()
{
    if (oBoss_Moldorm.State == UnknownEnum.Value_19)
        exit;
    
    var _LinkInst = instance_place(x, y, oLink);
    
    if (_LinkInst != -4)
    {
        with (oLink)
            LinkHit(point_direction(other.x, other.y, x, y), 2, 12, 2.75);
    }
}

function Moldorm_PixelRender()
{
    if (oBoss_Moldorm.State == UnknownEnum.Value_12 || oBoss_Moldorm.State == UnknownEnum.Value_19)
        PixelRender_Dim(true, true, false, -4, 0, true, global.KnockBackColors[oBoss_Moldorm.KnockBackColorFrame]);
    else if (oBoss_Moldorm.Energy <= oBoss_Moldorm.LowEnergy)
        PixelRender_Dim(true, true, false, -4, 0, true, [1, 0, 0]);
    else
        PixelRender_Dim(true, true, false, -4, 0, false, 0);
}

enum UnknownEnum
{
    Value_12 = 12,
    Value_19 = 19
}
