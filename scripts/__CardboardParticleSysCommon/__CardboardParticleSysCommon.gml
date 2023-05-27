#macro __CARDBOARD_PARTICLE_SYSTEM_COMMON_TEXTURE ;\
;\//Break the batch if we have anything pending
if (_global.__batchTexturePointer != undefined)\
{\
    CardboardBatchForceSubmit();\
}

#macro __CARDBOARD_PARTICLE_SYSTEM_DISABLE_LIGHTING ;\
if (_global.__lightingStarted)\
{\
    var _oldLighting = true;\
    CardboardLightingEnd();\
}\
else\
{\
    var _oldLighting = false;\
}

#macro __CARDBOARD_PARTICLE_SYSTEM_REENABLE_LIGHTING  if (_oldLighting) CardboardLightingStart();