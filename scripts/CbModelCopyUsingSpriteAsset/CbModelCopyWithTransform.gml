function CbModelCopyWithTransform(_sourceModel, _destinationModel, _zRotation = 0, _xScale = 1, _yScale = 1, _zScale = 1, _xOffset = 0, _yOffset = 0, _zOffset = 0)
{
    _destinationModel.__CopyWithTransform(_sourceModel, _zRotation, _xScale, _yScale, _zScale, _xOffset, _yOffset, _zOffset);
}