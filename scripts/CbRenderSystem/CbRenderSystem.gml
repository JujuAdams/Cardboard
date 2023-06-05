/// @param [opaqueFunc]
/// @param [transparentFunc]
/// @param [unlitFunc]

function CbRenderSystem(_opaqueFunc, _transparentFunc, _unlitFunc)
{
    CbRenderPrepareLighting();
    CbRenderPass(_opaqueFunc, CB_PASS.OPAQUE);
    CbRenderPass(_transparentFunc, CB_PASS.TRANSPARENT);
    if (CbLightDepthMapsNeeded()) CbRenderDeferredLights();
    CbRenderPass(_unlitFunc, CB_PASS.UNLIT);
}