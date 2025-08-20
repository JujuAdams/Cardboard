// Feather disable all

/// @param viewMatrix
/// @param projMatrix

function CbCameraGetFrustrumCoords(_viewMatrix, _projMatrix)
{
    static _result = {
        tlNear: undefined,
        trNear: undefined,
        blNear: undefined,
        brNear: undefined,
        tlFar:  undefined,
        trFar:  undefined,
        blFar:  undefined,
        brFar:  undefined,
    };
    
    static _matrixTransformDivByW = function(_matrix, _x, _y, _z, _w)
    {
        var _vector = matrix_transform_vertex(_matrix, _x, _y, _z, _w);
        
        var _wResult = _vector[3];
        if (_wResult == 0)
        {
            //High unacademic but good enough. We want to avoid NaN or infinity creeping in.
            _vector[0] *= 999999;
            _vector[1] *= 999999;
            _vector[2] *= 999999;
            _vector[3]  = 0;
        }
        else
        {
            _vector[0] /= _wResult;
            _vector[1] /= _wResult;
            _vector[2] /= _wResult;
            _vector[3]  = 1;
        }
        
        return _vector;
    }
    
    var _vpMatrixInverse = matrix_inverse(matrix_multiply(_viewMatrix, _projMatrix));
    with(_result)
    {
        tlNear = _matrixTransformDivByW(_vpMatrixInverse, -1, -1, 0, 1);
        trNear = _matrixTransformDivByW(_vpMatrixInverse,  1, -1, 0, 1);
        blNear = _matrixTransformDivByW(_vpMatrixInverse, -1,  1, 0, 1);
        brNear = _matrixTransformDivByW(_vpMatrixInverse,  1,  1, 0, 1);
        tlFar  = _matrixTransformDivByW(_vpMatrixInverse, -1, -1, 1, 1);
        trFar  = _matrixTransformDivByW(_vpMatrixInverse,  1, -1, 1, 1);
        blFar  = _matrixTransformDivByW(_vpMatrixInverse, -1,  1, 1, 1);
        brFar  = _matrixTransformDivByW(_vpMatrixInverse,  1,  1, 1, 1);
    }
    
    return _result;
}