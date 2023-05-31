/// Returns the view and projection matrices for the given pass in a struct
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// N.B. This function should only be called for the .OPAQUE and .TRANSPARENT passes
/// 
/// @param pass

function CbPassMatricesGet(_pass)
{
    __CB_GLOBAL
    
    switch(_pass)
    {
        case CB_PASS.OPAQUE:
        case CB_PASS.TRANSPARENT:
            with(_global.__camera)
            {
                return {
                    view:       CbViewMatrixBuild(__xFrom, __yFrom, __zFrom, __xTo, __yTo, __zTo, __axonometric, __xUp, __yUp, __zUp),
                    projection: matrix_build_projection_ortho(__width, __height, __near, __far),
                };
            }
        break;
        
        default:
            __CbError("CbPassSurfacesGet() not supported for pass ", _pass);
        break;
    }
}