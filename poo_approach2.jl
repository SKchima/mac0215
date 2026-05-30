using Catlab
using GraphViz

struct Ring
    set::Set
    sum::Function
    sum_neutral
    prod::Function
    prod_neutral

end

struct InternalRing
    graph::SymmetricGraph
    RV::Ring
    RE::Ring
end

function (trivial_internal_ring::InternalRing)(base_graph::SymmetricGraph)
    vertices = parts(graph, :V)
    edges = parts(graph, :E)

    ring_graph = SymmetricGraph(1)

    # functions

    function Vsum
    end
    function Vprod
    end

    ring_vertices = Ring(vertices)

    function Esum
    end
    function Eprod
    end

    ring_edges = Ring(edges)
    InternalRing(ring_graph, ring_vertices, ring_edges)
end

# e1 + e2 = e3
#
# e1 = a, b
#
# e2 = x, y
#
# e3 = g, h
#
# a + x = g
# b + y = h
