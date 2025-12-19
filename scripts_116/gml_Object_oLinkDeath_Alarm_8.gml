var _Explosion = instance_create_depth(oLink.x + 3, PendantAni_Y - 7, depth - 20, oPotExplosion);
_Explosion.PaletteIndex = 0;
audio_play_sound(Sound_PotShatter, 1, false);
PendantAni = false;
Inventory_DeleteItemIndex(UnknownEnum.Value_34, UnknownEnum.Value_3);
alarm[9] = 80;

enum UnknownEnum
{
    Value_3 = 3,
    Value_34 = 34
}
