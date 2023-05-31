function CbSystemPrepareLighting()
{
    __CB_GLOBAL
    
    if (CbSystemLightModeGet() != CB_LIGHT_MODE.NONE)
    {
        with(_global.__lighting)
        {
            __posRadArray = array_create(4*__CB_LIGHT_COUNT, 0);
            __colorArray  = array_create(3*__CB_LIGHT_COUNT, 0);
            
            var _posRadIndex = 0;
            var _colorIndex  = 0;
            
            var _i = 0;
            repeat(array_length(__array))
            {
                var _light = __array[_i];
                if (!weak_ref_alive(_light) || _light.ref.__destroyed)
                {
                    array_delete(__array, _i, 1);
                }
                else
                {
                    if (_light.ref.visible && !_light.ref.__hasShadows)
                    {
                        _light.ref.__AddToGlobalArrays(__posRadArray, _posRadIndex, __colorArray, _colorIndex);
                        _posRadIndex += 4;
                        _colorIndex  += 3;
                    }
                    
                    ++_i;
                }
            }
        }
        
        if (CbSystemLightModeGet() == CB_LIGHT_MODE.DEFERRED)
        {
            surface_set_target(__CbDeferredSurfaceDepthEnsure(surface_get_target()));
        	draw_clear(c_white);
            surface_reset_target();
            
            surface_set_target(__CbDeferredSurfaceNormalEnsure(surface_get_target()));
        	draw_clear(c_gray);
            surface_reset_target();
            
            surface_set_target(__CbDeferredSurfaceLightEnsure(surface_get_target()));
        	draw_clear(c_black);
            surface_reset_target();
        }
    }
}