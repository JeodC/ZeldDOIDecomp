LightFrame = (LightFrame + 6) % 360;
LightRadius = BaseLightRadius + (dsin(LightFrame) * 0.075);
Lighting_UpdateLight_Radius(RoomIndex, LightIndex, LightRadius);

if (global.Inventory_SlotIndex_Equiped == -1 || oLink.Facing != 2)
{
    RodInserted = false;
    exit;
}

if (global.Inventory[global.Inventory_SlotIndex_Equiped].ItemClass == UnknownEnum.Value_39)
{
    if (instance_place(x, y - 4, oLink) != -4)
    {
        if (!RodInserted || RodIndex != global.Inventory[global.Inventory_SlotIndex_Equiped].ItemIndex)
        {
            audio_play_sound(Sound_Arrow_Shoot, 1, false);
            audio_play_sound(Sound_CrystalHit, 1, false);
            RodIndex = global.Inventory[global.Inventory_SlotIndex_Equiped].ItemIndex;
            RodInserted = true;
        }
    }
    else
    {
        RodInserted = false;
    }
}
else
{
    RodInserted = false;
}

if (global.Paused || oLink.State == UnknownEnum.Value_3)
    exit;

if (RodInserted)
{
    if (input_check("action"))
    {
        if (CanAddShot)
        {
            if (global.Inventory[global.Inventory_SlotIndex_Equiped].Amount >= 16)
            {
                if (!FillError)
                {
                    MsgBox("Maximum charge reached!", undefined, Sound_Error);
                    FillError = true;
                }
            }
            else if (MagicUse(MagicCost) > 0)
            {
                global.Inventory[global.Inventory_SlotIndex_Equiped].Amount += 1;
                audio_play_sound(Sound_RodCharger, 1, false);
                CanAddShot = false;
                alarm[0] = ChargeDelay;
            }
            else if (!FillError)
            {
                MsgBox("Not enough magic to add a charge!", undefined, Sound_Error);
                FillError = true;
            }
        }
    }
    else
    {
        CanAddShot = true;
        FillError = false;
    }
}

ChargeColor = (ChargeColor + 1) % 3;

enum UnknownEnum
{
    Value_3 = 3,
    Value_39 = 39
}
