function __CbClassRulesetTilemap(_tileset) constructor
{
    __tilesetIndex = _tileset;
    
    var _tilesetData = __CbGetTileset(_tileset);
    __tileWidth     = _tilesetData.__tileWidth;
    __tileHeight    = _tilesetData.__tileHeight;
    __tilesetWidth  = _tilesetData.__tilesetWidth;
    __tilesetHeight = _tilesetData.__tilesetHeight;
    
    __dictionary = {};
    __bottomless = false;
    __backless   = false;
    __sideless   = false;
    
    
    
    static Bottomless = function(_state)
    {
        __bottomless = _state;
        return self;
    }
    
    static Backless = function(_state)
    {
        __backless = _state;
        return self;
    }
    
    static Sideless = function(_state)
    {
        __sideless = _state;
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
    
    static RemapTopDown = function(_x, _y, _xAbove, _yAbove, _xEdge, _yEdge)
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