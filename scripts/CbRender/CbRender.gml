function CbRender()
{
    CbSystemPrepareLighting();
    CbPassRender(CB_PASS.LIGHT_DEPTH);
    CbPassRender(CB_PASS.OPAQUE);
    CbPassRender(CB_PASS.TRANSPARENT);
    CbPassRender(CB_PASS.DEFERRED_LIGHT);
}