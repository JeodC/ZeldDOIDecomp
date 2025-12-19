event_inherited();
CamW = 200;
CamH = 150;
RoomW = CamW;
RoomH = CamH;
CamW_2 = CamW / 2;
CamH_2 = CamH / 2;
CamW_3 = CamW / 3;
CamH_3 = CamH / 3;
CamW_4 = CamW / 4;
CamH_4 = CamH / 4;
MiniScreen_Sprite = sArcade_Screen_Poker;
GameState = UnknownEnum.Value_0;
GameReady = true;
GameReadyDelay = 20;
Bet = 0;
HoldPos = 0;
HeldCards = array_create(5, false);
WinMul = [0, 1, 2, 3, 5, 8, 15, 30, 80, 500];
WinAmount = 0;
WinSound = -4;
Deck = ds_list_create();
Poker_InitDeck();

for (var i = 0; i < 5; i++)
    Poker_PickCard(i);

DealCardIndex = 0;
DealDelay = 10;
CurrentHand = UnknownEnum.Value_0;
CurrentHandStr = "";

enum UnknownEnum
{
    Value_0
}
