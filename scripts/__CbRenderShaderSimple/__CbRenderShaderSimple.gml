function __CbRenderShaderSimple()
{
    __CB_GLOBAL_RENDER
    
    shader_set(__shdCbSimpleLights);
    
    with(_global.__fog)
    {
        if (__enabled)
        {
            shader_set_uniform_f(shader_get_uniform(__shdCbSimpleLights, "u_vFogParams"), __near, __far);
            shader_set_uniform_f(shader_get_uniform(__shdCbSimpleLights, "u_vFogColor"), colour_get_red(  __color)/255,
                                                                                         colour_get_green(__color)/255,
                                                                                         colour_get_blue( __color)/255);
        }
        else
        {
            shader_set_uniform_f(shader_get_uniform(__shdCbSimpleLights, "u_vFogParams"), 999998, 999999);
        }
    }
    
    with(_global.__lighting)
    {
        shader_set_uniform_f(shader_get_uniform(__shdCbSimpleLights, "u_vAmbient"), colour_get_red(  __ambient)/255,
                                                                                    colour_get_green(__ambient)/255,
                                                                                    colour_get_blue( __ambient)/255);
        shader_set_uniform_f_array(shader_get_uniform(__shdCbSimpleLights, "u_vPosRadArray"), __posRadArray);
        shader_set_uniform_f_array(shader_get_uniform(__shdCbSimpleLights, "u_vColorArray"),  __colorArray);
    }
}