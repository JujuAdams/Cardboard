oCamera.cbCamera.ApplyMatrices();
CbRenderConvenience(opaqueFunc, undefined, unlitFunc);

//oCamera.cbCamera.Start();
//opaqueFunc();
//unlitFunc();
//oCamera.cbCamera.End();

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