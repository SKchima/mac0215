using Catlab
using GraphViz

function exp(G::SymmetricGraph, H::SymmetricGraph)
    homs = homomorphisms(H, G)
    exponential = SymmetricGraph(length(homs))

    for i in eachindex(homs), j in eachindex(homs)
        a = homs[i]
        b = homs[j]
        flag = true

        for edge in parts(H, :E)
            x = subpart(H, edge, :src)
            y = subpart(H, edge, :tgt)
            ax = a[:V](x)
            by = b[:V](y)
            if !has_edge(G, ax, by)
                flag = false
                break
            end
        end
        if flag
            add_edge!(exponential, i, j)
        end
    end

    correspondence = Vector{Vector{Int64}}(undef, length(homs))
    for i in eachindex(homs)
        hom = homs[i]
        correspondence[i] = Base.collect(hom[:V])
    end

    return exponential, correspondence
end
