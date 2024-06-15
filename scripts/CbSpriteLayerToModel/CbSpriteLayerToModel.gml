function CbSpriteLayerToModel()
{
    return new __CbClassSpriteLayerToModel();
}

function __CbClassSpriteLayerToModel() constructor
{
    __dictionary = {};
    
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
                CbModelCopyUsingSpriteAsset(_conversionStruct.__model, _destinationModel, _asset, _zOffset, _conversionStruct.__zScaleMode);
            }
            
            ++_i;
        }
    }
}