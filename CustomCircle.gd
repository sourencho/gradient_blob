@tool
extends MeshInstance2D

@export var num_segments = 32
@export var radius : float = 100.0


func _ready():
    var vertices = PackedVector2Array()
    var indices = PackedInt32Array()
    var uvs = PackedVector2Array()

    var angle_increment = 2 * PI / num_segments

    for i in range(num_segments*2):
        var x
        var y
        if i%2 == 1:
            x = 0
            y = 0
        else:
            x = radius * cos(i*2. * angle_increment)
            y = radius * sin(i*2. * angle_increment)

        vertices.append(Vector2(x, y))
        indices.append(i)
        uvs.append(Vector2((x+radius)/(radius*2.),(y+radius)/(radius*2.)))

    var surface_array = []
    surface_array.resize(Mesh.ARRAY_MAX)

    # Assign arrays to surface array.
    surface_array[Mesh.ARRAY_VERTEX] = vertices
    surface_array[Mesh.ARRAY_INDEX] = indices
    surface_array[Mesh.ARRAY_TEX_UV] = uvs


    var arr_mesh = ArrayMesh.new()
    arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
    mesh = arr_mesh
