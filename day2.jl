#=Day 2: Dive!=#


commands = [("forward", 5),
            ("down", 5),
            ("forward", 8),
            ("up", 3),
            ("down", 8),
            ("forward", 2)]

function getcommands()
    commands = []
    open("inputs/day2.txt") do file 
        for line in eachline(file)
            dataline = split(line, " ")
            instruction = dataline[1]
            steps = parse(Int64, dataline[2])
            push!(commands, (instruction, steps))
        end
    end
    commands
end

function partone(commands)
    horizontal = 0
    depth = 0

    for command in commands
        instruction, steps = command
        if instruction == "forward"
            horizontal += steps
        elseif instruction == "up"
            depth -= steps
        elseif instruction == "down"
            depth += steps
        end
    end
    println(horizontal * depth)
end

function parttwo(commands)
    horizontal = 0
    depth = 0
    aim = 0

    for command in commands
        instruction, steps = command
        if instruction == "forward"
            horizontal += steps 
            depth += aim * steps
        elseif instruction == "up"
            aim -= steps    
        elseif instruction == "down"
            aim += steps
        end
    end
    println(horizontal * depth)
end

partone(commands)
parttwo(commands)

commands = getcommands()

partone(commands)
parttwo(commands)
