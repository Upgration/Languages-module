LANG.manager = LANG.Manager.new()

hook.Add("Think", "Lang.Language123", function()
    LANG.manager:runPrepared()
    hook.Remove("Think", "Lang.Language123")
end)

function LANG.prepareLang(lang)
    LANG.manager:prepareLang(lang)
end