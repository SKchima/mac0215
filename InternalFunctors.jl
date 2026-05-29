using Combinatorics
include("InternalRings.jl")

struct VertexTrivialIR end

function (ϕ::VertexTrivialIR)(G::SymmetricGraph)
    V = parts(G, :V)

    RE_underlying = FinSet(V)
    RE_elements = [FinSet(Base.collect(s)) for s in powerset(1:length(V))]
    RE = BooleanRing(RE_underlying, RE_elements)
    RV = BooleanRing(FinSet(0), [FinSet(0)])

    src = _ -> FinSet(0)
    tgt = _ -> FinSet(0)

    return InternalBooleanRing(RE, RV, src, tgt)
end

function (ϕ::VertexTrivialIR)(f::ACSetTransformation)
    G = dom(f)
    H = codom(f)
    ϕG = ϕ(G)
    ϕH = ϕ(H)

    fV = f[:V]
    GV = 1:length(parts(G, :V))

    efunc = ϕHe -> FinSet(findall(Gv -> (fV(Gv) in ϕHe), GV))
    vfunc = _ -> FinSet(0)

    return InternalBooleanMorphism(efunc, vfunc, ϕH, ϕG)
end

struct ForgetfulFunctor end

function (F::ForgetfulFunctor)(R::InternalBooleanRing)
    GR = SymmetricGraph(length(R.RV.elements))

    for Re in R.RE.elements
        s = R.src(Re)
        t = R.tgt(Re)

        sid = findfirst(==(s), R.RV.elements)
        tid = findfirst(==(t), R.RV.elements)

        add_edge!(GR, sid, tid)
    end

    return GR
end
