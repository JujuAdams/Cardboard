#macro __CARDBOARD_SPRITE_COMMON_TEXTURE ;\
var _flooredImage = floor(max(0, _image)) mod sprite_get_number(_sprite);\
var _imageData = _global.__texturePageIndexMap[? __CARDBOARD_MAX_IMAGES*_sprite + _flooredImage];\
;\
;\//Break the batch if we've swapped texture
if (_imageData.textureIndex != _global.__batchTextureIndex)\
{\
    __CardboardBatchComplete();\
    ;\
    _global.__batchTexturePointer = _imageData.texturePointer;\
    _global.__batchTextureIndex   = _imageData.textureIndex;\
}



#macro __CARDBOARD_SPRITE_COMMON_UVS ;\
;\ //Cache the UVs for speeeeeeeed
var _u0 = _imageData.u0;\
var _v0 = _imageData.v0;\
var _u1 = _imageData.u1;\
var _v1 = _imageData.v1;