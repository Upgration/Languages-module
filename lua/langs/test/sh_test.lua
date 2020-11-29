CURLANG = LANG:Init('english', 'coinflip', 'XeNiN',function() 
    hook.Run('InitializeLanguage')
    print('gello')
end)

hook.Add('InitializeLanguage', 'teststest', function()
    print(CURLANG:GetPhrase('misc.Max', 'hitler'))

end)

hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
    draw.SimpleText(CURLANG:GetPhrase('misc.Max', 'hitler'), "DermaDefault", 250,25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
end )