function CardboardBillboardMatrixGet(_x, _y, _z)
{
    __CARDBOARD_GLOBAL
    
    return matrix_build(_x, _y, _z,   90, 0, _global.__billboardYaw,   1, 1, 1);
}