function CbSpriteLayerToModel()
{
    return new __CbClassSpriteLayerToModel();
}

function __CbClassSpriteLayerToModel() constructor
{
    __zGrid           = undefined;
    __zGridWidth      = 0;
    __zGridHeight     = 0;
    __zGridCellWidth  = 16;
    __zGridCellHeight = 16;
    __zGridCellDepth  = 16;
    
    __dictionary = {};
    
    static SetZGrid = function(_zGrid, _cellWidth, _cellHeight, _cellDepth)
    {
        __zGrid           = _zGrid;
        __zGridWidth      = ds_grid_width(_zGrid);
        __zGridHeight     = ds_grid_height(_zGrid);
        __zGridCellWidth  = _cellWidth;
        __zGridCellHeight = _cellHeight;
        __zGridCellDepth  = _cellDepth;
        
        return self;
    }
    
    static Add = function(_sprite, _image, _model, _zScaleMode = 0)
    {
        __dictionary[$ string_concat(real(_sprite), ":", _image)] = {
            __model: _model,
            __zScaleMode: _zScaleMode,
        };
        
        return self;
    }
    
    static Convert = function(_layer, _destinationModel, _zOffset = 0)
    {
        var _array = layer_get_all_elements(_layer);
        var _i = 0;
        repeat(array_length(_array))
        {
            var _asset = _array[_i];
            var _key = string_concat(real(layer_sprite_get_sprite(_asset)), ":", layer_sprite_get_index(_asset));
            
            var _conversionStruct = __dictionary[$ _key];
            if (_conversionStruct != undefined)
            {
                if (__zGrid != undefined)
                {
                    var _x = layer_sprite_get_x(_asset) div __zGridCellWidth;
                    var _y = layer_sprite_get_y(_asset) div __zGridCellHeight;
                    var _z = __zGridCellDepth*(__zGrid[# clamp(_x, 0, __zGridWidth-1), clamp(_y, 0, __zGridHeight-1)] ?? 0);
                    
                    var _yOffset = _z;
                    _z += _zOffset;
                }
                else
                {
                    var _yOffset = 0;
                    var _z = _zOffset;
                }
                
                CbModelCopyUsingSpriteAsset(_conversionStruct.__model, _destinationModel, _asset, 0, _yOffset, _z, _conversionStruct.__zScaleMode);
            }
            
            ++_i;
        }
    }
}