function CbLightRenderAllDepthMaps(_function)
{
    var _array = CbLightArrayGet();
    var _i = 0;
    repeat(array_length(_array))
    {
        var _weakRef = _array[_i];
        if (weak_ref_alive(_weakRef) && !_weakRef.ref.__destroyed)
        {
            _weakRef.ref.__RenderDepth(_function);
            ++_i;
        }
        else
        {
            array_delete(_array, _i, 1);
        }
    }
}