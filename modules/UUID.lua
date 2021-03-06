local _UUID = (function()
    math.randomseed(os.time())
    local random = math.random
    local module = {}

    module.generateUUID = function()
        local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
        return string.gsub(template, "[xy]", function (c)
            local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
            return string.format("%x", v)
        end)
    end

    return module
end)()

return _UUID