/// Prepares lighting for use. This function should be called once per frame before rendering
/// either the CB_PASS.LIT_OPAQUE or CB_PASS.LIT_ALPHA_BLEND passes.

function CbRenderPrepareLighting()
{
    __CB_GLOBAL_RENDER
    
    if (CbLightModeGet() != CB_LIGHT_MODE.DISABLE_LIGHTING)
    {
        with(_global.__lighting)
        {
            __posRadArray = array_create(4*__CB_LIGHT_COUNT, 0);
            __colorArray  = array_create(3*__CB_LIGHT_COUNT, 0);
            
            var _posRadIndex = 0;
            var _colorIndex  = 0;
            
            var _i = 0;
            repeat(array_length(__lightStructArray))
            {
                var _light = __lightStructArray[_i];
                if (!weak_ref_alive(_light) || _light.ref.__destroyed)
                {
                    array_delete(__lightStructArray, _i, 1);
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
            
            if ((__lightMode == CB_LIGHT_MODE.ONE_SHADOWED_LIGHT) || (__lightMode == CB_LIGHT_MODE.DEFERRED))
            {
                CbRenderStateDepthOnly();
                
                var _i = 0;
                repeat(array_length(__lightStructArray))
                {
                    var _weakRef = __lightStructArray[_i];
                    if (weak_ref_alive(_weakRef) && !_weakRef.ref.__destroyed)
                    {
                        _weakRef.ref.__RenderDepth();
                        ++_i;
                    }
                    else
                    {
                        array_delete(__lightStructArray, _i, 1);
                    }
                }
                
                CbRenderStateReset();
            }
            
            if (__lightMode == CB_LIGHT_MODE.DEFERRED)
            {
                surface_set_target(__CbDeferredSurfaceNormalEnsure(surface_get_target()));
                draw_clear(c_gray);
                surface_reset_target();
                
                surface_set_target(__CbDeferredSurfaceLightEnsure(surface_get_target()));
                draw_clear(__ambient);
                surface_reset_target();
            }
        }
    }
}