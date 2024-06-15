function CbModelCopyUsingSpriteAsset(_sourceModel, _destinationModel, _spriteElementID, _zOffset = 0, _zScaleMode = 0)
{
    var _xScale = layer_sprite_get_xscale(_spriteElementID);
    var _yScale = layer_sprite_get_yscale(_spriteElementID);
    
    if (_zScaleMode == 0)
    {
        var _zScale = 1;
    }
    else if (_zScaleMode == 1)
    {
        var _zScale = _yScale;
        _yScale = 1;
    }
    else if (_zScaleMode == 2)
    {
        if (abs(_xScale) > abs(_yScale))
        {
            _yScale = _xScale;
            _zScale = _xScale;
        }
        else
        {
            _xScale = _yScale;
            _zScale = _yScale;
        }
    }
    
    return CbModelCopyWithTransform(_sourceModel, _destinationModel, _xScale, _yScale, _zScale, layer_sprite_get_angle(_spriteElementID), layer_sprite_get_x(_spriteElementID), layer_sprite_get_y(_spriteElementID), _zOffset);
}