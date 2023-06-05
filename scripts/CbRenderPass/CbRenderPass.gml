/// Renders the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param function
/// @param pass

function CbRenderPass(_function, _pass)
{
    //If a function hasn't been set for this pass then don't do anything
    if (_function == undefined) return;
    
    CbRenderStateSet(_pass);
    _function();
    CbBatchForceSubmit(); //If we've got a pending batch then submit that before resetting draw state
    CbRenderStateReset();
}