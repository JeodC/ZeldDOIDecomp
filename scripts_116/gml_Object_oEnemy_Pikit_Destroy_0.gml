event_inherited();

with (TongueInst)
{
    if (ItemGrabbed && instance_exists(ItemInst))
    {
        other.SwallowedItem_Class = ItemInst.Class;
        other.SwallowedItem_Index = ItemInst.Index;
        other.SwallowedItem_Amount = ItemInst.Amount;
        instance_destroy(ItemInst);
    }
}
