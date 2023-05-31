/// Renders the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbPassRender(_pass)
{
    var _function = CbPassFunctionGet(_pass);
    
    //If a function hasn't been set for this pass then don't do anything
    if (not is_method(_function)) return;
    
    //Don't render out the .LIGHT_DEPTH or .DEFERRED_LIGHT passes if we're not in a light mode
    //that supports deferred lights
    var _lightMode = CbSystemLightModeGet();
    if (((_pass == CB_PASS.LIGHT_DEPTH) || (_pass == CB_PASS.DEFERRED_LIGHT)) && (_lightMode != CB_LIGHT_MODE.ONE_SHADOW_MAP) && (_lightMode != CB_LIGHT_MODE.DEFERRED))
    {
        return;
    }
    
    CbPassRenderStateSet(_pass);
    
    switch(_pass)
    {
        case CB_PASS.LIGHT_DEPTH:
            var _array = CbLightArrayGet();
            var _i = 0;
            repeat(array_length(_array))
            {
                _array[_i].RenderDepth(_function);
                ++_i;
            }
        break;
        
        case CB_PASS.OPAQUE:
        case CB_PASS.TRANSPARENT:
            _function();
            
            //If we've got a pending batch then submit that before resetting draw state
            CbBatchForceSubmit();
        break;
        
        case CB_PASS.DEFERRED_LIGHT:
            var _array = CbLightArrayGet();
            var _i = 0;
            repeat(array_length(_array))
            {
                _array[_i].Render(_function);
                ++_i;
            }
        break;
    }
    
    CbPassRenderStateReset();
}