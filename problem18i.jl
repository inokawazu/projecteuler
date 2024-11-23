include("common.jl")

function getprimes(lb, hb)
    nums = lb:hb
    num_groups = Iterators.partition(nums, length(nums) ÷ Threads.nthreads())
    tsks = map(num_groups) do tnums
        Threads.@spawn(filter(isprime, tnums))
    end
    sort!(mapreduce(fetch, vcat, tsks))
end

function R(p::T) where {T}
    if all(0:p-1) do x
        mod(powermod(x, 3, p) - 3x + 4, p) != 0
    end
        return T(18) * im
    else
        return zero(T) * im
    end
    # Rp = one(p)
    # for x in 0:(p-1)
    #     # Rp *= mod(mod(x^3, p) - mod(3x, p) + 4, p)
    #     Rp *= mod(powermod(x, 3, p) - mod(3x, p) + 4, p)
    #     Rp = mod(Rp, p)
    #     if iszero(Rp)
    #         break
    #     end
    # end
    # # if !iszero(Rp)
    # #     @show Int(p), Int(Rp)
    # # end
    # return Rp
    # mapreduce((x, y) -> mod(x * y, p), 0:(p-1)) do x
    # mod(x^3 - 3x + 4, p)
    # mod(powermod(x, 3, p) - mod(3x, p) + 4, p)
    # end
end

function factor(m::T) where T
    facts = Dict{T, Int}()
    for i in 2:isqrt(m)
        while mod(m, i) == 0
            facts[i] = get(facts, i, 0) + 1
            m ÷= i
        end
        if abs(m) == 1
            break
        end
    end

    if abs(m) != 1
        @assert !haskey(facts, m)
        facts[m] = 1
        m ÷= m
    end

    return facts
end

function factors(n)
    f = [one(n)]
    for (p,e) in factor(n)
        f = reduce(vcat, [f*p^j for j in 1:e], init=f)
    end
    return length(f) == 1 ? [one(n), n] : sort!(f)
end

# function factors(n::Integer)
#     @assert n > 0 "n = $n"
#     Iterators.flatmap(1:isqrt(n)) do i
#         d, r = divrem(n, i)
#         if r != 0 || isone(n)
#             tuple()
#         elseif i == d || isone(i)
#             (i,)
#         else
#             (i, d)
#         end
#     end
# end

function Rslow(p)
    mapreduce((x, y) -> mod(x * y, p), 0:(p-1)) do x
        mod(powermod(x, 3, p) - mod(3x, p) + 4, p)
    end
end

# # display(getprimes(1_000_000_000, 1_100_000_000))

function striptwos(q)
    while iseven(q)
        q ÷= 2
    end
    return 2
end

function isalldivthrees(q)
    while mod(q, 3) == 0
        q ÷= 3
    end

    return abs(q) == 1
end

function isirreducible(q)
    q = striptwos(q)
    @show q - 1
    @show q + 1
    # isalldivthrees(q - 1) || isalldivthrees(q + 1)
    @show mod(q - 1, 3) == 0
    @show mod(q + 1, 3) == 0
    @show mod(q - 1, 3) == 0 || mod(q + 1, 3) == 0
end

function solution(limits=(1_000_000_000, 1_100_000_000))
    primes = getprimes(limits...)

    # outs = UInt128[]
    # for x in 0:UInt128(maximum(primes)-1)
    #     # @show Int(x)
    #     out = x^3 - 3x + 4
    #     push!(outs, out)
    #     factinds = findall(primes) do p
    #         0 < x < p && iszero(mod(x, p))
    #     end
    #     if !isempty(factinds)
    #         @info "Deleting $(length(factinds)) primes for x = $x"
    #     end
    #     deleteat!(primes, factinds)
    # end

    # @info "Found $(length(primes)) primes"
    # pgroups = Iterators.partition(primes, length(primes) ÷ Threads.nthreads())
    # tsks = map(pgroups) do pgroup
    #     Threads.@spawn begin
    #         sum(R, pgroup)
    #         # sum(x -> @show(@time((R ∘ big)(x))), pgroup)
    #         # sum(pgroup) do p
    #         #     @time R(p)
    #         # end
    #         # sum(R ∘ , pgroup)
    #     end
    # end
    # return sum(fetch, tsks)

    # @info "Found $(length(primes)) primes"
    # pgroups = Iterators.partition(primes, length(primes) ÷ Threads.nthreads())
    # tsks = map(pgroups) do pgroup
    #     Threads.@spawn begin
    #         sum(R, pgroup)
    #     end
    # end
    # return sum(fetch, tsks)
end

# println(solution())

# function polynomial_division(dividend::Vector{T}, divisor::Vector{T}) where T
#     # Ensure divisor is not the zero polynomial
#     if all(iszero, divisor)
#         throw(ArgumentError("Divisor cannot be the zero polynomial."))
#     end

