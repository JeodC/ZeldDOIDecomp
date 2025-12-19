switch (Dir)
{
    case 1:
    case 2:
        if (HeadDir == Dir)
        {
            if (StandingTurnHeadDir == 1)
                Soldier_UpdateHead(4);
            else
                Soldier_UpdateHead(3);
            
            StandingTurnHeadDir *= -1;
        }
        else
        {
            Soldier_UpdateHead(Dir);
        }
        
        break;
    
    case 3:
    case 4:
        if (HeadDir == Dir)
        {
            if (StandingTurnHeadDir == 1)
                Soldier_UpdateHead(2);
            else
                Soldier_UpdateHead(1);
            
            StandingTurnHeadDir *= -1;
        }
        else
        {
            Soldier_UpdateHead(Dir);
        }
        
        break;
}

StandingHeadChecks--;

if (StandingHeadChecks <= 0)
    Enemy_UpdateState(UnknownEnum.Value_3);
else
    alarm[3] = StandinHeadTurnDelay;

enum UnknownEnum
{
    Value_3 = 3
}
