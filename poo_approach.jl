using Catlab
using GraphViz

################ INTERNAL RING IMPLEMENTATION ################

struct InternalRing
    graph::SymmetricGraph


    Esum::Function
    Eprod::Function
    whichEdge::Bijection
    Vsum::Function
    Vprod::Function
    whichVertex::Bijection
end

function (trivial_internal_ring::InternalRing)(base_graph::SymmetricGraph)
    vertices = parts(graph, :V)
    edges = parts(graph, :E)
    
    ring_graph = SymmetricGraph(1)

    

    function Vsum(x::Int, y::Int)
        
    end
    function Vprod(x::Int, y::Int)
        
    end
    function Esum(a::Int, b::Int)
        
    end
    function Eprod(a::Int, b::Int)
        
    end
    InternalRing(ring_graph, Vsum, Vprod, Esum, Eprod)
end

function (poly_internal_ring::InternalRing)(graph::SymmetricGraph)
end

################################



################ INSTANCES AND USE ################

G = SymmetricGraph(3)
add_edges!(G, [1, 2], [2, 3])
#TIR = 
#R = (G)




################################
