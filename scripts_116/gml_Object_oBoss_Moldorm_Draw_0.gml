if (!ShowHead)
    exit;

Moldorm_PixelRender();
draw_self();
var A1 = Dir + 20;
var A2 = Dir - 20;
var Eye1A, Eye2A;

if (State != UnknownEnum.Value_3)
{
    Eye1A = EyeA;
    Eye2A = EyeA;
}
else
{
    Eye1A = A1;
    Eye2A = A2;
}

draw_sprite_ext(sBoss_Moldorm_Eye, 0, x + lengthdir_x(16, A1), y + lengthdir_y(16, A1), 1, 1, Eye1A, c_white, 1);
draw_sprite_ext(sBoss_Moldorm_Eye, 0, x + lengthdir_x(16, A2), y + lengthdir_y(16, A2), 1, 1, Eye2A, c_white, 1);
shader_reset();

enum UnknownEnum
{
    Value_3 = 3
}
