function CbRender()
{
    CbSystemPrepareLighting();
    CbPassRender(CB_PASS.LIGHT_DEPTH);
    CbPassRender(CB_PASS.OPAQUE);
    CbPassRender(CB_PASS.TRANSPARENT);
    CbLightRenderDeferred();
    CbPassRender(CB_PASS.UNLIT);
}