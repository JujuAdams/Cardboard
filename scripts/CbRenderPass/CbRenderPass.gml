/// Renders the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param function
/// @param pass
/// @param [viewMatrix]
/// @param [projectionMatrix]

function CbRenderPass(_function, _pass, _viewMatrix = undefined, _projectionMatrix = undefined)
{
    //If a function hasn't been set for this pass then don't do anything
    if (_function == undefined) return;
    
    CbRenderStateSet(_pass, _viewMatrix, _projectionMatrix);
    _function();
    CbBatchForceSubmit(); //If we've got a pending batch then submit that before resetting draw state
    CbRenderStateReset();
}