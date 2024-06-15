CbDoubleSidedSet(false);

model = CbModelCreate();
CbModelOpen(model);
CbTilemapConstruct("Tiles_1");
CbModelClose();

layer_destroy("Tiles_1");