/// @param index
/// @param x
/// @param y

function CbDeferredLightDrawDebug(_index, _x, _y)
{
    __CB_GLOBAL
    
    if (_index > __CB_SHADOW_COUNT)
    {
        __CbError("Cannot draw shadow mapping for light ", _index, " (shadow mapping can only be applied to light 0 and light 1)");
    }
    
    with(_global.__lightingShadowArray[_index])
    {
        if (not __state) return;
        
        __Tick();
        
        draw_surface(__surface, _x, _y);
    }
}