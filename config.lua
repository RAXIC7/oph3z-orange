Config = {}

Config.Locale = 'en' --> Dil Seçeneği (tr, en) -- Select Language (tr, en) <--
Config.DrawDistance = 20.0 --> Kodlara bak anlarsın (Bence dokunma) -- Have a look at the codes (Dont touch) <--
Config.OneOrangePrice = 100 --> 1 tane protakal fiyatı .. 1 orange price <--
Config.PartTwoCoords = vector3(148.794, 6362.41, 31.5291) --> İşleme noktası -- Processing cordinate <--
Config.SellCoords = vector3(-1045.35, 5326.78, 44.67) --> Satma yeri -- Sell cordinate <--

-----------------------------------------------------------------------------------------------------------------------------------------------------

Config.NPC = true --> Satış yerindeki abiyi açar/kapar (true = Aç - false = Kapa) -- Turns the sales man on/off. (true = on - false = off) <--

Config.Peds = {
	Ped = {Hash = 0xED0CE4C6, Anim = 'WORLD_HUMAN_SMOKING', x = -1045.35, y = 5326.78, z = 44.67, h = 31.91}
}

--> Ped Hash/Name: https://wiki.rage.mp/index.php?title=Peds <--

-----------------------------------------------------------------------------------------------------------------------------------------------------

Config.BlipsEnable = true --> Burdan blip açıp kapatabilirsiniz (true = açık - false = kapalı) -- You can turn blips on/off (true = on - false = off) <--

Config.Blips = {
    {Name = "[Portakal] Toplama", ID = 267, Color = 17, Scale = 0.6, Coords = vector3(255.918, 6515.19, 30.8699)},
	{Name = "[Portakal] İşleme", ID = 267, Color = 17, Scale = 0.6, Coords = vector3(148.794, 6362.41, 31.5291)},
	{Name = "[Portakal] Satış", ID = 267, Color = 17, Scale = 0.6, Coords = vector3(-1045.35, 5326.78, 44.67)},
}

--> Bilmeyenler için bilgi -- Information for those who don't know <--

--> ID = Blip görünüşü -- Blip from <--
--> Color = Blip rengi -- I guess I don't need to write what the color is :D <--
--> Scale = Blip boyutu -- Blipe size <--

-----------------------------------------------------------------------------------------------------------------------------------------------------

Config.DiscordWebhook = 'webhook' -- Discord Webhook
Config.AwatarURL = 'url' -- Awatar URL
Config.IconURL = 'url' -- Icon URL

-----------------------------------------------------------------------------------------------------------------------------------------------------

Config.Settings = { --> Ağaç kordinatlar -- Tree coordinates <-- 
    [1] = {
        Coords = {
            [1] = { Pos = vector3(281.220, 6505.99, 30.1599) },
            [2] = { Pos = vector3(272.792, 6506.75, 30.4339) },
            [3] = { Pos = vector3(264.116, 6505.30, 30.6746) },
            [4] = { Pos = vector3(255.543, 6503.15, 30.8792) },
            [5] = { Pos = vector3(246.799, 6502.21, 31.0505) },
            [6] = { Pos = vector3(237.453, 6502.62, 31.1932) },
            [7] = { Pos = vector3(228.249, 6500.55, 31.3088) },
            [8] = { Pos = vector3(226.218, 6511.18, 31.3275) },
            [9] = { Pos = vector3(234.915, 6511.53, 31.2299) },
            [10] = { Pos = vector3(245.190, 6514.78, 31.0810) },
            [11] = { Pos = vector3(253.506, 6513.24, 30.9239) },
            [12] = { Pos = vector3(262.057, 6516.03, 30.7194) },
            [13] = { Pos = vector3(271.623, 6518.46, 30.4648) },
            [14] = { Pos = vector3(280.687, 6518.46, 30.1824) }
        }
    }
} --> Ağaç kordinatlar -- Tree coordinates <--