include("download_input.jl")
using .WebInput

get_input() = parse_input(get_web_input("https://projecteuler.net/resources/documents/0059_cipher.txt"))

function parse_input(raw_input)
    parse.(UInt8, split(raw_input, ','))
end

function decode(key, msg)
    byte_pairs = Iterators.flatmap(zip, 
                                   Iterators.repeated(key), 
                                   Iterators.partition(msg, length(key))
                                  )
    map(byte_pairs) do (kbyte, msgbyte)
        xor(kbyte, msgbyte)
    end
end

function solution(input = get_input())
    key_lenth = 3
    kbytes = UInt8('a'):UInt8('z')

    key = argmax(Iterators.product(ntuple(_->kbytes, key_lenth)...)) do candkey
        cand_message = decode(candkey, input)
        count(cand_message) do c
            isletter(Char(c)) || Char(c) in ",'. !?"
        end
    end

    # String(decode(key, input))
    return sum(decode(key, input))
end

println(solution())
