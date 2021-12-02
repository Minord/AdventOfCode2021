#=
#Day 1: Sonar Sweep
=#
#For test propourses
report = [199, 200, 208, 210,
          200, 207, 240, 269,
          260, 263]

function getreport()
    report = Int64[]
    open("inputs/day1.txt") do file
        for line in eachline(file)
            push!(report, parse(Int64, line))
        end
    end
    report
end

function partone(report)
    last_report = report[1]
    count_increase = 0

    for i in 2:length(report)
        if report[i] - last_report > 0
             count_increase += 1
        end
        last_report = report[i]
    end
    println(count_increase)    
end

function parttwo(report)
    last_report = sum(report[1:3])
    count_increase = 0
    for i in 2 : length(report) - 2
        if sum(report[i:i+2]) - last_report > 0
            count_increase += 1
        end
        last_report = sum(report[i:i+2])
    end
    println(count_increase)
end
partone(report)
parttwo(report)

report = getreport()

partone(report)
parttwo(report)
