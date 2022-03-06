/// @param model

function CardboardModelDelete(_model)
{
    var _vertexBuffer = _model.vertexBuffer;
    if (_vertexBuffer == undefined) return;
    
    vertex_delete_buffer(_vertexBuffer);
    _model.vertexBuffer = undefined;
}