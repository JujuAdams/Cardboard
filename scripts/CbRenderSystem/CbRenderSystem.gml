/// Convenience function that executes all Cardboard render passes, including lighting
/// 
/// @param [litOpaqueFunc]
/// @param [litAlphaBlendFunc]
/// @param [unlitOpaqueFunc]
/// @param [unlitAlphaBlendFunc]

function CbRenderSystem(_litOpaqueFunc, _litAlphaBlendFunc, _unlitOpaqueFunc, _unlitAlphaBlendFunc)
{
    CbRenderPrepareLighting();
    CbRenderPass(_litOpaqueFunc,       CB_PASS.LIT_OPAQUE);
    CbRenderPass(_litAlphaBlendFunc,   CB_PASS.LIT_ALPHA_BLEND);
    if (CbLightDepthMapsNeeded()) CbRenderDeferredLights();
    CbRenderPass(_unlitOpaqueFunc,     CB_PASS.UNLIT_OPAQUE);
    CbRenderPass(_unlitAlphaBlendFunc, CB_PASS.UNLIT_ALPHA_BLEND);
}