CbCameraStoreMatrices();
oCamera.cbCamera.ApplyViewMatrix();
oCamera.cbCamera.ApplyProjectionMatrix();
CbRenderSystem(opaqueFunc, undefined, unlitFunc, undefined);
CbCameraRecallMatrices();

if (keyboard_check(ord("O")))
{
    draw_surface_depth(application_surface, 0, 0);
}

if (keyboard_check(ord("L")))
{
    var _surface = __CbDeferredSurfaceNormalEnsure(application_surface);
    draw_surface(_surface, 0, 0);
}

if (keyboard_check(ord("K")))
{
    light4.DrawDebug(0, 0);
}