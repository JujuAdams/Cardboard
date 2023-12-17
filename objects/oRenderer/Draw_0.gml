CbRenderSystem(opaqueFunc, undefined, unlitFunc);

if (keyboard_check(ord("O")))
{
    var _surface = __CbDeferredSurfaceDepthEnsure(application_surface);
    draw_surface(_surface, 0, 0);
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