using Convex
using Convex: DotMultiplyAtom
using Test
using SDPA_GMP
using MathOptInterface
using Random
const MOI = MathOptInterface
using GenericLinearAlgebra
using LinearAlgebra
import Random.shuffle
import Statistics.mean

TOL = 1e-3
eye(n) = Matrix(1.0I, n, n)

# Seed random number stream to improve test reliability
Random.seed!(2)

solvers = Any[]

push!(solvers, SDPA_GMP.Optimizer{BigFloat}(presolve = false, silent = true))

# If Gurobi is installed, uncomment to test with it:
#using Gurobi
#push!(solvers, GurobiSolver(OutputFlag=0))

# If Mosek is installed, uncomment to test with it:
#using Mosek
#push!(solvers, MosekSolver(LOG=0))

@testset "Convex" begin
    include(joinpath("Convex", "test_utilities.jl"))
    include(joinpath("Convex", "test_const.jl"))
    include(joinpath("Convex", "test_affine.jl"))
    include(joinpath("Convex", "test_lp.jl"))
    solvers[1] = SDPA_GMP.Optimizer{BigFloat}(silent = true)
    include(joinpath("Convex", "test_socp.jl"))
    include(joinpath("Convex", "test_sdp.jl"))
    # include(joinpath("Convex", "test_exp.jl")
    # include(joinpath("Convex", "test_sdp_and_exp.jl")
    # include(joinpath("Convex", "test_mip.jl")
end