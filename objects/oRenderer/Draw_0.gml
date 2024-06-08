CbRenderSystem(opaqueFunc, undefined, unlitFunc);

if (keyboard_check(ord("O")))
{
    draw_surface_depth(application_surface, 0, 0);
}

if (keyboard_check(ord("L")))
{
    var _surface = __CbDeferredSurfaceNormalEnsure(application_surface);
    draw_surface(_surface, 0, 0);
}