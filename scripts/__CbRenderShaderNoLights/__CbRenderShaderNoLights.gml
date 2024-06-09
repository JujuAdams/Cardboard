function __CbRenderShaderNoLights()
{
    __CB_GLOBAL_RENDER
    
    shader_set(__shdCbNoLights);
    
    with(_global.__fog)
    {
        if (__enabled)
        {
            shader_set_uniform_f(shader_get_uniform(__shdCbNoLights, "u_vFogParams"), __near, __far);
            shader_set_uniform_f(shader_get_uniform(__shdCbNoLights, "u_vFogColor"), colour_get_red(  __color)/255,
                                                                                     colour_get_green(__color)/255,
                                                                                     colour_get_blue( __color)/255);
        }
        else
        {
            shader_set_uniform_f(shader_get_uniform(__shdCbNoLights, "u_vFogParams"), 999998, 999999);
        }
    }
}