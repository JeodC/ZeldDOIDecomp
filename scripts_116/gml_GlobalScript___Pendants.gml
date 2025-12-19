global.PendantNames = ["Health", "Magic", "Protection", "Revival", "Direction", "Secrets", "Immunity", "Wealth"];

function Pendant_Check(arg0)
{
    if (Curse_Check(UnknownEnum.Value_8))
        return false;
    
    return global.Inventory_ItemData[UnknownEnum.Value_34].Owns[arg0];
}

enum UnknownEnum
{
    Value_8 = 8,
    Value_34 = 34
}
