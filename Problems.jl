include("InternalFunctors.jl")
include("exponentials.jl")

struct DominatingSet
    k::Int
end

function (P::DominatingSet)(G::SymmetricGraph)
    K = SymmetricGraph(P.k)
    GK, correspondence = exp(G, K)

    ϕ = VertexTrivialIR()
    F = ForgetfulFunctor()
    RG = ϕ(G)
    GR = F(RG)

    # p = ACSetTransformation(GK, GR, V=[], E=[])
end
