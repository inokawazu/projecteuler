# Solution from prettysg

function solution(klim)
  m = zeros(Int64, klim)
  vals = [1]

  depth = maximum([floor(Int, log(2, i)) + count_ones(i) for i in 2:klim]) - 1
  # @show depth

  function f(vals, level)
    level += 1
    level > depth && return
    for v in vals
      c = v + vals[end]
      c > klim && return

      if m[c] == 0
        m[c] = level
      else
        m[c] > level && (m[c] = level)
      end

      push!(vals, c)
      f(vals, level)
      pop!(vals)
    end

    return
  end

  f(vals, 0)
  return sum(m)
end

println(solution(200))
