var test = create_identity(["model_goes_here", VBO]);

test[VBO].lod[0] = vertex_create_buffer_from_buffer(test[Model].lod[0], Game.format);

ADD_IDENTITY_TO_VISIBLES(test)
