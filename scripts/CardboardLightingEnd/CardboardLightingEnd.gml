/// Ends Cardboard's forward lighting shader

function CardboardLightingEnd()
{
    __CARDBOARD_GLOBAL
    
    if (_global.__lightingStarted)
    {
        _global.__lightingStarted = false;
        
        shader_reset();
    }
    else
    {
        __CardboardError("Cardboard lighting has already been ended");
    }
}