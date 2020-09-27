LANG = {}
require 'xloader'

if SERVER then
    xloader('langs', function(f) include(f) end)
else
    xloader('langs', function(f) include(f) end)
end