#     # Remove trailing zeros from the divisor to get its degree
#     while divisor[end] == 0.0
#         pop!(divisor)
#     end
#     divisor_degree = length(divisor) - 1

#     # Initialize quotient and remainder
#     quotient = zeros(Float64, length(dividend) - length(divisor) + 1)
#     remainder = copy(dividend)

#     # Perform the division
#     while length(remainder) >= length(divisor)
#         # Degree of current remainder
#         remainder_degree = length(remainder) - 1

#         # Calculate leading term of the quotient
#         leading_coefficient = remainder[end] / divisor[end]
#         quotient[remainder_degree - divisor_degree + 1] = leading_coefficient

#         # Subtract the scaled divisor from the remainder
#         for i in 0:divisor_degree
#             remainder[remainder_degree - i + 1] -= leading_coefficient * divisor[divisor_degree - i + 1]
#         end

#         # Remove trailing zero (if any)
#         # pop!(remainder) while !isempty(remainder) && remainder[end] == 0.0
#     end

#     return quotient, remainder
# end

# # Example usage
# dividend = [1.0, -3.0, 2.0]  # Represents x^2 - 3x + 2
# divisor = [1.0, -1.0]        # Represents x - 1

# quotient, remainder = polynomial_division(dividend, divisor)

# println("Quotient: ", quotient)  # Expected: [1.0, -2.0] (represents x - 2)
# println("Remainder: ", remainder) # Expected: [0.0] (represents 0)

#function prstrip!(pa)
#    while length(pa) > 0 && iszero(pa[end])
#        pop!(pa)
#    end
#    return pa
#end

#function polynomial_add(p1, p2)
#    pa = similar(p1, max(length(p1), length(p2)))
#    pa .= 0
#    pa[1:length(p1)] .+= p1
#    pa[1:length(p2)] .+= p2
#    return prstrip!(pa)
#end

#deg(p1) = length(p1) - 1

#function xmul(p1, pow)
#    if isempty(p1)
#        return copy(p1)
#    end
#    pa = [p1; zeros(eltype(p1), pow)]
#    return circshift(pa, pow)
#end

#function polynomial_derivative(p1)
#    eltype(p1)[c * n for (n, c) in enumerate(p1[begin+1:end])]
#end

#function polynomial_divrem(p1, p2, p)
#    d = empty(p1)
#    while deg(p2) <= deg(p1)
#        lc = mod(invmod(p2[end], p) * p1[end], p)
#        deg_shift = deg(p1) - deg(p2)
#        tosub = mod.(-lc * xmul(p2, deg_shift), p)

#        p1 = polynomial_add(p1, tosub)
#        p1 = mod.(p1, p)
#        prstrip!(p1)
#        d = polynomial_add(d, xmul([lc], deg_shift))
#    end

#    return mod.(d, p), mod.(p1, p)
#end

#function polynomial_gcd(p1, p2, p)
#    a, b = deg(p1) >= deg(p2) ? (p1, p2) : (p2, p1)
#    @assert deg(a) >= deg(b)

#    if isempty(b) && isempty(a)
#        return eltype(p1)[]
#    elseif isempty(b)
#        return a
#    else
#        _, r = polynomial_divrem(a, b, p)
#        return polynomial_gcd(b, r, p)
#    end
#end

## Algorithm: SFF (Square-Free Factorization)
##     Input: A monic polynomial f in Fq[x] where q = pm
#function polynomial_factorize(f::T, p) where {T}
#    #     Output: Square-free factorization of f
#    #     R ← 1
#    R = T[]

#    #     # Make w be the product (without multiplicity) of all factors of f that have 
#    #     # multiplicity not divisible by p
#    #     c ← gcd(f, f′)
#    @show c = polynomial_gcd(f, polynomial_derivative(f), p)
#    #     w ← f/c 
#    w, _ = polynomial_divrem(f, c, p)

#    #     # Step 1: Identify all factors in w
#    #     i ← 1 
#    # i = 1
#    #     while w ≠ 1 do
#    while !(length(w) == 1 && all(isone, w))
#        #    y ← gcd(w, c)
#        y = polynomial_gcd(w, c, p)
#        #    fac ← w / y
#        fac, _ = polynomial_divrem(w, y, p)
#        #    R ← R · faci
#        push!(R, fac)
#        #    w ← y; c ← c / y; i ← i + 1 
#        #    i += 1
#        w = y
#        c, _ = polynomial_divrem(c, y, p)
#        #end while
#    end
#    #     # c is now the product (with multiplicity) of the remaining factors of f

#    #     # Step 2: Identify all remaining factors using recursion
#    #     # Note that these are the factors of f that have multiplicity divisible by p
#    #     if c ≠ 1 then
#    if !(length(c) == 1 && all(isone, c))
#        @info "c = $c has factors left."
#        # c ← c^(1/p)
#        # c = c1/p
#        # c, _ = polynomial_divrem(, y, p)
#        # R ← R·SFF(c)p
#        #     end if 
#    end

