--[[
Written with Lua++.
Don't remove this notice please

https://github.com/LuaPlusPlus/lua-plus-plus
]]--
LANG.Manager = {}
LANG.Manager.__index = LANG.Manager
function LANG.Manager.new(_)
	local self = {}
	setmetatable(self, LANG.Manager)

	self.pendingQueries = {}
        local returnedData = hook.Run("Language::Prepare")
        assert(returnedData == nil, "An addon returned a value on Language prepare. This will stop other addons loading languages.")
	return self
end
function LANG.Manager:runPrepared()
        for k,v in pairs(self.pendingQueries) do
            v:Exec()
        end
    end
function LANG.Manager:prepareLang(lang)
        self.pendingQueries[#self.pendingQueries+1] = lang
    end
function LANG.Manager:getPendingQueries()
	return self.pendingQueries
end