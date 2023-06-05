/// Returns the view and projection matrices for the current Cardboard camera, in a struct

function CbCameraMatricesGet()
{
    __CB_GLOBAL_RENDER
    
    with(_global.__camera)
    {
        if (__CB_ON_OPENGL)
        {
            if (__orthographic)
            {
                var _view       = CbBuildViewMatrix(__xFrom, __yFrom, __zFrom, __xTo, __yTo, __zTo, __axonometric, __xUp, __yUp, __zUp);
                var _projection = matrix_build_projection_ortho(__width, -__height, __near, __far);
                
            }
            else
            {
                var _view       = CbBuildViewMatrix(__xFrom, __yFrom, __zFrom, __xTo, __yTo, __zTo, __axonometric, -__xUp, -__yUp, -__zUp);
                var _projection = matrix_build_projection_perspective_fov(__fieldOfView, -__width/__height, __near, __far);
            }
            
            return {
                view:       _view,
                projection: _projection,
            };
        }
        else
        {
            if (__orthographic)
            {
                var _projection = matrix_build_projection_ortho(__width, __height, __near, __far);
            }
            else
            {
                var _projection = matrix_build_projection_perspective_fov(__fieldOfView, __width/__height, __near, __far);
            }
            
            return {
                view: CbBuildViewMatrix(__xFrom, __yFrom, __zFrom, __xTo, __yTo, __zTo, __axonometric, __xUp, __yUp, __zUp),
                projection: _projection,
            };
        }
    }
}