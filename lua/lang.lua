--[[
Written with Lua++.
Don't remove this notice please

https://github.com/LuaPlusPlus/lua-plus-plus
]]--
LANG = {}
LANG.__index = LANG
function LANG.new(s)
	local self = {}
	setmetatable(self, LANG)

	if not file.IsDir('gms_addons/languages', 'DATA') then
            file.CreateDir('gms_addons/languages')
        end
        self.Lang = {}
	return self
end
function LANG:Path()
        if not self.path then
            self.path = 'gms_addons/languages/'..self:getTeam()..'/'..self:getAddon()..'/'
        end
        return self.path
    end
function LANG:Download(callback)
        if not file.IsDir(self:Path(), 'DATA') then
            file.CreateDir(self:Path())
        end

        local url = 'https://raw.githubusercontent.com/Upgration/Languages/master/lang/'..string.lower(self:getTeam())..'/'..string.lower(self:getAddon())..'/'..string.lower(self:getLang())..'.json'
        http.Fetch(url, function(body, size, headers, code)
            local tbl = util.JSONToTable(body)
            if not tbl then
                return print('Unable to decode JSON')
            end 

            file.Write(self:Path()..self:getLang()..'.json', body)
            self:CacheLang()
            callback()
        end)
    end
function LANG:CacheLang()
        local files, _ = file.Find(self:Path()..'*.json', 'DATA')
        for k,v in pairs(files) do
            local locale = string.Split(v, '.')[1]

            if locale == nil then return end
            self.Lang[locale] = util.JSONToTable(file.Read(self:Path()..v, 'DATA'))
        end
    end
function LANG:GetPhrase(phrase, fallback)     
        local data = phrase:Split(".")
        local res = self.Lang[self:getLang()]['phrases']
        for k,v in ipairs(data) do
            if res[v] == nil then return fallback end
            res = res[v]
        end
        return res
    end
function LANG:Transfer(tbl, lang)
        file.Write(lang..'.txt', utf8.char( utf8.codepoint( util.TableToJSON(tbl, true), 1, string.len( util.TableToJSON( tbl, true) ) ) ) )
    end
function LANG:getLang()
	return self.lang
end
function LANG:setLang(obj)
	self.lang = obj
end
function LANG:getAddon()
	return self.addon
end
function LANG:setAddon(obj)
	self.addon = obj
end
function LANG:getTeam()
	return self.team
end
function LANG:setTeam(obj)
	self.team = obj
end
hook.Add('InitializeLanguage', 'teststest', function()
    print('tseting this shit from tom')
end)
local l = LANG.new('s')
l:setLang('english')
l:setTeam('XeNiN')
l:setAddon('BaTtLePaSs')
l:Download(function() 
    hook.Run('InitializeLanguage')
    print('gello')
end)