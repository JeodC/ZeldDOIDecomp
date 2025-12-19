global.SoldierWeaponStr[UnknownEnum.Value_0] = "Sword";
global.SoldierWeaponStr[UnknownEnum.Value_1] = "Spear";
global.SoldierWeaponStr[UnknownEnum.Value_2] = "Fork";
global.SoldierWeaponStr[UnknownEnum.Value_3] = "Stick";

function Soldier_UpdateHead(arg0)
{
    HeadDir = arg0;
    
    switch (arg0)
    {
        case 3:
            HeadSpr = sEnemy_Soldier_Head_Left;
            break;
        
        case 4:
            HeadSpr = sEnemy_Soldier_Head_Right;
            break;
        
        case 1:
            HeadSpr = sEnemy_Soldier_Head_Up;
            break;
        
        case 2:
            HeadSpr = sEnemy_Soldier_Head_Down;
            break;
    }
}

function Soldier_Advanced_UpdateRunningDir(arg0 = true)
{
    Soldier_UpdateDir(DirFaceLink());
    var DirToLink = point_direction(x, y, oLink.x, oLink.y);
    vx = lengthdir_x(Speed, DirToLink);
    vy = lengthdir_y(Speed, DirToLink);
    
    if (arg0)
        Soldier_UpdateWeaponSprite();
    
    Strafe = false;
    alarm[1] = 20;
}

function Soldier_UpdateDir(arg0)
{
    Dir = arg0;
    Soldier_UpdateHead(Dir);
    Enemy_UpdateSprite(State);
    Enemy_UpdateV(Speed);
}

function Soldier_UpdateWeaponSprite()
{
    switch (Dir)
    {
        case 1:
            WeaponInst.sprite_index = asset_get_index("sSoldierWeapon_" + global.SoldierWeaponStr[Weapon] + "_Up");
            break;
        
        case 2:
            WeaponInst.sprite_index = asset_get_index("sSoldierWeapon_" + global.SoldierWeaponStr[Weapon] + "_Down");
            break;
        
        case 3:
            WeaponInst.sprite_index = asset_get_index("sSoldierWeapon_" + global.SoldierWeaponStr[Weapon] + "_Left");
            break;
        
        case 4:
            WeaponInst.sprite_index = asset_get_index("sSoldierWeapon_" + global.SoldierWeaponStr[Weapon] + "_Right");
            break;
    }
}

function Soldier_Simple_LookSideDir(arg0)
{
    switch (arg0)
    {
        case 3:
        case 4:
            return choose(1, 2);
        
        case 1:
        case 2:
            return choose(3, 4);
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
