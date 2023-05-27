function CardboardLightingStart()
{
    __CARDBOARD_GLOBAL
    
    static _u_fAlphaTestRef   = shader_get_uniform(__shdCardboardLighting, "u_fAlphaTestRef");
    static _u_vPositionRadius = shader_get_uniform(__shdCardboardLighting, "u_vPositionRadius");
    static _u_vColor          = shader_get_uniform(__shdCardboardLighting, "u_vColor");
    
    if (!CARDBOARD_WRITE_NORMALS)
    {
        __CardboardError("CARDBOARD_WRITE_NORMALS must be set to <true> for Cardboard lighting to work");
    }
    
    with(_global)
    {
        if (__lightingStarted)
        {
            __CardboardError("Cardboard lighting has already been started");
        }
        else
        {
            __lightingStarted = true;
            
            shader_set(__shdCardboardLighting);
            shader_set_uniform_f(_u_fAlphaTestRef,   __alphaTestRef/255);
            shader_set_uniform_f(_u_vPositionRadius, __lightingX, __lightingY, __lightingZ, __lightingRadius);
            shader_set_uniform_f(_u_vColor,          color_get_red(__lightingColor)/255, color_get_green(__lightingColor)/255, color_get_blue(__lightingColor)/255);
        }
    }
}