function CbFogGet()
{
    __CB_GLOBAL_RENDER
    
    with(__fog)
    {
        return {
            enabled: __enabled,
            color:   __color,
            near:    __near,
            far:     __far,
        };
    } 
}