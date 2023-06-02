/// @param array

function CbLayerArrayHide(_array)
{
    var _i = 0;
    repeat(array_length(_array))
    {
        layer_set_visible(_array[_i], false);
        ++_i;
    }
}