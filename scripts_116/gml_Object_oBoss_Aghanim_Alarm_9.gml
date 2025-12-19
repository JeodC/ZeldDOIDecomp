instance_create_layer(x + irandom_range(-8, 8), y + 4 + irandom_range(-8, 8), EffectLayer(1), oExplosion_Large, 
{
    FloorLevel: FloorLevel
});
TakeItems_Explosions--;

if (TakeItems_Explosions <= 0)
{
    image_index = 0;
    TakeItems_ShowShield = false;
    TakeItems_ShowBag = false;
    Lighting_UpdateLight_Visible(RoomIndex, LightIndex, false);
    Inventory_ClearAll();
    oHUD.ShowLamp = false;
    alarm[10] = 30;
}
else
{
    alarm[9] = TakeItems_ExplosionDelay;
}
