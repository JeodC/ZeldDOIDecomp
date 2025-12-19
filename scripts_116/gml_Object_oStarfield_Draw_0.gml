for (var LayerIndex = 0; LayerIndex < 3; LayerIndex++)
{
    for (var i = 0; i < ds_grid_height(Stars[LayerIndex]); i++)
        draw_sprite(sStarfieldStar, LayerIndex, ds_grid_get(array_get(Stars, LayerIndex), 0, i), ds_grid_get(array_get(Stars, LayerIndex), 1, i));
}
