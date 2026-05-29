include("Rings.jl")

struct InternalBooleanRing
    RE::BooleanRing
    RV::BooleanRing
    src::Function
    tgt::Function
end

struct InternalBooleanMorphism
    emap::Function
    vmap::Function
    dom::InternalBooleanRing
    codom::InternalBooleanRing
end
