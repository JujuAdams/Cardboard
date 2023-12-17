// Feather disable all

function CbCameraFrustrumCoordsGet()
{
    __CB_GLOBAL_RENDER
    
    static _result = {
        tlNearX: 0,
        tlNearY: 0,
        tlNearZ: 0,
        trNearX: 0,
        trNearY: 0,
        trNearZ: 0,
        blNearX: 0,
        blNearY: 0,
        blNearZ: 0,
        brNearX: 0,
        brNearY: 0,
        brNearZ: 0,
        
        tlFarX: 0,
        tlFarY: 0,
        tlFarZ: 0,
        trFarX: 0,
        trFarY: 0,
        trFarZ: 0,
        blFarX: 0,
        blFarY: 0,
        blFarZ: 0,
        brFarX: 0,
        brFarY: 0,
        brFarZ: 0,
    };
    
    with(_global.__camera)
    {
        if (__orthographic)
        {
            _wNear = __width;
            _hNear = __height;
            _wFar  = __width;
            _hFar  = __height;
        }
        else
        {
            var _aspectRatio = __width / __height;
            var _hNear = 2*dtan(0.5*__fieldOfView)*__near;
            var _wNear = _aspectRatio*_hNear;
            var _hFar  = 2*dtan(0.5*__fieldOfView)*__far;
            var _wFar  = _aspectRatio*_hFar;
        }
        
        var _cameraUpX = __xUp;
        var _cameraUpY = __yUp;
        var _cameraUpZ = __zUp;
        var _d = 1 / sqrt(_cameraUpX*_cameraUpX + _cameraUpY*_cameraUpY + _cameraUpZ*_cameraUpZ);
        _cameraUpX *= _d;
        _cameraUpY *= _d;
        _cameraUpZ *= _d;
        
        var _cameraFrontX = __xTo - __xFrom;
        var _cameraFrontY = __yTo - __yFrom;
        var _cameraFrontZ = __zTo - __zFrom;
        var _d = 1 / sqrt(_cameraFrontX*_cameraFrontX + _cameraFrontY*_cameraFrontY + _cameraFrontZ*_cameraFrontZ);
        _cameraFrontX *= _d;
        _cameraFrontY *= _d;
        _cameraFrontZ *= _d;
        
        var _cameraRightX = _cameraFrontY*_cameraUpZ - _cameraFrontZ*_cameraUpY;
        var _cameraRightY = _cameraFrontZ*_cameraUpX - _cameraFrontX*_cameraUpZ;
        var _cameraRightZ = _cameraFrontX*_cameraUpY - _cameraFrontY*_cameraUpX;
        var _d = 1 / sqrt(_cameraRightX*_cameraRightX + _cameraRightY*_cameraRightY + _cameraRightZ*_cameraRightZ);
        _cameraRightX *= _d;
        _cameraRightY *= _d;
        _cameraRightZ *= _d;
        
        var _centreFarX  = __xFrom + __far*_cameraFrontX;
        var _centreFarY  = __yFrom + __far*_cameraFrontY;
        var _centreFarZ  = __zFrom + __far*_cameraFrontZ;
        
        var _centreNearX = __xFrom + __near*_cameraFrontX;
        var _centreNearY = __yFrom + __near*_cameraFrontY;
        var _centreNearZ = __zFrom + __near*_cameraFrontZ;
        
        //Divide down by two to save on division ops below
        _wNear /= 2;
        _hNear /= 2;
        _wFar  /= 2;
        _hFar  /= 2;
        
        with(_result)
        {
            //Pre-multiply to save on repeated ops
            _cameraUpX *= _hNear;
            _cameraUpY *= _hNear;
            _cameraUpZ *= _hNear;
            
            _cameraRightX *= _wNear;
            _cameraRightY *= _wNear;
            _cameraRightZ *= _wNear;
            
            //Top-left near
            tlNearX = _centreNearX + _cameraUpX - _cameraRightX;
            tlNearY = _centreNearY + _cameraUpY - _cameraRightY;
            tlNearZ = _centreNearZ + _cameraUpZ - _cameraRightZ;
            
            //Top-right near
            trNearX = _centreNearX + _cameraUpX + _cameraRightX;
            trNearY = _centreNearY + _cameraUpY + _cameraRightY;
            trNearZ = _centreNearZ + _cameraUpZ + _cameraRightZ;
            
            //Bottom-left near
            blNearX = _centreNearX - _cameraUpX - _cameraRightX;
            blNearY = _centreNearY - _cameraUpY - _cameraRightY;
            blNearZ = _centreNearZ - _cameraUpZ - _cameraRightZ;
            
            //Bottom-right near
            brNearX = _centreNearX - _cameraUpX + _cameraRightX;
            brNearY = _centreNearY - _cameraUpY + _cameraRightY;
            brNearZ = _centreNearZ - _cameraUpZ + _cameraRightZ;
            
            //Pre-multiply to save on repeated ops
            var _coeff = _hFar / _hNear;
            
            _cameraUpX *= _coeff;
            _cameraUpY *= _coeff;
            _cameraUpZ *= _coeff;
            
            _cameraRightX *= _coeff;
            _cameraRightY *= _coeff;
            _cameraRightZ *= _coeff;
            
            //Top-left far
            tlFarX = _centreFarX + _cameraUpX - _cameraRightX;
            tlFarY = _centreFarY + _cameraUpY - _cameraRightY;
            tlFarZ = _centreFarZ + _cameraUpZ - _cameraRightZ;
                                                             
            //Top-right far                                  
            trFarX = _centreFarX + _cameraUpX + _cameraRightX;
            trFarY = _centreFarY + _cameraUpY + _cameraRightY;
            trFarZ = _centreFarZ + _cameraUpZ + _cameraRightZ;
                                                             
            //Bottom-left far                                
            blFarX = _centreFarX - _cameraUpX - _cameraRightX;
            blFarY = _centreFarY - _cameraUpY - _cameraRightY;
            blFarZ = _centreFarZ - _cameraUpZ - _cameraRightZ;
                                                             
            //Bottom-right far                               
            brFarX = _centreFarX - _cameraUpX + _cameraRightX;
            brFarY = _centreFarY - _cameraUpY + _cameraRightY;
            brFarZ = _centreFarZ - _cameraUpZ + _cameraRightZ;
        }
    }
    
    return _result;
}