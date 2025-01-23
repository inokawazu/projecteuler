const POSITIONS = [
             tuple.(:s, 1:20); 
             tuple.(:d, 1:20); 
             tuple.(:t, 1:20); 
             (:s, 25); 
             (:d, 25);
             (:s, 0)
            ]

mult(sym) = if sym == :s
    1
elseif sym == :d
    2
elseif sym == :t
    3
else
    0
end

score((sym, num)) = mult(sym) * num

function solution(n = 100)

    cubed_positions = Iterators.product(POSITIONS, POSITIONS, POSITIONS)
    valid_positions = Iterators.filter(cubed_positions) do cubed_position
        sum(score, cubed_position) < n && cubed_position[3][1] == :d
    end
    
    unique(valid_positions) do cubed_position
        if isless(cubed_position[1], cubed_position[2])
            cubed_position
        else
            tuple(cubed_position[2], cubed_position[1], cubed_position[3])
        end
    end |> length
end

println(solution())
