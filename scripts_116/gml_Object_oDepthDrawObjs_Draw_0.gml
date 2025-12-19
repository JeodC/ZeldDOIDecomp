if (!Draw)
    exit;

for (var ObjIndex = 0; ObjIndex < ObjectCount; ObjIndex++)
{
    with (ds_grid_get(ObjGrid, 0, ObjIndex))
        event_perform(ev_draw, ev_draw_normal);
}
