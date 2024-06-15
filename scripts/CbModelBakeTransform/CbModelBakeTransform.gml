/// @param model

function CbModelBakeTransform(_model, _zRotation = 0, _xScale = 1, _yScale = 1, _zScale = 1, _xOffset = 0, _yOffset = 0, _zOffset = 0)
{
    _model.__BakeTransform(_zRotation, _xScale, _yScale, _zScale, _xOffset, _yOffset, _zOffset);
}