function CbBillboardMatrixGet(_x, _y, _z)
{
    __CB_GLOBAL
    
    return matrix_build(_x, _y, _z,   90, 0, _global.__billboard.__yaw,   1, 1, 1);
}