function SwitchBlock_SetWalls(arg0)
{
    if (arg0.Segment_L_Wall != -4)
    {
        arg0.Segment_L_Wall.BlockLink = arg0.Raised;
        arg0.Segment_L_Wall.BlockLinkCarry = arg0.Raised;
        arg0.Segment_L_Wall.BlockEnemies = arg0.Raised;
    }
    
    if (arg0.Segment_R_Wall != -4)
    {
        arg0.Segment_R_Wall.BlockLink = arg0.Raised;
        arg0.Segment_R_Wall.BlockLinkCarry = arg0.Raised;
        arg0.Segment_R_Wall.BlockEnemies = arg0.Raised;
    }
    
    if (arg0.Segment_T_Wall != -4)
    {
        arg0.Segment_T_Wall.BlockLink = arg0.Raised;
        arg0.Segment_T_Wall.BlockLinkCarry = arg0.Raised;
        arg0.Segment_T_Wall.BlockEnemies = arg0.Raised;
    }
    
    if (arg0.Segment_B_Wall != -4)
    {
        arg0.Segment_B_Wall.BlockLink = arg0.Raised;
        arg0.Segment_B_Wall.BlockLinkCarry = arg0.Raised;
        arg0.Segment_B_Wall.BlockEnemies = arg0.Raised;
    }
}
