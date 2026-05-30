using Test
include("exponentials.jl")

@testset "Exponential Function Tests" begin
    # Test Case 1: Simple paths
    # G: 1 -- 2
    G = SymmetricGraph(2)
    add_edge!(G, 1, 2)

    # H: 1 (Single node, no edges)
    H = SymmetricGraph(1)

    exponential, correspondence = exp(G, H)

    # If H has 1 node and 0 edges, there are 2 homomorphisms H -> G
    @test nparts(exponential, :V) == 2
    @test length(correspondence) == 2
    @test [1] in correspondence
    @test [2] in correspondence

    # Test Case 2: Exponential G^H where G and H are K2
    # G: 1 -- 2
    # H: 1 -- 2
    G2 = SymmetricGraph(2)
    add_edge!(G2, 1, 2)
    H2 = SymmetricGraph(2)
    add_edge!(H2, 1, 2)

    exp2, corr2 = exp(G2, H2)

    # There are 2 homs from K2 to K2: ID and Swap
    @test nparts(exp2, :V) == 2
    @test length(corr2) == 2
end
