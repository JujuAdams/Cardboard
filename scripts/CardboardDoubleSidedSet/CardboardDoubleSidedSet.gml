/// Sets the double-sided drawing state for Cardboard's sprites and surfaces
/// 
/// This feature is especially useful when drawing scenes with lighting to ensure both sides
/// of a sprite/surface are lit correctly
/// 
/// @param state  Whether to draw sprites/surfaces with two sides

function CardboardDoubleSidedSet(_state)
{
    __CARDBOARD_GLOBAL
    
    _global.__doubleSided = _state;
}