#    return R
#    #     Output(R)
#end

## function polygcd(p1, p2)
##     # p1 = vec(p1)
##     # p2 = vec(p2)

##     l1 = length(p1)
##     l2 = length(p2)
##     lm = max(l1, l2)

##     # p1 = [p1; fill(0, lm - l1)]
##     # p2 = [p2; fill(0, lm - l2)]

##     q = 0
##     r = l1 >= l2 ? p1 : p2
##     d = deg(l1 >= l2 ? p2 : p1)
##     # c = 
## end

## GPT STUFF ###################################3
##
## function gcd_polynomial(a::Vector{Int}, b::Vector{Int}, p::Int)
##     # Compute the GCD of two polynomials over F_p using the Euclidean algorithm
##     while !isempty(b) && any(x -> x != 0, b)
##         a, b = b, polynomial_mod(a, b, p)
##     end
##     return normalize_polynomial(a, p)
## end

## function polynomial_mod(a::Vector{Int}, b::Vector{Int}, p::Int)
##     # Compute the remainder when a is divided by b over F_p
##     a = normalize_polynomial(a, p)
##     b = normalize_polynomial(b, p)
##     while length(a) >= length(b)
##         factor = a[end] * invmod(b[end], p) % p
##         degree_diff = length(a) - length(b)
##         for i in eachindex(b)
##             a[degree_diff+i] = (a[degree_diff+i] - factor * b[i]) % p
##         end
##         while !isempty(a) && a[end] == 0
##             pop!(a)
##         end
##     end
##     return normalize_polynomial(a, p)
## end

## # function modinv(a::Int, p::Int)
## #     # Compute the modular inverse of a under modulo p
## #     x, _, g = gcdx(a, p)
## #     if g != 1
## #         throw(ArgumentError("No modular inverse exists."))
## #     end
## #     return mod(x, p)
## # end

## function normalize_polynomial(poly::Vector{Int}, p::Int)
##     # Ensure all coefficients are in the range 0 to p-1
##     return [x % p for x in poly]
## end

## function derivative_polynomial(poly::Vector{Int}, p::Int)
##     # Compute the derivative of the polynomial over F_p
##     derivative = [(i * poly[i+1]) % p for i in 1:length(poly)-1]
##     return normalize_polynomial(derivative, p)
## end

## function factorize_polynomial(poly::Vector{Int}, p::Int)
##     poly = normalize_polynomial(poly, p)
##     factors = []

##     # Check for and handle constant polynomials
##     if length(poly) <= 1
##         push!(factors, poly)
##         return factors
##     end

##     # Derivative to check for repeated roots
##     derivative = derivative_polynomial(poly, p)
##     g = gcd_polynomial(poly, derivative, p)

##     # If derivative is zero, handle separable polynomials
##     if length(g) > 1
##         repeat_factor = poly
##         while length(repeat_factor) > 1
##             repeat_factor = gcd_polynomial(repeat_factor, derivative, p)
##             push!(factors, repeat_factor)
##         end
##     else
##         # Factorize using trial division for irreducible factors
##         # (Basic version — can be optimized further for larger fields)
##         x_poly = [0, 1] # x in F_p[x]
##         for i in 0:p-1
##             test_poly = [(x_poly[end] + i) % p for _ in x_poly]
##             # Factorize using trial division for irreducible factors
##             # (Basic version — can be optimized further for larger fields)
##             x_poly = [0, 1]  # Represents x in F_p[x]
##             for i in 0:p-1
##                 # Test dividing by (x - i)
##                 test_poly = normalize_polynomial([-i, 1], p)  # (x - i) in F_p[x]
##                 while true
##                     remainder = polynomial_mod(poly, test_poly, p)
##                     if isempty(remainder) || all(x -> x == 0, remainder)
##                         # Test_poly is a factor
##                         poly = normalize_polynomial(poly, p)
##                         poly = normalize_polynomial(divide_polynomial(poly, test_poly, p), p)
##                         push!(factors, test_poly)
##                     else
##                         break
##                     end
##                 end
##             end
##         end
##     end

##     # If there's any remaining nonconstant polynomial, it must be irreducible
##     if length(poly) > 1
##         push!(factors, poly)
##     end

##     return factors
## end

## function divide_polynomial(a::Vector{Int}, b::Vector{Int}, p::Int)
##     # Perform polynomial division a / b over F_p and return the quotient
##     a = normalize_polynomial(a, p)
##     b = normalize_polynomial(b, p)
##     quotient = []
##     while length(a) >= length(b)
##         factor = a[end] * invmod(b[end], p) % p
##         degree_diff = length(a) - length(b)
##         push!(quotient, factor)
##         for i in eachindex(b)
##             a[degree_diff + i] = (a[degree_diff + i] - factor * b[i]) % p
##         end
##         while !isempty(a) && a[end] == 0
##             pop!(a)
##         end
##     end
##     return reverse(quotient)  # Ensure quotient is ordered correctly
## end

