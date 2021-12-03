


binaries = [[0, 0, 1, 0, 0],
            [1, 1, 1, 1, 0],
            [1, 0, 1, 1, 0],
            [1, 0, 1, 1, 1],
            [1, 0, 1, 0, 1],
            [0, 1, 1, 1, 1],
            [0, 0, 1, 1, 1],
            [1, 1, 1, 0, 0],
            [1, 0, 0, 0, 0],
            [1, 1, 0, 0, 1],
            [0, 0, 0, 1, 0],
            [0, 1, 0, 1, 0]]

function getbinaries()
    binaries = Vector[]
    open("inputs/day3.txt") do file
        for line in eachline(file)
            line_bin = Int64[]
            for bit in line
                push!(line_bin, parse(Int64, bit))
            end
            push!(binaries, line_bin)
        end
    end
    binaries
end

function not(x)
    if x == 1
        return 0
    end
    return 1
end

function toint(x)
    res = 0
    for i in 1:length(x)
        res += x[i] * 2^((length(x) - i))
    end
    res
end

function partone(binaries)
    γ_bin = Int[]
    for i in 1:length(binaries[1])
        zeros = 0
        ones = 1
        for bin in binaries
            if bin[i] == 1
                ones += 1
            else
                zeros += 1
            end
        end
        if zeros > ones
            push!(γ_bin, 0)
        else
            push!(γ_bin, 1)
        end
    end
    ϵ_bin = map(not, γ_bin)
    println(γ_bin, toint(γ_bin))
    println(ϵ_bin, toint(ϵ_bin))
    println(toint(γ_bin) * toint(ϵ_bin))
end

function drop(binaries, position, value)
    newbin = []
    for bin in binaries
        if bin[position] == value
            push!(newbin, bin)
        end
    end
    newbin
end

function parttwo(binaries) 
    O₂_rate = Int[]
    CO₂_rate = Int[]
    
    O₂_list = copy(binaries)
    for position in 1:length(binaries[1])
        zeros = 0
        ones = 0
        for bin in O₂_list 
            if bin[position] == 1
                ones += 1
            else
                zeros += 1
            end
        end
        if ones >= zeros
            O₂_list = drop(O₂_list, position, 1)
        else
            O₂_list = drop(O₂_list, position, 0)
        end
        if length(O₂_list) == 1
            O₂_rate = O₂_list[1]
        end
    end

    CO₂_list = copy(binaries)
    for position in 1:length(binaries[1])
        zeros = 0
        ones = 0
        for bin in CO₂_list
            if bin[position] == 1
                ones += 1
            else
                zeros += 1
            end
        end
        if zeros <= ones 
            CO₂_list = drop(CO₂_list, position, 0)
        else
            CO₂_list = drop(CO₂_list, position, 1)
        end
        if length(CO₂_list) == 1
            CO₂_rate = CO₂_list[1]
        end
    end

    println(O₂_rate, toint(O₂_rate))
    println(CO₂_rate, toint(CO₂_rate))
    println(toint(O₂_rate) * toint(CO₂_rate))
end

partone(binaries)
parttwo(binaries)
println("--------")
partone(getbinaries())
parttwo(getbinaries())
