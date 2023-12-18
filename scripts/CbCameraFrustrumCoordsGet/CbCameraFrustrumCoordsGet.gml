// Feather disable all

function CbCameraFrustrumCoordsGet()
{
    var _matrices = CbCameraMatricesGet();
    return CbFrustrumCoordsGet(_matrices.view, _matrices.projection);
}