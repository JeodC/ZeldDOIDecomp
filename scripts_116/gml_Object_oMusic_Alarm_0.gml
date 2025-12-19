Music_Stop();

if (SongPlaying_Asset == -4)
    exit;

SongPlaying_Inst = audio_play_sound(SongPlaying_Asset, 1, SongIndexAssets.Intro == -4);
_Music_SetGain(1);
State = UnknownEnum.Value_1;

enum UnknownEnum
{
    Value_1 = 1
}
