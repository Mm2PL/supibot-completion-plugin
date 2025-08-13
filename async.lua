local async = {}

---Calls fun with arguments '...', sets up callbacks and yields.
---@param fun any A function with a signature like (arg0, arg1, ..., okcb, errcb): any
---@param ... any[] Arguments to the function
---@return any FunctionReturn Whatever the ok callback gives you
function async.lawait(fun, ...)
    local ok, val = async.plawait(fun, ...)
    if ok then
        return val
    else
        error(val)
    end
end

---@alias PCallReturn [boolean,any]

---Calls fun with arguments '...', sets up callbacks and yields. Protected variant.
---@param fun any A function with a signature like (arg0, arg1, ..., okcb, errcb): any
---@param ... any[] Arguments to the function
---@return PCallReturn Returns '[true, OkCallbackValue]' or '[false, ErrCallbackValue]'.
function async.plawait(fun, ...)
    local coro = coroutine.running()
    print('plawait begin')
    if #{ ... } == 0 then
        -- i hate this
        fun(
            function(...) -- ok
                coroutine.resume(coro, true, ...)
            end,
            function(...) -- err
                coroutine.resume(coro, false, ...)
            end
        )
    else
        fun(
            table.unpack({ ... }), -- i hate this
            function(...)          -- ok
                coroutine.resume(coro, true, ...)
            end,
            function(...) -- err
                coroutine.resume(coro, false, ...)
            end
        )
    end
    return coroutine.yield()
end

---Wraps the function fun such that every call will be created on a new coroutine
---@param fun function
---@return function
function async.asyncwrap(fun)
    return function(...)
        local temp = { ... };
        coroutine.resume(
            coroutine.create(function()
                return fun(table.unpack(temp))
            end)
        )
    end
end

return async
