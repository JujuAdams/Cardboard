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
        _vector[0] /= _wResult;
        _vector[1] /= _wResult;
        _vector[2] /= _wResult;
        _vector[3]  = (_wResult == 0)? 0 : 1;
        
        return _vector;
    }
    
    var _vpMatrixInverse = __CbCameraMatrixInvert(matrix_multiply(_viewMatrix, _projMatrix));
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

function __CbCameraMatrixInvert(_matrix)
{
    var _matrix_0 = _matrix[ 0];
    var _matrix_1 = _matrix[ 1];
    var _matrix_2 = _matrix[ 2];
    var _matrix_3 = _matrix[ 3];
    var _matrix_4 = _matrix[ 4];
    var _matrix_5 = _matrix[ 5];
    var _matrix_6 = _matrix[ 6];
    var _matrix_7 = _matrix[ 7];
    var _matrix_8 = _matrix[ 8];
    var _matrix_9 = _matrix[ 9];
    var _matrix10 = _matrix[10];
    var _matrix11 = _matrix[11];
    var _matrix12 = _matrix[12];
    var _matrix13 = _matrix[13];
    var _matrix14 = _matrix[14];
    var _matrix15 = _matrix[15];
    
    var _inv_0 =  _matrix_5*_matrix10*_matrix15 -
                  _matrix_5*_matrix11*_matrix14 -
                  _matrix_9*_matrix_6*_matrix15 +
                  _matrix_9*_matrix_7*_matrix14 +
                  _matrix13*_matrix_6*_matrix11 -
                  _matrix13*_matrix_7*_matrix10;

    var _inv_4 = -_matrix_4*_matrix10*_matrix15 +
                  _matrix_4*_matrix11*_matrix14 +
                  _matrix_8*_matrix_6*_matrix15 -
                  _matrix_8*_matrix_7*_matrix14 -
                  _matrix12*_matrix_6*_matrix11 +
                  _matrix12*_matrix_7*_matrix10;

    var _inv_8 =  _matrix_4*_matrix_9*_matrix15 -
                  _matrix_4*_matrix11*_matrix13 -
                  _matrix_8*_matrix_5*_matrix15 +
                  _matrix_8*_matrix_7*_matrix13 +
                  _matrix12*_matrix_5*_matrix11 -
                  _matrix12*_matrix_7*_matrix_9;

    var _inv12 = -_matrix_4*_matrix_9*_matrix14 +
                  _matrix_4*_matrix10*_matrix13 +
                  _matrix_8*_matrix_5*_matrix14 -
                  _matrix_8*_matrix_6*_matrix13 -
                  _matrix12*_matrix_5*_matrix10 +
                  _matrix12*_matrix_6*_matrix_9;

    var _inv_1 = -_matrix_1*_matrix10*_matrix15 +
                  _matrix_1*_matrix11*_matrix14 +
                  _matrix_9*_matrix_2*_matrix15 -
                  _matrix_9*_matrix_3*_matrix14 -
                  _matrix13*_matrix_2*_matrix11 +
                  _matrix13*_matrix_3*_matrix10;

    var _inv_5 =  _matrix_0*_matrix10*_matrix15 -
                  _matrix_0*_matrix11*_matrix14 -
                  _matrix_8*_matrix_2*_matrix15 +
                  _matrix_8*_matrix_3*_matrix14 +
                  _matrix12*_matrix_2*_matrix11 -
                  _matrix12*_matrix_3*_matrix10;

    var _inv_9 = -_matrix_0*_matrix_9*_matrix15 +
                  _matrix_0*_matrix11*_matrix13 +
                  _matrix_8*_matrix_1*_matrix15 -
                  _matrix_8*_matrix_3*_matrix13 -
                  _matrix12*_matrix_1*_matrix11 +
                  _matrix12*_matrix_3*_matrix_9;

    var _inv13 =  _matrix_0*_matrix_9*_matrix14 -
                  _matrix_0*_matrix10*_matrix13 -
                  _matrix_8*_matrix_1*_matrix14 +
                  _matrix_8*_matrix_2*_matrix13 +
                  _matrix12*_matrix_1*_matrix10 -
                  _matrix12*_matrix_2*_matrix_9;

    var _inv_2 =  _matrix_1*_matrix_6*_matrix15 -
                  _matrix_1*_matrix_7*_matrix14 -
                  _matrix_5*_matrix_2*_matrix15 +
                  _matrix_5*_matrix_3*_matrix14 +
                  _matrix13*_matrix_2*_matrix_7 -
                  _matrix13*_matrix_3*_matrix_6;

    var _inv_6 = -_matrix_0*_matrix_6*_matrix15 +
                  _matrix_0*_matrix_7*_matrix14 +
                  _matrix_4*_matrix_2*_matrix15 -
                  _matrix_4*_matrix_3*_matrix14 -
                  _matrix12*_matrix_2*_matrix_7 +
                  _matrix12*_matrix_3*_matrix_6;

    var _inv10 =  _matrix_0*_matrix_5*_matrix15 -
                  _matrix_0*_matrix_7*_matrix13 -
                  _matrix_4*_matrix_1*_matrix15 +
                  _matrix_4*_matrix_3*_matrix13 +
                  _matrix12*_matrix_1*_matrix_7 -
                  _matrix12*_matrix_3*_matrix_5;

    var _inv14 = -_matrix_0*_matrix_5*_matrix14 +
                  _matrix_0*_matrix_6*_matrix13 +
                  _matrix_4*_matrix_1*_matrix14 -
                  _matrix_4*_matrix_2*_matrix13 -
                  _matrix12*_matrix_1*_matrix_6 +
                  _matrix12*_matrix_2*_matrix_5;

    var _inv_3 = -_matrix_1*_matrix_6*_matrix11 +
                  _matrix_1*_matrix_7*_matrix10 +
                  _matrix_5*_matrix_2*_matrix11 -
                  _matrix_5*_matrix_3*_matrix10 -
                  _matrix_9*_matrix_2*_matrix_7 +
                  _matrix_9*_matrix_3*_matrix_6;

    var _inv_7 =  _matrix_0*_matrix_6*_matrix11 -
                  _matrix_0*_matrix_7*_matrix10 -
                  _matrix_4*_matrix_2*_matrix11 +
                  _matrix_4*_matrix_3*_matrix10 +
                  _matrix_8*_matrix_2*_matrix_7 -
                  _matrix_8*_matrix_3*_matrix_6;

    var _inv11 = -_matrix_0*_matrix_5*_matrix11 +
                  _matrix_0*_matrix_7*_matrix_9 +
                  _matrix_4*_matrix_1*_matrix11 -
                  _matrix_4*_matrix_3*_matrix_9 -
                  _matrix_8*_matrix_1*_matrix_7 +
                  _matrix_8*_matrix_3*_matrix_5;

    var _inv15 =  _matrix_0*_matrix_5*_matrix10 -
                  _matrix_0*_matrix_6*_matrix_9 -
                  _matrix_4*_matrix_1*_matrix10 +
                  _matrix_4*_matrix_2*_matrix_9 +
                  _matrix_8*_matrix_1*_matrix_6 -
                  _matrix_8*_matrix_2*_matrix_5;

    var _inverseDeterminant = 1 / (_matrix_0*_inv_0 + _matrix_1*_inv_4 + _matrix_2*_inv_8 + _matrix_3*_inv12);
    if (is_nan(_inverseDeterminant) || is_infinity(_inverseDeterminant))
    {
        if (GM_build_type == "run") show_debug_message("Warning! Matrix determinant is zero");
        return _matrix;
    }
    
    return [_inv_0*_inverseDeterminant,
            _inv_1*_inverseDeterminant,
            _inv_2*_inverseDeterminant,
            _inv_3*_inverseDeterminant,
            _inv_4*_inverseDeterminant,
            _inv_5*_inverseDeterminant,
            _inv_6*_inverseDeterminant,
            _inv_7*_inverseDeterminant,
            _inv_8*_inverseDeterminant,
            _inv_9*_inverseDeterminant,
            _inv10*_inverseDeterminant,
            _inv11*_inverseDeterminant,
            _inv12*_inverseDeterminant,
            _inv13*_inverseDeterminant,
            _inv14*_inverseDeterminant,
            _inv15*_inverseDeterminant];
}