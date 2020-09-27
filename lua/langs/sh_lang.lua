LANG = LANG or {}
LANG.__index = LANG
function LANG:Init(s)
	local self = {}
	setmetatable(self, LANG)

	if not file.IsDir('languages', 'DATA') then
        file.CreateDir('languages')
    end

    self.Lang = {}
	return self
end

function LANG:Path()
    if not self.path then
        self.path = 'languages/'..self:getTeam()..'/'..self:getAddon()..'/'
    end
    return self.path
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

local function fetch(url)
    local d = LANG.new()
    http.Fetch(url, function(body, size, headers, code)
        d:resolve(body)
    end, function(err)
        d:reject(err)
    end)
    return d
end


function LANG:Download(callback, retry)

    local url = 'https://raw.githubusercontent.com/Upgration/Languages/master/lang/'..string.lower(self:getTeam())..'/'..string.lower(self:getAddon())..'/'..string.lower(self:getLang())..'.json'

    fetch(url)
        :next(function(body)
            local tbl = util.JSONToTable(body)
            if not tbl and retry == nil then
                return self:Download(callback, true)
            elseif not tbl then
                return print('Unable to decode JSON')
            end

            if not file.IsDir(self:Path(), 'DATA') then
                file.CreateDir(self:Path())
            end

            file.Write(self:Path()..''..self:getLang()..'.json', body)
            self:CacheLang()
            callback()
        end)
        :catch(function(err)
            print("Oops!", err)
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
    local lt = {}
    lt['phrases'] = {}
    for k, v in pairs(tbl) do
        lt['phrases'][k] =  utf8.char( utf8.codepoint(v, 1, string.len(v) ) ) 
    end
    file.Write(lang..'.txt', util.TableToJSON(lt, true))
end