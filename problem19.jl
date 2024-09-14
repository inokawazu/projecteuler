using Dates

isleap(y) = mod(y, 4) == 0 && (mod(y, 100) != 0 || mod(y, 400) == 0)
leapoffset(y) = isleap(y) ? 1 : 0

function solution()
    startyear = 1901
    endyear = 2000

    monthdays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    sundayoffset = 0
    nsundays = 0

    for year in startyear:endyear
        for (imonth, mdays) in enumerate(monthdays)
            nsundays += iszero(sundayoffset)

            sundayoffset += mdays
            if imonth == 2
                sundayoffset += leapoffset(year)
            end
            sundayoffset = mod(sundayoffset, 7)
        end
    end

    return nsundays
end

println(solution())
