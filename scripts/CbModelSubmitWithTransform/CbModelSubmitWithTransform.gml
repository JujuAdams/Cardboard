/// Submits the given model to the GPU (draws the model)
/// 
/// @param model  The model to submit to the GPU
/// @param [xScale=1]
/// @param [yScale=1]
/// @param [zScale=1]
/// @param [zAngle=0]
/// @param [xOFffset=0]
/// @param [yOffset=0]
/// @param [zOffset=0]
/// @param [resetMatrix=true]

function CbModelSubmitWithTransform(_model, _xScale = 1, _yScale = 1, _zScale = 1, _zAngle = 0, _xOffset = 0, _yOffset = 0, _zOffset = 0, _resetMatrix = true)
{
    static _identityMatrix = matrix_build_identity();
    static _matrix = matrix_build_identity();
    
    if (_zAngle == 0)
    {
        _matrix[ 0] = _xScale;
        _matrix[ 1] = 0;
        _matrix[ 4] = 0;
        _matrix[ 5] = _yScale;
    }
    else
    {
        var _sin = dsin(_zAngle);
        var _cos = dcos(_zAngle);
        
        _matrix[ 0] =  _xScale*_cos;
        _matrix[ 1] = -_xScale*_sin;
        _matrix[ 4] =  _yScale*_sin;
        _matrix[ 5] =  _yScale*_cos;
    }
    
    _matrix[10] = _zScale;
    _matrix[12] = _xOffset;
    _matrix[13] = _yOffset;
    _matrix[14] = _zOffset;
    
    matrix_set(matrix_world, _matrix);
    _model.__Submit();
    
    if (_resetMatrix)
    {
        matrix_set(matrix_world, _identityMatrix);
    }
}