/// @param layer
/// @param xOffset
/// @param yOffset
/// @param zOffset

function CbSpriteLayerFloor(_layer, _xOffset, _yOffset, _zOffset)
{
    var _array = layer_get_all_elements(_layer);
    var _i = 0;
    repeat(array_length(_array))
    {
        var _asset = _array[_i];
        
        CbSpriteFloorExt(layer_sprite_get_sprite(_asset), layer_sprite_get_index(_asset),
                         layer_sprite_get_x(_asset) + _xOffset, layer_sprite_get_y(_asset) + _yOffset, _zOffset,
                         layer_sprite_get_xscale(_asset), layer_sprite_get_yscale(_asset), layer_sprite_get_angle(_asset),
                         layer_sprite_get_blend(_asset), layer_sprite_get_alpha(_asset));
        
        ++_i;
    }
}