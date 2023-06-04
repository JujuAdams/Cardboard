/// Sets the view and projection matrices for the current Cardboard camera

function CbCameraMatricesSet()
{
    var _matrixStruct = CbCameraMatricesGet();
    matrix_set(matrix_view, _matrixStruct.view);
    matrix_set(matrix_projection, _matrixStruct.projection);
}