function CbSystemRender()
{
    CbSystemPrepareLighting();
    if (CbLightDepthMapsNeeded()) CbPassRender(CB_PASS.LIGHT_DEPTH);
    CbPassRender(CB_PASS.OPAQUE);
    CbPassRender(CB_PASS.TRANSPARENT);
    if (CbLightDepthMapsNeeded()) CbLightRenderDeferred();
    CbPassRender(CB_PASS.UNLIT);
}