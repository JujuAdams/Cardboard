/// Renders the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbPassRender(_pass)
{
    //If a function hasn't been set for this pass then don't do anything
    if (!CbPassFunctionExist(_pass)) return;
    
    CbPassRenderStateSet(_pass);
    
    switch(_pass)
    {
        case CB_PASS.LIGHT_DEPTH:
            CbLightRenderAllDepthMaps(CbPassFunctionGet(_pass));
        break;
        
        case CB_PASS.OPAQUE:
        case CB_PASS.TRANSPARENT:
        case CB_PASS.UNLIT:
            CbPassFunctionGet(_pass)();
            
            //If we've got a pending batch then submit that before resetting draw state
            CbBatchForceSubmit();
        break;
    }
    
    CbPassRenderStateReset();
}