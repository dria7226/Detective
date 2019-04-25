var test = create_identity(["Objects/office_lamp", VBO]);

test[VBO].lod[0] = vertex_create_buffer_from_buffer(test[Model].lod[0], Game.format);

for(var i = 0; i < 10; i++)
{
    for(var j = 0; j < 10; j++)
    {
        var identity = create_identity([VBO, Position]);

        identity[VBO].lod[0] = test[VBO].lod[0];

        change_position(identity, CHANGE_SET, [i,j,0]);

        ADD_IDENTITY_TO_VISIBLES(identity)
    }
}
