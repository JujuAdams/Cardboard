/// Starts Cb's native forward lighting shader

function CbLightShaderSet()
{
    __CB_GLOBAL
    
    static _u_vAmbient      = shader_get_uniform(__shdCbLighting, "u_vAmbient");
    static _u_fAlphaTestRef = shader_get_uniform(__shdCbLighting, "u_fAlphaTestRef");
    static _u_vPosRadArray  = shader_get_uniform(__shdCbLighting, "u_vPosRadArray");
    static _u_vColorArray   = shader_get_uniform(__shdCbLighting, "u_vColorArray");
    
    static _u_mLightViewProj0 = shader_get_uniform(__shdCbLighting, "u_mLightViewProj0");
    static _u_vLightPos0      = shader_get_uniform(__shdCbLighting, "u_vLightPos0");
    static _u_vLightColor0    = shader_get_uniform(__shdCbLighting, "u_vLightColor0");
    static _u_vLightZ0        = shader_get_uniform(__shdCbLighting, "u_vLightZ0");
    static _u_sLightDepth0    = shader_get_sampler_index(__shdCbLighting, "u_sLightDepth0");
    
    static _u_mLightViewProj1 = shader_get_uniform(__shdCbLighting, "u_mLightViewProj1");
    static _u_vLightPos1      = shader_get_uniform(__shdCbLighting, "u_vLightPos1");
    static _u_vLightColor1    = shader_get_uniform(__shdCbLighting, "u_vLightColor1");
    static _u_vLightZ1        = shader_get_uniform(__shdCbLighting, "u_vLightZ1");
    static _u_sLightDepth1    = shader_get_sampler_index(__shdCbLighting, "u_sLightDepth1");
    
    if (!CB_WRITE_NORMALS)
    {
        __CbError("CB_WRITE_NORMALS must be set to <true> for Cb lighting to work");
    }
    
    with(_global)
    {
        shader_set(__shdCbLighting);
        shader_set_uniform_f(_u_vAmbient, colour_get_red(  __lightingAmbience)/255,
                                          colour_get_green(__lightingAmbience)/255,
                                          colour_get_blue( __lightingAmbience)/255);
        shader_set_uniform_f(_u_fAlphaTestRef,      __alphaTestRef);
        shader_set_uniform_f_array(_u_vPosRadArray, __lightingPosRadArray);
        shader_set_uniform_f_array(_u_vColorArray,  __lightingColorArray);
        
        with(_global.__lightingShadowArray[0])
        {
            shader_set_uniform_matrix_array(_u_mLightViewProj0, __matrixViewProj);
            shader_set_uniform_f(_u_vLightPos0, __xFrom, __yFrom, __zFrom, __far);
            shader_set_uniform_f(_u_vLightColor0, color_get_red(  __color)/255,
                                                  color_get_green(__color)/255,
                                                  color_get_blue( __color)/255);
            shader_set_uniform_f(_u_vLightZ0, __near, __far);
            texture_set_stage(_u_sLightDepth0, surface_get_texture(__surface));
        }
        
        with(_global.__lightingShadowArray[1])
        {
            shader_set_uniform_matrix_array(_u_mLightViewProj1, __matrixViewProj);
            shader_set_uniform_f(_u_vLightPos1, __xFrom, __yFrom, __zFrom, __far);
            shader_set_uniform_f(_u_vLightColor1, color_get_red(  __color)/255,
                                                  color_get_green(__color)/255,
                                                  color_get_blue( __color)/255);
            shader_set_uniform_f(_u_vLightZ1, __near, __far);
            texture_set_stage(_u_sLightDepth1, surface_get_texture(__surface));
        }
    }
}