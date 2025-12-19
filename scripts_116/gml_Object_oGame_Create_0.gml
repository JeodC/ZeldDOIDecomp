global.Paused = false;
global.MenuInst = -4;
global.LinkDead = false;
global.FinalBoss = false;
global.GameBeaten = false;
global.Swordless = false;
global.ShopkeeperJustin = false;
User_UpdateMusicSFX();
Time_PlayingStart();
Time_PauseStart();

if (global.Continue)
{
    global.SaveLevel = true;
    User_LoadGame();
    Dungeon_InitSaveLevel(global.ContinueLevel);
    oRender.FadeIn();
}
else
{
    Dungeon_InitLevel(UnknownEnum.Value_0);
}

User_DelSaveData();
Time_PauseEnd();

enum UnknownEnum
{
    Value_0
}
