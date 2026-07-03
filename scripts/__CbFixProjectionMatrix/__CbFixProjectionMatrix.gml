/// Fixes a projection matrix, ready for manually sending to the GPU using GameMaker's native
/// functions. You may specify a "result matrix" will will be set to the fixed projection matrix.
/// 
/// You won't normally need to call this function and it is provided for situation where you are
/// handling GPU state yourself.
/// 
/// @param matrix
/// @param [resultMatrix]

function __CbFixProjectionMatrix(_matrix, _resultMatrix = undefined)
{
    if (_resultMatrix == undefined)
    {
        _resultMatrix = array_create(16);
    }
    
    if (_matrix != _resultMatrix)
    {
        array_copy(_resultMatrix, 0, _matrix, 0, 16);
    }
    
    if (not CB_RENDER_NORMATIVE)
    {
        _resultMatrix[@  1] = -_resultMatrix[ 1];
        _resultMatrix[@  5] = -_resultMatrix[ 5];
        _resultMatrix[@  9] = -_resultMatrix[ 9];
        _resultMatrix[@ 13] = -_resultMatrix[13];
    }
    
    return _resultMatrix;
}