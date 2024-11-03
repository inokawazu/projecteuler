include("download_input.jl")
include("common.jl")

using .WebInput

function get_intput()
    url = "https://projecteuler.net/project/resources/p096_sudoku.txt"
    rawdata = get_web_input(url)
    lines = split(rawdata, "\n", keepempty=false)
    map(Iterators.partition(lines, 10)) do board_lines
        map(Iterators.drop(board_lines, 1)) do board_line
            [parse(Int, c) for c in board_line]
        end |> stack |> transpose
    end
end

issolved(board) = all(!=(0), board) && isvalid(board)

function centers(board)
    (
     board[center+(CartesianIndex(-1, -1)):center+(CartesianIndex(1, 1))]
     for center in CartesianIndex(2, 2):CartesianIndex(3, 3):CartesianIndex(8, 8)
    )
end

function isvalid(board)
    board_slices = Iterators.flatten((centers(board), eachrow(board), eachcol(board)))
    all(board_slices) do board_slice
        all(1:9) do n
            count(==(n), board_slice) <= 1
        end
    end
end

function solve_board!(board, loc=firstindex(board))
    if issolved(board)
        return true
    end

    while checkbounds(Bool, board, loc) && !iszero(board[loc])
        loc = nextind(board, loc)
    end


    for n in 1:9
        board[loc] = n
        if isvalid(board) && solve_board!(board, loc)
            return true
        end
        board[loc] = 0
    end

    return false
end

function solution(boards = get_intput())
    sum(boards) do board
        @assert solve_board!(board)
        digs2num(board[1, 3:-1:1])
    end
end

println(solution())
