/// Sets the shader (and its uniforms) for the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbPassShaderSet(_pass)
{
    switch(_pass)
    {
        case CB_PASS.LIGHT_DEPTH:
            shader_reset();
        break;
        
        case CB_PASS.OPAQUE:
            shader_reset();
        break;
        
        case CB_PASS.TRANSPARENT:
            shader_reset();
        break;
        
        case CB_PASS.DEFERRED_LIGHT:
            shader_reset();
        break;
    }
}