#macro __CB_PARTICLE_SYSTEM_COMMON_TEXTURE ;\
;\//Break the batch if we have anything pending
if (_global.__batchTexturePointer != undefined)\
{\
    CbBatchForceSubmit();\
}