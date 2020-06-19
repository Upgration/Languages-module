--[[
Written with Lua++.
Don't remove this notice please

https://github.com/LuaPlusPlus/lua-plus-plus
]]--
LANG.Lang = {}
LANG.Lang.__index = LANG.Lang
function LANG.Lang.new(s)
	local self = {}
	setmetatable(self, LANG.Lang)

	if not file.IsDir('gms_addons/languages', 'DATA') then
            file.CreateDir('gms_addons/languages')
        end
        self.Lang = {}
	return self
end
function LANG.Lang:Path()
        if not self.path then
            self.path = 'gms_addons/languages/'..self:getTeam()..'/'..self:getAddon()..'/'
        end
        return self.path
    end
function LANG.Lang:Download(callback, retry)
        if retry then
            print('were rerty your mom')
        end

        if not file.IsDir(self:Path(), 'DATA') then
            file.CreateDir(self:Path())
        end

        self:setCallback(callback)
        self:setRetry(retry)
    end
function LANG.Lang:Exec()
        
        local callback = self:getCallback()
        local retry = self:getRetry()

        local url = 'https://raw.githubusercontent.com/Upgration/Languages/master/lang/'..string.lower(self:getTeam())..'/'..string.lower(self:getAddon())..'/'..string.lower(self:getLang())..'.json'
        http.Fetch(url, function(body, size, headers, code)
            local tbl = util.JSONToTable(body)
            if not tbl and retry == nil then
                return self:Download(callback, true)
            elseif not tbl then
                return print('Unable to decode JSON')
            end 

            file.Write(self:Path()..self:getLang()..'.json', body)
            self:CacheLang()
            callback()
        end)
    end
function LANG.Lang:CacheLang()
        local files, _ = file.Find(self:Path()..'*.json', 'DATA')
        for k,v in pairs(files) do
            local locale = string.Split(v, '.')[1]

            if locale == nil then return end
            self.Lang[locale] = util.JSONToTable(file.Read(self:Path()..v, 'DATA'))
        end
    end
function LANG.Lang:GetPhrase(phrase, fallback)     
        local data = phrase:Split(".")
        local res = self.Lang[self:getLang()]['phrases']
        for k,v in ipairs(data) do
            if res[v] == nil then return fallback end
            res = res[v]
        end
        return res
    end
function LANG.Lang:Transfer(tbl, lang)
        file.Write(lang..'.txt', utf8.char( utf8.codepoint( util.TableToJSON(tbl, true), 1, string.len( util.TableToJSON( tbl, true) ) ) ) )
    end
function LANG.Lang:getLang()
	return self.lang
end
function LANG.Lang:setLang(obj)
	self.lang = obj
end
function LANG.Lang:getAddon()
	return self.addon
end
function LANG.Lang:setAddon(obj)
	self.addon = obj
end
function LANG.Lang:getTeam()
	return self.team
end
function LANG.Lang:setTeam(obj)
	self.team = obj
end
function LANG.Lang:getCallback()
	return self.callback
end
function LANG.Lang:setCallback(obj)
	self.callback = obj
end
function LANG.Lang:getRetry()
	return self.retry
end
function LANG.Lang:setRetry(obj)
	self.retry = obj
end
hook.Add('InitializeLanguage', 'teststest', function()
    print('tseting this shit from tom')
end)
hook.Add('Language::Prepare', 'TestLanguage', function()
    local l = LANG.new('s') -- this is a fix for now
    l:setLang('english')
    l:setTeam('XeNiN')
    l:setAddon('BaTtLePaSs')
    l:Download(function() 
        hook.Run('InitializeLanguage')
        print('gello')
    end)
    hook.Remove('Think', 'AddLanuage')
end)