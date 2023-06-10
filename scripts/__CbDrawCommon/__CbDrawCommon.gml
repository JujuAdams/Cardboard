#macro __CB_INDEX  if (CB_WRITE_NORMALS)\
                   {\
                       var _indexInteger = _global.__indexInteger + __CB_INDEX_INCREMENT;\
                       _global.__indexInteger = _indexInteger;\
                   }

#macro __CB_FORCE_SUBMIT_CONDITION  if (!_global.__batch.__auto && (_global.__model == undefined)) CbBatchForceSubmit();

#macro __CB_WRITE_INDEX  vertex_color(_vertexBuffer, _indexInteger, 1);