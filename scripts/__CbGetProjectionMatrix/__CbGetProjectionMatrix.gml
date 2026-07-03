/// Gets the global GPU projection matrix. This function should be called in place of
/// `matrix_get(matrix_projection)`. You may specify an optional "result matrix" that will be
/// overwritten by the current projection matrix. If no result matrix is specified then this
/// function will return a new matrix.
/// 
/// @param [resultMatrix]

function __CbGetProjectionMatrix(_resultMatrix = undefined)
{
    if (_resultMatrix == undefined)
    {
        if (CB_RENDER_NORMATIVE)
        {
            return matrix_get(matrix_projection);
        }
        else
        {
            _resultMatrix = matrix_get(matrix_projection);
            return __CbFixProjectionMatrix(_resultMatrix, _resultMatrix);
        }
    }
    else
    {
        if (CB_RENDER_NORMATIVE)
        {
            matrix_get(matrix_projection, _resultMatrix);
            return _resultMatrix;
        }
        else
        {
            matrix_get(matrix_projection, _resultMatrix)
            return __CbFixProjectionMatrix(_resultMatrix, _resultMatrix);
        }
    }
}