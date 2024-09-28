function solution(target = 5)
    nums = Iterators.countfrom(one(target))
    cubes = Iterators.map(x->x^3, nums)

    ndigs = 1
    while true
        nd_cubes = Iterators.dropwhile(c->ndigits(c) != ndigs, cubes)
        nd_cubes = collect(Iterators.takewhile(c->ndigits(c) == ndigs, nd_cubes))

        for cube in nd_cubes
            cube_perm_digs = (sort∘digits)(cube)

            nperms = count(nd_cubes) do other_cubs
                cube_perm_digs == (sort∘digits)(other_cubs)
            end

            if nperms == target
                return cube
            end
        end

        ndigs += 1
    end
end

println(solution())
