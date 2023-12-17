/// @param [litOpaqueFunc]
/// @param [litAlphaBlendFunc]
/// @param [unlitOpaqueFunc]
/// @param [unlitAlphaBlendFunc]

function CbRenderSystem(_litOpaqueFunc = undefined, _litAlphaBlendFunc = undefined, _unlitOpaqueFunc = undefined, _unlitAlphaBlendFunc = undefined)
{
    var _diffuseSurface = surface_get_target();
    
    CbRenderPrepareLighting();
    CbRenderPass(_litOpaqueFunc,       CB_PASS.LIT_OPAQUE);
    CbRenderPass(_litAlphaBlendFunc,   CB_PASS.LIT_ALPHA_BLEND);
    CbRenderDeferredLights(_diffuseSurface);
    CbRenderPass(_unlitOpaqueFunc,     CB_PASS.UNLIT_OPAQUE);
    CbRenderPass(_unlitAlphaBlendFunc, CB_PASS.UNLIT_ALPHA_BLEND);
}