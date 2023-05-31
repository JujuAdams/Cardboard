/// Sets the view and projection matrices for the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// N.B. This function should only be called for the .OPAQUE and .TRANSPARENT passes
/// 
/// @param pass

function CbPassMatricesSet(_pass)
{
    switch(_pass)
    {
        case CB_PASS.OPAQUE:
        case CB_PASS.TRANSPARENT:
            var _matrixStruct = CbPassMatricesGet(_pass);
            matrix_set(matrix_view, _matrixStruct.view);
            matrix_set(matrix_projection, _matrixStruct.projection);
        break;
        
        default:
            __CbTrace("CbPassMatricesSet() not supported for pass ", _pass);
        break;
    }
}