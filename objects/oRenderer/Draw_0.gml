if (not surface_exists(surfaceDepth))
{
    surfaceDepth = surface_create(1366, 768);
}

var _lightX = lerp(0, 100, 0.5 + 0.5*dsin(0.1*current_time));
var _lightRadius = 1000;

var _lightMatrixView = matrix_build_lookat( 300 + _lightX, 450, 300,
                                           -150,           150,   0,
                                              0,             0,   1);

var _lightMatrixProj = matrix_build_projection_perspective_fov(90, 1366/768, 100, _lightRadius);

var _lightMatrix = matrix_multiply(_lightMatrixView, _lightMatrixProj);

var _i = 0;
repeat(3)
{
    switch(_i)
    {
        case 0:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(true);
            gpu_set_cullmode(cull_noculling);
            
            surface_set_target(surfaceDepth);
            draw_clear(c_white);
            
            shader_set(__shdCardboardDepth);
            shader_set_uniform_f(shader_get_uniform(__shdCardboardDepth, "u_fAlphaTestRef"), 0.5);
            
            var _oldView = matrix_get(matrix_view);
            var _oldProj = matrix_get(matrix_projection);
            
            matrix_set(matrix_view,       _lightMatrixView);
            matrix_set(matrix_projection, _lightMatrixProj);
                                                        
            oScene.Draw();
            CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
            
            matrix_set(matrix_view,       _oldView);
            matrix_set(matrix_projection, _oldProj);
            
            shader_reset();
            surface_reset_target();
            
            gpu_set_ztestenable(false);
            gpu_set_zwriteenable(false);
            gpu_set_cullmode(cull_noculling);
        break;
        
        case 1:
            /*
            //Start Cardboard's quick start renderer
            //You don't have to use this function but it does make things a lot easier
            CardboardRenderStateSet(1366, 768,
                                    oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                                    oCamera.camToX, oCamera.camToY, oCamera.camToZ,
                                    axonometric);
            
            if (CARDBOARD_WRITE_NORMALS)
            {
                CardboardLightingAmbienceSet(c_dkgray);
                CardboardLightingPointSet(0, -240,  400, 300, 2200, c_yellow);
                CardboardLightingPointSet(1,  240,  400, 300, 2200, c_white);
                CardboardLightingPointSet(2,    0, -400, 300, 2200, c_red);
                CardboardLightingStart();
            }
            
            //Draw the scene object
            oScene.Draw();
            
            //Draw a lil triangle at the camera's "to" position
            CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
            
            if (CARDBOARD_WRITE_NORMALS)
            {
                CardboardLightingEnd();
            }
            
            //Reset render state
            CardboardRenderStateReset();
            */
        break;
        
        case 2:
            CardboardRenderStateSet(1366, 768,
                                    oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                                    oCamera.camToX, oCamera.camToY, oCamera.camToZ,
                                    axonometric);
            
            shader_set(__shdCardboardTest);
            shader_set_uniform_matrix_array(shader_get_uniform(__shdCardboardTest, "u_mLightViewProj"), _lightMatrix);
            shader_set_uniform_f(shader_get_uniform(__shdCardboardTest, "u_vLightPos"), 300 + _lightX, 450, 300, _lightRadius);
            shader_set_uniform_f(shader_get_uniform(__shdCardboardTest, "u_fAlphaTestRef"), 0.5);
            texture_set_stage(shader_get_sampler_index(__shdCardboardTest, "u_sLightDepth"), surface_get_texture(surfaceDepth));
            
            oScene.Draw();
            CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
            
            shader_reset();
            
            CardboardRenderStateReset();
        break;
    }
    
    ++_i;
}

if (keyboard_check(ord("L")))
{
    draw_surface(surfaceDepth, 0, 0);
}

if (keyboard_check(ord("O")))
{
    shader_set(__shdCardboardDepthTest);
    draw_surface(surfaceDepth, 0, 0);
    shader_reset();
}