/// Starts Cardboard's native forward lighting shader

function CardboardLightShaderSet()
{
    __CARDBOARD_GLOBAL
    
    static _u_vAmbient      = shader_get_uniform(__shdCardboardLighting, "u_vAmbient");
    static _u_fAlphaTestRef = shader_get_uniform(__shdCardboardLighting, "u_fAlphaTestRef");
    static _u_vPosRadArray  = shader_get_uniform(__shdCardboardLighting, "u_vPosRadArray");
    static _u_vColorArray   = shader_get_uniform(__shdCardboardLighting, "u_vColorArray");
    
    if (!CARDBOARD_WRITE_NORMALS)
    {
        __CardboardError("CARDBOARD_WRITE_NORMALS must be set to <true> for Cardboard lighting to work");
    }
    
    with(_global)
    {
        shader_set(__shdCardboardLighting);
        shader_set_uniform_f(_u_vAmbient, colour_get_red(  __lightingAmbience)/255,
                                            colour_get_green(__lightingAmbience)/255,
                                            colour_get_blue( __lightingAmbience)/255);
        shader_set_uniform_f(_u_fAlphaTestRef,      __alphaTestRef/255);
        shader_set_uniform_f_array(_u_vPosRadArray, __lightingPosRadArray);
        shader_set_uniform_f_array(_u_vColorArray,  __lightingColorArray);
    }
}