using Catlab
using GATlab
using GATlab.Stdlib
using GATlab.Models

struct BooleanRing
    underlying::FinSet
    elements::Vector{FinSet}
end

@instance ThRing{FinSet} [model::BooleanRing] begin
    +(x::FinSet, y::FinSet) = symdiff(x, y)
    *(x::FinSet, y::FinSet) = intersect(x, y)
    -(x::FinSet) = x
    zero() = FinSet(0)
    one() = model.underlying
end
