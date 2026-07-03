// Feather disable all

/// @param [viewMatrix]
/// @param [projectionMatrix]

function __CbRenderShaderOneShadowedLight(_viewMatrix = undefined, _projMatrix = undefined)
{
    __CB_GLOBAL_RENDER
    
    shader_set(__shdCbOneShadowMap);
    
    with(_global.__fog)
    {
        static _u_vFogParams = shader_get_uniform(__shdCbOneShadowMap, "u_vFogParams");
        static _u_vFogColor  = shader_get_uniform(__shdCbOneShadowMap, "u_vFogColor");
        
        if (__enabled)
        {
            shader_set_uniform_f(_u_vFogParams, __near, __far);
            shader_set_uniform_f(_u_vFogColor, colour_get_red(  __color)/255,
                                               colour_get_green(__color)/255,
                                               colour_get_blue( __color)/255);
        }
        else
        {
            shader_set_uniform_f(_u_vFogParams, 999998, 999999);
        }
    }
    
    with(_global.__lighting)
    {
        var _u_vAmbient     = shader_get_uniform(__shdCbOneShadowMap, "u_vAmbient");
        var _u_vPosRadArray = shader_get_uniform(__shdCbOneShadowMap, "u_vPosRadArray");
        var _u_vColorArray  = shader_get_uniform(__shdCbOneShadowMap, "u_vColorArray");
        
        shader_set_uniform_f(_u_vAmbient, colour_get_red(  __ambient)/255,
                                          colour_get_green(__ambient)/255,
                                          colour_get_blue( __ambient)/255);
        shader_set_uniform_f_array(_u_vPosRadArray, __posRadArray);
        shader_set_uniform_f_array(_u_vColorArray,  __colorArray);
        
        var _shadowedLightFound = false;
        var _i = 0;
        repeat(array_length(__lightStructArray))
        {
            with(__lightStructArray[_i].ref)
            {
                if (__hasShadows && visible)
                {
                    __SetDeferredUniformsForOneShadowMap();
                    _shadowedLightFound = true;
                    break;
                }
            }
            
            ++_i;
        }
        
        //Ensure that we reset the shadowed light colour if it disappears for some reason
        if (not _shadowedLightFound)
        {
            static _u_vLightColor = shader_get_uniform(__shdCbOneShadowMap, "u_vLightColor");
            
            shader_set_uniform_f(_u_vLightColor, 0, 0, 0);
        }
        else
        {
            //We only need to set matrices if we're rendering shadows
            
            if (_viewMatrix != undefined)
            {
                matrix_set(matrix_view, _viewMatrix);
            }
            
            if (_projMatrix != undefined)
            {
                __CbSetProjectionMatrix(_projMatrix);
            }
        }
    }
}