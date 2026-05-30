using Test
include("Problems.jl")

@testset "Preimage inside the VertexTrivialIR functor" begin
    G = SymmetricGraph(2)
    H = SymmetricGraph(1)
    f = ACSetTransformation(G, H, V=[1, 1])

    ϕ = VertexTrivialIR()
    ϕf = ϕ(f)

    S_H = FinSet([1])
    @test Base.collect(ϕf.emap(S_H)) == [1, 2]
end

@testset "Forgetful Functor for VertexTrivialIR" begin
    G = SymmetricGraph(2)
    ϕ = VertexTrivialIR()
    R = ϕ(G)

    F = ForgetfulFunctor()
    G_res = F(R)

    @test length(parts(G_res, :V)) == 1

    @test length(parts(G_res, :E)) == 8

    @test all(Base.collect(G_res[:src]) .== 1)
    @test all(Base.collect(G_res[:tgt]) .== 1)
end

# Categorical verification tests
###############################################################################

@testset "ACSetTransformation naturality" begin

    G3 = SymmetricGraph(3)
    g = ACSetTransformation(G3, H, V=[1, 1, 1])
    @test is_natural(g)

    A = SymmetricGraph(3)
    add_edges!(A, [1, 2], [2, 3])
    B = SymmetricGraph(2)
    add_edges!(B, [1], [2])

    h_good = ACSetTransformation(A, B, V=[1, 2, 1], E=[1, 2, 2, 1])
    @test is_natural(h_good)

    h_bad = ACSetTransformation(A, B, V=[1, 2, 1], E=[2, 1, 2, 1])
    @test !is_natural(h_bad)
end


@testset "VertexTrivialIR is a valid Internal Ring" begin
    G = SymmetricGraph(3)
    add_edges!(G, [1, 2], [2, 3])

    ϕ = VertexTrivialIR()
    R = ϕ(G)

    for Re in R.RE.elements
        @test R.src(Re) in R.RV.elements
        @test R.tgt(Re) in R.RV.elements
    end
end

@testset "VertexTrivialIR functoriality (composition)" begin
    SGrph = ACSetCategory(SymmetricGraph())

    G = SymmetricGraph(3)
    H = SymmetricGraph(2)
    K = SymmetricGraph(1)

    f = ACSetTransformation(G, H, V=[1, 2, 1])
    g = ACSetTransformation(H, K, V=[1, 1])
    @test is_natural(f)
    @test is_natural(g)

    gf = compose[SGrph](f, g)  # g ∘ f

    ϕ = VertexTrivialIR()
    ϕf = ϕ(f)
    ϕg = ϕ(g)
    ϕgf = ϕ(gf)

    # ϕ is contravariant: ϕ(g∘f).emap == ϕ(f).emap ∘ ϕ(g).emap
    for el in ϕ(K).RE.elements
        via_composition = ϕf.emap(ϕg.emap(el))
        via_direct = ϕgf.emap(el)
        @test Set(Base.collect(via_composition)) == Set(Base.collect(via_direct))
    end
end

@testset "VertexTrivialIR functoriality (identity)" begin
    SGrph = ACSetCategory(SymmetricGraph())
    G = SymmetricGraph(2)
    id_G = id[SGrph](G)

    ϕ = VertexTrivialIR()
    ϕid = ϕ(id_G)

    # ϕ(id_G) must act as identity on RE elements
    for el in ϕ(G).RE.elements
        @test Set(Base.collect(ϕid.emap(el))) == Set(Base.collect(el))
    end
end

@testset "BooleanRing axioms" begin
    R = BooleanRing(FinSet(3), [FinSet(Base.collect(s)) for s in powerset(1:3)])

    # Helper: compare as sets (no order)
    ≅(x, y) = Set(Base.collect(x)) == Set(Base.collect(y))

    # Commutativity of +
    for a in R.elements, b in R.elements
        @test symdiff(a, b) ≅ symdiff(b, a)
    end

    # Commutativity of *
    for a in R.elements, b in R.elements
        @test intersect(a, b) ≅ intersect(b, a)
    end

    # Idempotence: a * a == a
    for a in R.elements
        @test intersect(a, a) ≅ a
    end

    # Zero: a + 0 == a
    for a in R.elements
        @test symdiff(a, FinSet(0)) ≅ a
    end

    # One: a * 1 == a
    for a in R.elements
        @test intersect(a, R.underlying) ≅ a
    end
end

# @testset "DominatingSet implementation" begin
#     G = SymmetricGraph(2)
#     add_edges!(G, [1], [2])
#
#     P = DominatingSet(1)
#     @test P(G)
# end
