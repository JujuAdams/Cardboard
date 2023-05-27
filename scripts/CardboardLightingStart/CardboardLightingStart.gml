function CardboardLightingStart()
{
    __CARDBOARD_GLOBAL
    
    static _u_fAlphaTestRef = shader_get_uniform(__shdCardboardLighting, "u_fAlphaTestRef");
    
    if (!CARDBOARD_WRITE_NORMALS)
    {
        __CardboardError("CARDBOARD_WRITE_NORMALS must be set to <true> for Cardboard lighting to work");
    }
    
    if (_global.__lightingStarted)
    {
        __CardboardError("Cardboard lighting has already been started");
    }
    else
    {
        shader_set(__shdCardboardLighting);
        shader_set_uniform_f(_u_fAlphaTestRef, _global.__alphaTestRef);
    }
}