LANG = {}
function LANG.LoadDirectory(dir)
    local fil, fol = file.Find(dir .. "/*", "LUA")
    for k,v in pairs(fol) do
        LANG.LoadDirectory(dir .. "/" .. v)
    end
    for k,v in ipairs(fil) do
        if v:EndsWith(".lpp") then continue end
        local dirs = dir .. "/" .. v
        -- Everything is shared in this project.
        AddCSLuaFile(dirs)
        include(dirs)
    end
end
LANG.LoadDirectory("lang")
print("__Loaded__ LANG.")