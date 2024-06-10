if (keyboard_check(ord("O")))
{
    shader_set(shdLinearizeDepth);
    shader_set_uniform_f(shader_get_uniform(shdLinearizeDepth, "u_fLinearize"), not oCamera.cbCamera.__orthographic);
    shader_set_uniform_f(shader_get_uniform(shdLinearizeDepth, "u_fZNear"), oCamera.cbCamera.__near);
    shader_set_uniform_f(shader_get_uniform(shdLinearizeDepth, "u_fZFar"), oCamera.cbCamera.__far);
    draw_surface_depth(application_surface, 0, 0);
    shader_reset();
}