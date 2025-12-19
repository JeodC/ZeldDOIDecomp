global.ArcadeFont = font_add_sprite_ext(sVideoGame_Font, " !'#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijklmnopqrstuvwxyz{|}", false, 0);
global.ArcadeFont2 = font_add_sprite_ext(sVideoGame_Font2, " !'#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijklmnopqrstuvwxyz{|}", false, 0);
global.ArcadeVP_Sizes = array_create(4);
global.ArcadeVP_Surface = 0;
global.ArcadeVP_Show = false;
global.ArcadeCam_W = 200;
global.ArcadeCam_H = 150;
global.ArcadeVP_RenderX = 0;
global.ArcadeVP_RenderY = 0;
global.ArcadeVP_RenderW = 0;
global.ArcadeVP_RenderH = 0;
global.Arcade_ActiveInst = -4;
global.Arcade_UsedPlayers = ds_list_create();

function Arcade_SetCam(arg0 = global.ArcadeCam_W, arg1 = global.ArcadeCam_H)
{
    global.ArcadeCam_W = arg0;
    global.ArcadeCam_H = arg1;
    Arcade_SetVP(arg0, arg1);
}

function Arcade_SetVP(arg0 = global.ArcadeCam_W, arg1 = global.ArcadeCam_H)
{
    global.ArcadeVP_Sizes[0] = global.ArcadeCam_W;
    global.ArcadeVP_Sizes[1] = global.ArcadeCam_H;
    global.ArcadeVP_Sizes[2] = global.ArcadeCam_W * 2;
    global.ArcadeVP_Sizes[3] = global.ArcadeCam_H * 2;
    
    if (surface_exists(global.ArcadeVP_Surface))
        surface_free(global.ArcadeVP_Surface);
    
    global.ArcadeVP_Surface = surface_create(global.ArcadeCam_W, global.ArcadeCam_H);
    Surface_Clear(global.ArcadeVP_Surface);
    global.ArcadeVP_RenderW = global.ArcadeCam_W * 4;
    global.ArcadeVP_RenderH = global.ArcadeCam_H * 4;
    global.ArcadeVP_RenderX = (view_get_wport(0) - global.ArcadeVP_RenderW) / 2;
    global.ArcadeVP_RenderY = (view_get_hport(0) - global.ArcadeVP_RenderH) / 2;
}

function Arcade_Hiscore_Load(arg0)
{
    var Highscores = Arcade_Hiscores_Load();
    
    if (Highscores == -1)
        return -1;
    
    return Highscores[arg0];
}

function Arcade_Hiscores_Load()
{
    var Buffer = xzip_read("Users", "AHS");
    
    if (Buffer == -1)
        return -1;
    
    var JSONStr = buffer_read(Buffer, buffer_string);
    buffer_delete(Buffer);
    return json_parse(JSONStr);
}

function Arcade_Hiscore_Check(arg0)
{
    if (Score > Hiscore)
    {
        Hiscore = Score;
        var Highscores = Arcade_Hiscores_Load();
        
        if (Highscores == -1)
            return false;
        
        Highscores[arg0] = Hiscore;
        var _Buffer = EncodeDataToBuffer(Highscores);
        xzip_write("Users", _Buffer, "AHS");
        buffer_delete(_Buffer);
        return true;
    }
    
    return false;
}
