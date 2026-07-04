if (keyboard_check(ord("O")))
{
    shader_set(shdLinearizeDepth);
    shader_set_uniform_f(shader_get_uniform(shdLinearizeDepth, "u_fLinearize"), not oCamera.cbCamera.__orthographic);
    shader_set_uniform_f(shader_get_uniform(shdLinearizeDepth, "u_fZNear"), oCamera.cbCamera.__near);
    shader_set_uniform_f(shader_get_uniform(shdLinearizeDepth, "u_fZFar"), oCamera.cbCamera.__far);
    draw_surface_depth(application_surface, 0, 0);
    shader_reset();
}

if (keyboard_check(ord("F")))
{
    shader_set(__shdCbDeferredGetDiffuse);
    draw_surface(__CbDeferredSurfaceGBufferEnsure(application_surface), 0, 0);
    shader_reset();
}

if (keyboard_check(ord("L")))
{
    shader_set(__shdCbDeferredGetNormal);
    draw_surface(__CbDeferredSurfaceGBufferEnsure(application_surface), 0, 0);
    shader_reset();
}

if (keyboard_check(ord("K")))
{
    light3.DrawDebug(0, 0);
}