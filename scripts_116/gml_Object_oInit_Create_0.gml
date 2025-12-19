global.HUDFont = font_add_sprite(sHUD_Font, 32, true, 0);
global.HUDFont2 = font_add_sprite_ext(sHUD_Font2, " .!?':-<>()_0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 1);
global.FontNumbers = font_add_sprite_ext(sHUD_Numbers, "0123456789", false, 0);
LinkSprites_Load();
ini_open("options.ini");
Borderless = ini_read_real("Screen", "Borderless", false);
global.MusicVol = ini_read_real("Audio", "MusicVol", 0.7);
global.SFXVol = ini_read_real("Audio", "SFXVol", 1);
global.Gamepad_AnalogueThreshold = ini_read_real("Controls", "AnalogueThreshold", 0.4);
global.Gore = (ini_read_real("Preferences", "Gore", 1) == 1) ? true : false;
global.GlobalLighting = (ini_read_real("Preferences", "Lighting", 1) == 1) ? true : false;
global.AltTabPause = (ini_read_real("Preferences", "AltTabPause", 1) == 1) ? true : false;
global.SaveVersionCheck = (ini_read_real("Preferences", "SaveVersionCheck", 1) == 1) ? true : false;
global.StairPause = (ini_read_real("Preferences", "StairPause", 1) == 1) ? true : false;
ini_close();
Draw = false;
Init = false;

if (Borderless)
{
    window_set_fullscreen(false);
    alarm[0] = 10;
}
else
{
    Draw = true;
    alarm[2] = 3;
}

audio_group_load(Music_Boss_Final_Intro);
audio_group_load(Music_Boss_Final_Hallway);
