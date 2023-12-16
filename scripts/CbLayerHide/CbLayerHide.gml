/// Sets the visibility all specified layers to <false>
/// 
/// @param array

function CbLayerArrayHide(_array)
{
    if (!is_array(_array)) _array = [_array];
    
    var _i = 0;
    repeat(array_length(_array))
    {
        layer_set_visible(_array[_i], false);
        ++_i;
    }
}