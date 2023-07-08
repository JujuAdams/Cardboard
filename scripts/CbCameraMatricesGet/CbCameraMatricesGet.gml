/// Returns the view and projection matrices for the current Cardboard camera, in a struct

function CbCameraMatricesGet()
{
    __CB_GLOBAL_RENDER
    
    with(_global.__camera)
    {
        var _coeff = __CB_ON_OPENGL? -1 : 1;
        
        if (__orthographic)
        {
            var _projection = matrix_build_projection_ortho(__width, _coeff*__height, __near, __far);
        }
        else
        {
            var _projection = matrix_build_projection_perspective_fov(__fieldOfView, _coeff*__width/__height, __near, __far);
        }
        
        if (__CB_ON_OPENGL && __orthographic) _coeff = 1;
        
        if (__zTilt)
        {
            var _view = CbBuildZTiltViewMatrix(__xFrom, __yFrom, __zFrom, __xTo, __yTo, __zTo, __axonometric, _coeff*__xUp, _coeff*__yUp, _coeff*__zUp);
        }
        else
        {
            var _view = matrix_build_lookat(__xFrom, __yFrom, __zFrom, __xTo, __yTo, __zTo, _coeff*__xUp, _coeff*__yUp, _coeff*__zUp);
        }
        
        return {
            view: _view,
            projection: _projection,
        };
    }
}