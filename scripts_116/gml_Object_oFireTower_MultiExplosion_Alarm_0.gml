instance_create_layer(CenterX + lengthdir_x(Radius, Angle), CenterY + lengthdir_y(Radius, Angle), "ObjsHighest", oFireTower);
Angle += (28.43 * Dir);

if (Angle >= 360)
    Angle -= 360;

if (Angle < 0)
    Angle += 360;

Radius += 3;
Explosions--;

if (Explosions == 0)
    instance_destroy(id);
else
    alarm[0] = 6;
