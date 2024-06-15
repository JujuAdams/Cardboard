function CbModelCopyWithTransform(_sourceModel, _destinationModel, _xScale = 1, _yScale = 1, _zScale = 1, _zRotation = 0, _xOffset = 0, _yOffset = 0, _zOffset = 0)
{
    _destinationModel.__CopyWithTransform(_sourceModel, _xScale, _yScale, _zScale, _zRotation, _xOffset, _yOffset, _zOffset);
}