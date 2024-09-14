using Dates

function solution(startyear=1901, endyear=2000)
    count(Date(y, m, 1) for y in startyear:endyear, m in 1:12) do date
        dayofweek(date) == 7
    end
end

println(solution())
