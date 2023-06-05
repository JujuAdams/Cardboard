#macro __CB_TILE_COMMON_TEXTURE ;\
var _tilesetData = __CbTilesetDataGet(_tileset);\
var _texture     = _tilesetData.__texture;\
;\
;\ //Break the batch if we've swapped texture
if (_texture != _global.__batch.__textureIndex)\
{\
    __CbBatchComplete();\
    _global.__batch.__texturePointer = _texture;\
    _global.__batch.__textureIndex   = undefined;\
}



#macro __CB_TILE_COMMON_UVS ;\
static _borderWidth  = 2;\
static _borderHeight = 2;\
;\
var _uvs           = _tilesetData.__UVs;\
var _tilesetU0     = _uvs[0];\
var _tilesetV0     = _uvs[1];\
var _tilesetU1     = _uvs[2];\
var _tilesetV1     = _uvs[3];\
var _tileWidth     = _tilesetData.__tileWidth;\
var _tileHeight    = _tilesetData.__tileHeight;\
var _tileWidthExt  = _tileWidth  + 2*_borderWidth;\
var _tileHeightExt = _tileHeight + 2*_borderHeight;\
var _textureWidth  = _tilesetData.__textureWidth;\
var _textureHeight = _tilesetData.__textureHeight;\
;\
;\ //Cache the UVs for speeeeeeeed
var _u0 = lerp(_tilesetU0, _tilesetU1, (_borderWidth  + _tileWidthExt *_tileX              ) / _textureWidth );\
var _v0 = lerp(_tilesetV0, _tilesetV1, (_borderHeight + _tileHeightExt*_tileY              ) / _textureHeight);\
var _u1 = lerp(_tilesetU0, _tilesetU1, (_borderWidth  + _tileWidthExt *_tileX + _tileWidth ) / _textureWidth );\
var _v1 = lerp(_tilesetV0, _tilesetV1, (_borderHeight + _tileHeightExt*_tileY + _tileHeight) / _textureHeight);