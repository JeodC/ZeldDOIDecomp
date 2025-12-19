Time_PauseStart();
TimePlayed = Time_Str(Time_PlayingTotal());
MenuText[UnknownEnum.Value_0] = ["Resume Game", "New Game", "Options", "Quit to Title", "Quit to Desktop"];
MenuText[UnknownEnum.Value_1] = ["Back", "SFX:", "Music:", "HUD:", "CRT Effect:", "Item Msgs:"];
MenuText[UnknownEnum.Value_2] = ["Cancel", "OK"];

for (var i = 0; i <= UnknownEnum.Value_2; i++)
    MenuItems[i] = array_length(MenuText[i]);

SelectorPos = 0;
Index = 0;
QuitTo = 0;
Quitting = false;
QuitDelay = 30;
depth = -1000;
Alpha = 0;
AlphaSpeed = 0.18;
Open = true;
Close = false;
FrameW = 128;
FrameH = 154;
FrameX = oCamera.X + ((oCamera.W - FrameW) / 2);
FrameY = oCamera.Y + ((oCamera.H - FrameH) / 2);
FrameCentre = FrameX + (FrameW / 2);
PlayTimeY = (FrameY + FrameH) - 25;
global.Paused = true;

if (audio_is_playing(oLink.LowHealthSound))
    audio_pause_sound(oLink.LowHealthSound);

audio_play_sound(Sound_Pickup, 1, false);
Music_Fade(0.25, 6);

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
