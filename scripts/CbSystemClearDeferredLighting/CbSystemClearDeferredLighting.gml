function CbSystemClearDeferredLighting()
{
    surface_set_target(__CbDeferredSurfaceDiffuseEnsure(surface_get_target()));
	draw_clear_alpha(c_black, 0);
    surface_reset_target();
    
    surface_set_target(__CbDeferredSurfaceDepthEnsure(surface_get_target()));
	draw_clear(c_white);
    surface_reset_target();
    
    surface_set_target(__CbDeferredSurfaceNormalEnsure(surface_get_target()));
	draw_clear(c_gray);
    surface_reset_target();
}