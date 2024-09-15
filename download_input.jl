module WebInput

using Downloads

export get_web_input

function get_web_input(url)
    if iscached(url)
        @info "Getting cache from $(cachefile(url))"
        return cacheget(url)
    end

    triangleio = IOBuffer()
    Downloads.download(url, triangleio)
    output = String(take!(triangleio))
    write(cachefile(url), output)
    return output
end

cachedir() = joinpath(".", ".julia_euler_cache")
cachefile(url) = joinpath(cachedir(), basename(url))

function iscached(url)
    isdir(cachedir()) || mkdir(cachedir())
    fname = cachefile(url)
    return isfile(fname)
end

function cacheget(url)
    isdir(cachedir()) || mkdir(cachedir())
    fname = cachefile(url)
    return read(fname, String)
end

end
