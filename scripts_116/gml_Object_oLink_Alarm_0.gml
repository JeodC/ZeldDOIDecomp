var _FromAnyStore = FromAnyStore(ItemHolding.From);
var _GetDialogue = Item_GetDialogueClass(ItemHolding.Class) && !FromAnyStore(ItemHolding.From);

if (_GetDialogue)
    Item_GetDialogue(ItemHolding.Class, ItemHolding.Index, ItemHolding.Amount);

var ItemGot = ItemHolding.Class == UnknownEnum.Value_45 || Item_Get(ItemHolding.Class, ItemHolding.Index, ItemHolding.Amount);

if (_FromAnyStore)
    Curse_CheckTask(UnknownEnum.Value_2);

if (ItemGot)
{
    Curse_GetItemUncurseMsg(ItemHolding.Class, ItemHolding.Index);
}
else if (ItemHolding.Class != UnknownEnum.Value_40)
{
    var _DropPos = Item_DropPos();
    var _DroppedItemInst = ItemDrop(_DropPos[0], _DropPos[1], ItemHolding.Class, ItemHolding.Index, ItemHolding.Amount, ItemHolding.From);
    _DroppedItemInst.Get_ShowDialogue = false;
    
    if (_FromAnyStore)
        _DroppedItemInst.ShopItem = false;
}

if (_FromAnyStore || ItemHolding.From == UnknownEnum.Value_12)
    TreasureLimiter_Update(ItemHolding.Class, false);

instance_destroy(ItemHolding);
ItemHolding = -4;

if (!instance_exists(oDialogueBox))
{
    UpdateState(UnknownEnum.Value_1);
    global.Paused = false;
}

UpdateSprites();

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_12 = 12,
    Value_40 = 40,
    Value_45 = 45
}
