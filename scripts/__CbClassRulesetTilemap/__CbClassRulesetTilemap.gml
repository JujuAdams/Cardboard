function __CbClassRulesetTilemap(_tileset) constructor
{
    __tilesetIndex = _tileset;
    
    var _tilesetData = __CbGetTileset(_tileset);
    __tileWidth     = _tilesetData.__tileWidth;
    __tileHeight    = _tilesetData.__tileHeight;
    __tilesetWidth  = _tilesetData.__tilesetWidth;
    __tilesetHeight = _tilesetData.__tilesetHeight;
    
    __dictionary = {};
    
    __removeLeft   = false;
    __removeRight  = false;
    __removeUp     = false;
    __removeBottom = false;
    
    
    
    static RemoveLeft = function(_state)
    {
        __removeLeft = _state;
        return self;
    }
    
    static RemoveRight = function(_state)
    {
        __removeRight = _state;
        return self;
    }
    
    static RemoveUp = function(_state)
    {
        __removeUp = _state;
        return self;
    }
    
    static RemoveBottom = function(_state)
    {
        __removeBottom = _state;
        return self;
    }
    
    
    
    static RemapBasic = function(_x, _y, _xNew, _yNew)
    {
        __dictionary[$ _x + __tilesetWidth*_y] = [
                                                    _xNew, _yNew, //Left
                                                    _xNew, _yNew, //Right
                                                    _xNew, _yNew, //Up
                                                    _xNew, _yNew, //Down
                                                    _xNew, _yNew, //Below
                                                    _xNew, _yNew, //Above
                                                 ];
        show_debug_message("!");
        return self;
    }
    
    static RemapEdgeAbove = function(_x, _y, _xEdge, _yEdge, _xAbove, _yAbove)
    {
        __dictionary[$ _x + __tilesetWidth*_y] = [
                                                    _xEdge,  _yEdge,  //Left
                                                    _xEdge,  _yEdge,  //Right
                                                    _xEdge,  _yEdge,  //Up
                                                    _xEdge,  _yEdge,  //Down
                                                    _xEdge,  _yEdge,  //Below
                                                    _xAbove, _yAbove, //Above
                                                 ];
        return self;
    }
    
    static RemapAll = function(_x, _y, _xLeft, _yLeft, _xRight, _yRight, _xUp, _yUp, _xDown, _yDown, _xBelow, _yBelow, _xAbove, _yAbove)
    {
        __dictionary[$ _x + __tilesetWidth*_y] = [
                                                    _xLeft,  _yLeft,  //Left
                                                    _xRight, _yRight, //Right
                                                    _xUp,    _yUp,    //Up
                                                    _xDown,  _yDown,  //Down
                                                    _xBelow, _yBelow, //Below
                                                    _xAbove, _yAbove, //Above
                                                 ];
        return self;
    }
}