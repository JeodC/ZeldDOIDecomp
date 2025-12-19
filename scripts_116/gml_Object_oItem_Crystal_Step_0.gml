event_inherited();
Lighting_UpdateLight_Pos(RoomIndex, LightIndex, x, y - 4);
T = (T + 6) % 360;
R = r_base + (dsin(T) * 0.1);
G = g_base + (dsin(T) * 0.1);
B = b_base + (dsin(T) * 0.3);
Lighting_UpdateLight_RGB(RoomIndex, LightIndex, [R, G, B]);
