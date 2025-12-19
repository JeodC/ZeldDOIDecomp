if (Revealed && !RevealedDone)
{
    if (DoorInst != -4)
    {
        sprite_index = asset_get_index("sCurtain_" + Location + "_Open_Secret");
        DoorInst.Status = UnknownEnum.Value_0;
        DoorInst.UpdateStatus = true;
    }
    else
    {
        sprite_index = asset_get_index("sCurtain_" + Location + "_Open");
    }
    
    RevealedDone = true;
}

enum UnknownEnum
{
    Value_0
}
