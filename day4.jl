# Day 4 - 
using LinearAlgebra

function parseboard(board_string)
    board = zeros(Int, (5, 5))
    rows = split(board_string, r"(?!^)\n+(?!$)")
    
    for i = 1:5
        cols = split(rows[i], r"(?!^)\s+(?!$)")
        for j = 1:5
            board[i, j] = parse(Int, cols[j])
        end
    end
    board
end

function loadinput(filename = "inputs/day4.txt")
    cards = []
    boards = []
    open(filename) do file
        cards = parse.(Int, split(readline(file), ","))
        readline(file)
        boards_strings = split(read(file, String), "\n\n")
        boards = parseboard.(boards_strings)
    end

    cards, boards
end

function findcard(board, card)
    for i in 1:5
        for j in 1:5
            if board[i, j] == card
                return true, (i, j)
            end
        end
    end
    false, (0, 0)
end


function isbingo(board, marks)
    colscheck = sum(marks, dims=1)
    rowscheck = sum(marks, dims=2)
    for n = 1:5
        if colscheck[n] == 5 || rowscheck[n] == 5 
            return true,copy(board) ⋅ map(!, copy(marks))
        end
    end
    false, 0
end


function playboard(board, cards)
    marks = zeros(Bool, (5, 5))
    for n = 1:length(cards)
        card = cards[n]
        res, pos = findcard(board, card)
        if res
            marks[pos...] = true            
            isbingores, sum = isbingo(board, marks)
            if isbingores
                return n, sum * card 
            end
        end
    end
    return 0, 0
end

"""Figure out what board wins"""
function part1(cards, boards)
    best_score = Inf 
    best_board = Matrix{Int}(undef, 5, 5)
    best_result = 0
    for board in boards
        score, result = playboard(board, cards)
        if score < best_score
            best_score = score
            best_board = board
            best_result = result
        end
    end
    println(best_result)
end

"""Figure out what board wins last"""
function part2(cards, boards)
    worst_score = 0
    worst_board = zeros(Int, (5, 5))
    worst_result = 0
    for board in boards
        score, result = playboard(board, cards)
        if score > worst_score
            worst_score = score
            worst_board = board
            worst_result = result
        end
    end
    println(worst_result)
end



cards, boards = loadinput("inputs/dayexample4.txt")
part1(cards, boards)
part2(cards, boards)

cards, boards = loadinput()
part1(cards, boards)
part2(cards, boards)
