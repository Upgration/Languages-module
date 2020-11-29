# Languages Module
The code for Language module that uses the [Languages Repo](https://github.com/Upgration/Languages).

## Reporting Issues
I'll fix any issue listed in [here](https://github.com/Upgration/Languages).

## Usage
This is an example on how you can use this addon in your addon. 

First you must instasitate the language like this:
```lua
MYLANG = LANG:Init('mylanguage', 'myaddon', 'myteam',function() -- this function can be used for calling any hooks that you might need when you've downloaded the needed language files
    hook.Run('mylanguagehook') 
end)
```

Then you can use this for retriving the language phrases:
```lua
print(MYLANG:GetPhrase('myphrase', 'fallback')) -- The fallback is used if the server has a outdated language version, which shouldn't happen.
```
