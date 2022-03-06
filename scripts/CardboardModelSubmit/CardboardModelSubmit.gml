/// @param model

function CardboardModelSubmit(_model)
{
    var _vertexBuffer = _model.vertexBuffer;
    if (_vertexBuffer == undefined) return;
    
    vertex_submit(_vertexBuffer, pr_trianglelist, _model.texturePointer);
}