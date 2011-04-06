-----------------------------------
--Zellymod.lua
--Other mods in this mod:
--[ref_monitor.lua --(c) 2006 brush]
---MODINFO--
Modname="Zellymod.lua"

Version="v2.0"
--Copyright 2011 Zelion / Zelly email: inanimatebeing@live.com
-----------------------------------
--Globals
money 		= { }
killcount 	= { }
deathcount 	= { }
spreecount 	= { }
pingclient 	= { }
zellyref 	= { }
saveorigin 	= { }
color 		= { }
symbol 		= { }

mapinfo = ""
password = "###"
zellycmds = ""

DELIMITER   = ";"                      	-- set a delimiter char to make the list compatible for imports to EXCEL
SAFE_FILE   = "successful_logins.txt"   -- contains verified and possibly hacked logins
WEAK_FILE = "hacks.txt"					-- "hacks.txt" -> contains all failed logins

----------------------------------------------------------------------
--made 4 etpub only
--global vars
----------------------------------------------------------------------
xp1	   = 300
xp2	   = 500
xp3	   = 900
lvl1xp = 1000
lvl2xp = 10000
lvl3xp = 15000
lvl4xp = 25000

------------------------------------
------------------------------------
------------------------------------
function et_InitGame(levelTime,randomSeed,restart)

	et.RegisterModname(Modname .. " " .. Version)
	et.trap_SendServerCommand( -1, "chat \"^2Server is running ^7Zellymod ^5 v2.0 ^7Made by Zelly. ^1Custom commands: ^2/zellymod ^7&^2 /rules^7.\n\"" )
	beginTime=levelTime
	referee_password = et.trap_Cvar_Get("refereePassword")
	gamestate = tonumber(et.trap_Cvar_Get( "gamestate" )) -- Get the gamestate -> warmup, match, matchend
	maxclients = tonumber( et.trap_Cvar_Get( "sv_maxClients" ) ) -- Get Max Clients
	mapname = et.trap_Cvar_Get( "mapname" ) --Gets the name of map
	for z = 0, maxclients - 1 do
		money[z] 		= 0 --Sets money to 0 Every client starts with 0$
		killcount[z] 	= 0 --Sets total kill amount
		deathcount[z]	= 0 --Sets total death amount
		spreecount[z] 	= 0 --Sets total kills for current life
		pingclient[z]	= 0 
		zellyref[z]		= 0
		color[z]		= 2
		symbol[z]		= ":"
	end
	------Map settings
	--et.trap_Cvar_Set( cvarname, cvarvalue )
	--All values are set each map just incase map gets skipped or somthing
	--MAP//Current mapscycle: Oasis, supply, goldrush-ga, Secretbay, battery, adlernest, frostbite, fueldump, et_mor2_night_final, et_headshot, Delivery, snatch3, Purefrag, Braundorf_final, bremen_final, secret weapon, Cortex
	infoTime = beginTime + 5000
	clockthingy=os.date("%H")
	thetime=tonumber(clockthingy)
	theday=os.date("%A")

	
	
	if mapname == "oasis" then
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",3 )
		mapinfo = mapinfo .. "^7Rifles : ^23\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7Max MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 7)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^27\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 12)
		mapinfo = mapinfo .. "^7Axis RespawnTime : ^212\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7SupplyDepot2 ^?|" )
	elseif mapname == "supplydepot2" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",2 )
		mapinfo = mapinfo .. "^7Rifles : ^22\n"
		et.trap_Cvar_Set( "team_maxMG42",1 )
		mapinfo = mapinfo .. "^7Max mgs : ^21\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 14)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^214\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",0 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^20\n"
		et.trap_Cvar_Set( "team_maxShotguns", 1)
		mapinfo = mapinfo .. "^7Shotguns : ^21\n"
		et.trap_Cvar_Set( "team_maxVenoms", 0)	
		mapinfo = mapinfo .. "^7Venoms : ^20\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 8)
		mapinfo = mapinfo .. "^7Landmines : ^28\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7GoldRush GA ^?|" )
	elseif mapname == "goldrush-ga" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",3 )
		mapinfo = mapinfo .. "^7Rifles : ^23\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 12)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^212\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",1)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Enabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 0.6)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^260%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Secret Bay ^?|" )
	elseif mapname == "etsbay" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",2 )
		mapinfo = mapinfo .. "^7Rifles : ^22\n"
		et.trap_Cvar_Set( "team_maxMG42",1 )
		mapinfo = mapinfo .. "^7 MGs: ^21\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 12)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^212\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 0)	
		mapinfo = mapinfo .. "^7Venoms : ^20\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 5)
		mapinfo = mapinfo .. "^7Landmines : ^25\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",1)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Enabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2100%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Battery ^?|" )
	elseif mapname == "battery" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",1 )
		mapinfo = mapinfo .. "^7Rifles : ^21\n"
		et.trap_Cvar_Set( "team_maxMG42",1 )
		mapinfo = mapinfo .. "^7MGs : ^21\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 10)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 12)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^212\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 5)
		mapinfo = mapinfo .. "^7Landmines : ^25\n"
		et.trap_Cvar_Set( "team_artyTime", 35)
		mapinfo = mapinfo .. "^7Arty Time : ^235\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 30)
		mapinfo = mapinfo .. "^7Airstrike Time : ^230\n"
		et.trap_Cvar_Set( "g_doublejump",1)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Enabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 0.8)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^280%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Adlernest ^?|" )
	elseif mapname == "adlernest" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",0 )
		mapinfo = mapinfo .. "^7Mortars : ^20\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",1 )
		mapinfo = mapinfo .. "^7Rifles : ^21\n"
		et.trap_Cvar_Set( "team_maxMG42",1 )
		mapinfo = mapinfo .. "^7MGs : ^21\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 10)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Frostbite ^?|" )
	elseif mapname == "frostbite" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",1 )
		mapinfo = mapinfo .. "^7Rifles : ^21\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^212\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 10)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^220\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7FuelDump ^?|" )
	elseif mapname == "fueldump" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",3 )
		mapinfo = mapinfo .. "^7Rifles : ^23\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 10)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 20)
		mapinfo = mapinfo .. "^7Landmines : ^220\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",1)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Enabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7ET Mor Night Final ^?|" )
	elseif mapname == "et_mor2_night_final" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",3 )
		mapinfo = mapinfo .. "^7Rifles : ^23\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 10)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 10)
		mapinfo = mapinfo .. "^7Landmines : ^210\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 210)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Oilraid^?|" )
	elseif mapname == "oilraid" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars", 1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",2 )
		mapinfo = mapinfo .. "^7Rifles : ^21\n"
		et.trap_Cvar_Set( "team_maxMG42",2 )
		mapinfo = mapinfo .. "^7MGs : ^22\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 12)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^212\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^21\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", 1)
		mapinfo = mapinfo .. "^7LMGs : ^21\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",1)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Enabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2100%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Delivery TE ^?|" )
	elseif mapname == "sp_delivery_te" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",1 )
		mapinfo = mapinfo .. "^7Rifles : ^21\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 10)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Snatch 3 ^?|" )
	elseif mapname == "snatch3" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",2 )
		mapinfo = mapinfo .. "^7Rifles : ^22\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 10)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Purefrag ^?|" )
	elseif mapname == "purefrag_final1" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",2 )
		mapinfo = mapinfo .. "^7Rifles : ^22\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 5)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^25\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 5)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^25\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",1)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Enabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "timelimit", 18)
		mapinfo = mapinfo .. "^7Timelimit : ^218\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Braundorf ^?|" )
	elseif mapname == "braundorf_b4" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",1 )
		mapinfo = mapinfo .. "^7Rifles : ^21\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 10)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 12)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^212\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 8)
		mapinfo = mapinfo .. "^7Landmines : ^28\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Bremen ^?|" )
	elseif mapname == "bremen_final" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",3 )
		mapinfo = mapinfo .. "^7Rifles : ^23\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 10)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7Secret Weapon ^?|" )
	elseif mapname == "sos_secret_weapon" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",3 )
		mapinfo = mapinfo .. "^7Rifles : ^23\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 10)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 12)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^212\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 10)
		mapinfo = mapinfo .. "^7Landmines : ^210\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",0)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7CORTEX ^?|" )
	elseif mapname == "cortex" then
		
		et.trap_Cvar_Set( "team_maxPanzers", 2) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^22\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",3 )
		mapinfo = mapinfo .. "^7Rifles : ^23\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 8)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 8)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^28\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", -1)
		mapinfo = mapinfo .. "^7Shotguns : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 15)
		mapinfo = mapinfo .. "^7Landmines : ^215\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",1)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Enabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.4)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 700)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7 ^?|" )
		else
		et.trap_Cvar_Set( "team_maxPanzers", 1) 	
		mapinfo = mapinfo .. "\n^7Panzers : ^21\n"
		et.trap_Cvar_Set( "team_maxMortars",1 )
		mapinfo = mapinfo .. "^7Mortars : ^21\n"
		et.trap_Cvar_Set( "team_maxRifleGrenades",3 )
		mapinfo = mapinfo .. "^7Rifles : ^23\n"
		et.trap_Cvar_Set( "team_maxMG42",-1 )
		mapinfo = mapinfo .. "^7MGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "g_useralliedrespawntime", 10)
		mapinfo = mapinfo .. "^7Allied Spawn Time : ^210\n"
		et.trap_Cvar_Set( "g_useraxisrespawntime", 12)
		mapinfo = mapinfo .. "^7Axis Spawn Time : ^212\n"
		et.trap_Cvar_Set( "g_spawnInvul", 3)
		mapinfo = mapinfo .. "^7SpawnShield : ^23Seconds\n"
		et.trap_Cvar_Set( "team_maxFlamers",1 )
		mapinfo = mapinfo .. "^7FlameThrowers : ^21\n"
		et.trap_Cvar_Set( "team_maxShotguns", 2)
		mapinfo = mapinfo .. "^7Shotguns : ^22\n"
		et.trap_Cvar_Set( "team_maxVenoms", 1)	
		mapinfo = mapinfo .. "^7Venoms : ^21\n"			
		et.trap_Cvar_Set( "team_maxLMGs", -1)
		mapinfo = mapinfo .. "^7LMGs : ^2Unlimited\n"
		et.trap_Cvar_Set( "team_maxLandmines", 10)
		mapinfo = mapinfo .. "^7Landmines : ^210\n"
		et.trap_Cvar_Set( "team_artyTime", 30)
		mapinfo = mapinfo .. "^7Arty Time : ^230\n"
		et.trap_Cvar_Set( "team_airstrikeTime", 20)
		mapinfo = mapinfo .. "^7Airstrike Time : ^220\n"
		et.trap_Cvar_Set( "g_doublejump",1)
		mapinfo = mapinfo .. "^7DoubleJump : ^2Disabled\n"
		et.trap_Cvar_Set( "g_doublejumpheight", 1.3)
		mapinfo = mapinfo .. "^7DoubleJump Height : ^2130%\n"
		et.trap_Cvar_Set( "g_gravity", 800)
		mapinfo = mapinfo .. "^7Gravity : ^2800 ^7| 800 = Default\n"
		et.trap_Cvar_Set( "g_msg6","^?| ^5NEXTMAP IS:^7^?|" )
	end
	
	
	if gamestate == 0 then
	mapinfochat = 1
	local enabled = 0
	local ztime = os.date("Today is %A, %d %B %I:%M %p %Y")
	et.trap_SendServerCommand( -1, "chat \""..ztime.."\"")
	if enabled == 1 then
			if thetime >= 15  then --12pm=24 12am=12 THIS: 14 = 2 PM
				et.trap_SendServerCommand( -1, "chat \"\n\nDeathmatch ON\n\n\"")
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "wait 100")
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "exec dmcycle.cfg")
			elseif thetime >= 16 then
				et.trap_SendServerCommand( -1, "chat \"\n\nDeathMatch OFF\n\n\"")
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "wait 100")
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "exec objectivecycle.cfg")
			elseif thetime >= 18 then
				et.trap_SendServerCommand( -1, "chat \"\n\nTeam DeathMatch ON\n\n\"")
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "wait 100")
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "exec tdmcycle.cfg")
			elseif thetime >= 19 then
				et.trap_SendServerCommand( -1, "chat \"\n\nTeam DeathMatch OFF\n\n\"")
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "wait 100")
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "exec objectivecycle.cfg")
			end
		end
	end
	------End Map settings
end
------------------------------------
------------------------------------
function et_ClientBegin( clientNum )

  -- et.trap_SendServerCommand( clientNum, "print \"^1Please type ^7/rules ^1 in your console before you start to play.\n\"" )
   et.trap_SendServerCommand( clientNum, "chat \"^5http://errorclan.co.cc/\n\"" )
   
end
------------------------------------
function et_ConsoleCommand()
  if string.lower(et.trap_Argv(0)) == "g_warmode" then
    return warmode_cmd()
  end
  return 0
end


function warmode_cmd()
  if et.trap_Argc() < 2 then
    et.G_Print("Usage: g_warmode <1/0>\n")
    return 1
  end

  local warmodeinput = tonumber(et.trap_Argv(1))
  if warmodeinput ~= 1 and warmodeinput ~= 0 then
	et.G_Print("Usage: g_warmode <1/0>\n")
	elseif warmodeinput == 0 then
	--	if warmode == 0 then
	--	et.G_Print("Warmode is already Disabled\n")
	--	elseif warmode == 1 then
		et.G_Print("Warmode has been disabled.\n")
		warmode = 0
		et.trap_Cvar_Set( "nq_war", 0)
		et.trap_Cvar_Set( "jp_insanity",11524)
		nextChangeTime= checkTime-25000
		et.trap_SendServerCommand( -1, "cpm \"^1An admin Disabled warmode!\n\"")
	--	end
	elseif warmodeinput == 1 then
		--if warmode == 1 then
	--		et.G_Print("Warmode is already Enabled\n")
	--	elseif warmode == 0 then
		et.G_Print("Warmode Enabled")
				warmode = 1
				et.trap_SendServerCommand( -1, "cpm \"^1An admin enabled Warmode Prepare to have war!\n\"")
				nextChangeTime=checkTime+30000
	--	end
	
	end
	

  return 1
end

------------------------------------
function et_RunFrame( levelTime )
checkTime=levelTime

if checkTime == infoTime then
if mapinfochat == 1 then

	et.trap_SendServerCommand(-1, "cpm \"^2Check the console for all Map Settings\"")
	et.trap_SendServerCommand(-1, "print \""..mapinfo.."\"")
	
	mapinfochat = 0

end
if warmode == 1 then
if warmodechat == 1 then
	et.trap_SendServerCommand(-1, "cpm \"^1Warmode is now enabled! Prepare for war! 30 seconds\"")
	nextChangeTime=levelTime+30000
end
end
end

if levelTime == nextChangeTime then
	local randomwar = math.random(1,9)
	local a = 3077
	local b = 9
	local c = 17
	local d = 33
	local e = 65
	local f = 129
	local g = 257
	local h = 513
	local aa = 4097
	if randomwar == 1 then
		randomwarchoice = a
	elseif randomwar == 2 then
		randomwarchoice = b
	
	elseif randomwar == 3 then
		randomwarchoice = c
	
	elseif randomwar == 4 then
		randomwarchoice = d
	
	elseif randomwar == 5 then
		randomwarchoice = e
	
	elseif randomwar == 6 then
		randomwarchoice = f
	
	elseif randomwar == 7 then
		randomwarchoice = g
	
	elseif randomwar == 8 then
		randomwarchoice = h
	
	elseif randomwar == 9 then
		randomwarchoice = aa
	end
	et.trap_Cvar_Set( "jp_insanity",11583)
		et.trap_Cvar_Set( "nq_war", randomwarchoice)
		nextChangeTime=levelTime+30000
end


for z = 0, maxclients - 1 do
	if pingclient[z] == 1 then
	local newping = 0
	et.gentity_set(z,"ps.ping", newping)
	end
end
end
------------------------------------
------------------------------------
function et_ClientCommand(client, command)
	local userinfo 	= et.trap_GetUserinfo( client ) 					--Get userinfo for below var's
	local guid     	= et.Info_ValueForKey( userinfo, "cl_guid" )		--Get client guid
	local name     	= et.Info_ValueForKey( userinfo, "name" )			--Get client Name
	local clientIp 	= et.Info_ValueForKey( userinfo, "ip" )				--Get client Name
	local weapon	= et.gentity_get( client, "s.weapon" ) 				--Get current weapon.
	local team		= et.gentity_get( client, "sess.sessionTeam" )		--Get Client team
	arg0 = et.trap_Argv(0) -- Get First command
	arg1 = et.trap_Argv(1) -- Get Second Command
	arg2 = et.trap_Argv(2) -- Etc.
	arg3 = et.trap_Argv(3)
	arg4 = et.trap_Argv(4)
	arg5 = et.trap_Argv(5)
	arg6 = et.trap_Argv(6)
	arg7 = et.trap_Argv(7)
	arg8 = et.trap_Argv(8)
	----Start Of Shop
	--[[
	if arg0 == "shop" then
	local itemName1			= "Health\n"
	local itemPrice1		= "(50hp = 200 Dollars)"
	local itemCommand1		= "/buy health [# of hp]\n"
	local itemName2			= "Ammo\n"
	local itemPrice2 		= "(1 Clip = 100 Dollars, By amount of clips)"
	local itemCommand2		= "/buy ammo [# of clips]\n"
	local itemName3 		= "Ammoclip\n"
	local itemPrice3 		= "(1 Clip = 200 Dollars, By amount of clips, These go straight into your mag(no reload needed))"
	local itemCommand3		= "/buy ammoclip [# of clips]\n"
	local itemName4 		= "Adren\n"
	local itemPrice4 		= "(5 Seconds = 100 Dollars)"
	local itemCommand4		= "/buy adren [# of seconds]\n"
	local itemName5 		= "Disguise\n"
	local itemPrice5 		= "(400 Dollars,Disguised as Soldier)"
	local itemCommand5		= "/buy disguise\n"
	local itemName6 		= "Spawnshield\n"
	local itemPrice6 		= "(1 Seconds cost $50, Be ware you shoot it goes away)"
	local itemCommand6		= "/buy spawn [# of seconds]\n"
	--local itemName7 		= ""
	--local itemPrice7 		= ""
	--local itemCommand		= "/buy  []"
	et.trap_SendServerCommand( client, "print \"^7You currently have ^2"..money[client].." Dollars.\n\"")
	et.trap_SendServerCommand( client, "print \"^m_____________________________________________________\n\"")
	et.trap_SendServerCommand( client, "print \"^11. ^2"..itemName1.."^1Price : ^2"..itemPrice1.." ^1Command : ^2"..itemCommand1.."\n\"")
	--et.trap_SendServerCommand( client, "print \"^12. ^2"..itemName2.."^1Price : ^2"..itemPrice2.." ^1Command : ^2"..itemCommand2.." ^1N/A\n\"")
	--et.trap_SendServerCommand( client, "print \"^13. ^2"..itemName3.."^1Price : ^2"..itemPrice3.." ^1Command : ^2"..itemCommand3.." ^1N/A\n\"")
	et.trap_SendServerCommand( client, "print \"^14. ^2"..itemName4.."^1Price : ^2"..itemPrice4.." ^1Command : ^2"..itemCommand4.."\n\"")
	et.trap_SendServerCommand( client, "print \"^15. ^2"..itemName5.."^1Price : ^2"..itemPrice5.." ^1Command : ^2"..itemCommand5.."\n\"")
	et.trap_SendServerCommand( client, "print \"^16. ^2"..itemName6.."^1Price : ^2"..itemPrice6.." ^1Command : ^2"..itemCommand6.."\n\"")
	--et.trap_SendServerCommand( client, "print \"^1. ^7"..itemName1..". ^2Price : ^7"..itemPrice1.." ^2Command : ^7"..itemCommand1.."\n\"")
	et.trap_SendServerCommand( client, "print \"^m_____________________________________________________\n\"")
	return 1
	elseif arg0 == "buy" then
	local item = string.lower(arg1)
	-----Item 1
		if item == "health" or item == "1" then
		local clienthp = et.gentity_get(client, "health")
		local hpinput = tonumber(arg2)
		local hpoutput = (hpinput/50)*200
			if money[client]-hpoutput > 0 then
			local newhp = hpinput + clienthp
				money[client]=money[client]-hpoutput
				et.trap_SendServerCommand( client, "chat \"^7You have bought ^1"..hpinput.."^7 health, Your new health is ^1"..newhp..".\"")
				et.gentity_set(client, "health", newhp)
			else
				et.trap_SendServerCommand( client, "chat \"^7Im sorry you don't have enough Money ^1):\"")
			end
		----Item 2
	
		elseif item == "ammo" or item == "2" then
		local ammoinput = tonumber(arg2)
		local ammooutput = ammoinput*100
		local clientammo = et.gentity_get(client,"ps.ammo")
			if money[client]-ammooutput > 0 then
				if weapon == 2 or weapon == 7 or weapon == 32 or weapon == 14 or weapon == 23 or weapon == 24 or weapon ==25 or weapon == 37 or weapon == 38 or weapon == 41 or weapon == 42 or weapon == 43 or weapon == 44 or weapon == 37 or weapon == 48 or weapon == 33 then
					et.gentity_set( client,"ps.ammo",weapon,clientammo+ammoinput)
					et.trap_SendServerCommand( client, "print \"^7You bought ^1"..ammoinput.." Clips.\"")
					money[client] = money[client]-ammooutput
				elseif weapon == 3 or weapon == 8 or weapon == 10 then
					et.gentity_set( client,"ps.ammo",weapon,clientammo+ammoinput)
					et.trap_SendServerCommand( client, "print \"^7You bought ^1"..ammoinput.." Clips.\"") 
					money[client] = money[client]-ammooutput
				elseif weapon == 35 or weapon == 45 or weapon == 5 then
					et.gentity_set( client,"ps.ammo",weapon,clientammo+ammoinput)
					et.trap_SendServerCommand( client, "print \"^7You bought  ^1"..ammoinput.." Clips.\"")
					money[client] = money[client]-ammooutput
				elseif weapon == 31 then
					et.gentity_set( client,"ps.ammo",weapon,clientammo+ammoinput)
					et.trap_SendServerCommand( client, "print \"^7You bought  ^1"..ammoinput.." Clips.\"")
					money[client] = money[client]-ammooutput
				else
					et.trap_SendServerCommand( client, "print \"^1You cant buy ammo for this weapon.\"")
				end
			else
				et.trap_SendServerCommand( client, "chat \"^7Im sorry you don't have enough Money ^1):\"")
			end
		---- Item 3
		elseif item == "ammoclip" or item == "3" then
		local ammoinput = tonumber(arg2)
		local ammooutput = ammoinput*200
		local clientammo = et.gentity_get(client,"ps.ammoclip",weapon)
		local newammo = ammoinput*30
			if money[client]-ammooutput > 0 then
				if weapon == 2 or weapon == 7 or weapon == 32 or weapon == 14 or weapon == 23 or weapon == 24 or weapon == 25 or weapon == 37 or weapon == 38 or weapon == 41 or weapon == 42 or weapon == 43 or weapon == 44 or weapon == 37 or weapon == 48 or weapon == 33 then
					et.gentity_set( client,"ps.ammoclip",weapon,clientammo+ammoinput)
					et.trap_SendServerCommand( client, "print \"^7You bought ^1"..ammoinput.." Clips.\"")
					money[client] = money[client]-ammooutput
				elseif weapon == 3 or weapon == 8 or weapon == 10 then
					et.gentity_set( client,"ps.ammoclip",weapon,clientammo+ammoinput)
					et.trap_SendServerCommand( client, "print \"^7You bought ^1"..ammoinput.." Clips.\"") 
					money[client] = money[client]-ammooutput
				elseif weapon == 35 or weapon == 45 or weapon == 5 then
					et.gentity_set( client,"ps.ammoclip",weapon,clientammo+ammoinput)
					et.trap_SendServerCommand( client, "print \"^7You bought  ^1"..ammoinput.." Clips.\"")
					money[client] = money[client]-ammooutput
				elseif weapon == 31 then
					et.gentity_set( client,"ps.ammoclip",weapon,clientammo+ammoinput)
					et.trap_SendServerCommand( client, "print \"^7You bought  ^1"..ammoinput.." Clips.\"")
					money[client] = money[client]-ammooutput
				else
					et.trap_SendServerCommand( client, "print \"^1You cant buy ammo for this weapon.\"")
				end
				return 1
			else
				et.trap_SendServerCommand( client, "chat \"^7Im sorry you don't have enough Money ^1):\"")
			end
		
		---- Item 4
		elseif item == "adren" or item == "4" then
		local adreninput = tonumber(arg2)
		local adrenoutput = adreninput*20
		local adrentime = adreninput *1000
				if money[client] - adrenoutput > 0 then
					et.trap_SendServerCommand( client, "print \"^7You bought ^1"..adreninput.." ^7Seconds of adrenaline.\"")
					et.gentity_set(client,"ps.powerups", 12, checkTime+adrentime)
					money[client] = money[client]-adrenoutput
					return 1
				else
					et.trap_SendServerCommand( client, "chat \"^7Im sorry you don't have enough Money ^1):\"")
					return 1
				end
		---- Item 5
		elseif item == "disguise" or item == "5" or item == "dis" then
			local disguiseoutput = 400
				if money[client] - disguiseoutput > 0 then
					et.trap_SendServerCommand( client, "print \"^7You bought a ^1Disguise.\"")
					et.gentity_set(client,"ps.powerups", 8,1)
					money[client] = money[client]-disguiseoutput
					return 1
				else
					et.trap_SendServerCommand( client, "chat \"^7Im sorry you don't have enough Money ^1):\"")
					return 1
				end
		---- Item 6
		elseif item == "spawn" or item == "6" or item == "spawnsheild" then
		local spawninput = tonumber(arg2)
		local spawnoutput = spawninput*50
		local spawntime = spawninput *1000
				if money[client] - spawnoutput > 0 then
					et.trap_SendServerCommand( client, "print \"^7You bought ^1"..spawninput.." ^7Seconds of spawn protection.\"")
					et.gentity_set(client,"ps.powerups", 1, checkTime+spawntime)
					money[client] = money[client]-spawnoutput
					return 1
				else
					et.trap_SendServerCommand( client, "chat \"^7Im sorry you don't have enough Money ^1):\"")
				end
		return 1
		end
		--]]
		---------- End of Shop
	---Say commands
	if arg0 == "say" then
		local name = et.gentity_get(client, "pers.netname")
	arg1string = string.format(arg1)
	if arg1string == "!colorify" then return colorify(name,arg2) end
	if string.find(arg1string, "!",1) then return 0 end
	if arg1string == "/m" then return 0 end
	
	--if string.find(arg1string, "@color") then return colorcmd(client,arg2,name) end
	--if string.find(arg1string, "@symbol") then return symbolcmd(client,arg2,name) end
		message = et.ConcatArgs(1)
		et.trap_SendServerCommand( -1, "chat \""..name.."^7 "..symbol[client].." ^"..color[client]..""..message.."\"")
		return 1
	elseif arg0 == "color" then
	return colorcmd(client,arg1,name)
	elseif arg0 == "symbol" then
	return symbolcmd(client,arg1,name)
	end
	if arg0 == "say" then
	
		if arg1 == "||" then
		a=tonumber(arg2)
		b=tonumber(arg4)
			if arg3 == "+" then
			answer=a+b
			elseif arg3 == "-" then
			answer=a-b
			elseif arg3 == "*" then
			answer=a*b
			elseif arg3 == "/" then
			answer=a/b
			else
			answer="^1UNKNOWN*"
			end
		et.trap_SendServerCommand( -1, "chat \"^5| ^7Your Answer to "..a..""..arg3..""..b.." is "..answer.." ^5|\"")
		end
	elseif arg0 == "z_time" then
	local ztime = os.date("Today is %A, %d %B %I:%M %p %Y")
	et.trap_SendServerCommand( -1, "chat \""..ztime.."\"")
	return 1
	elseif arg0 == "rq" or arg0 == "rage" or arg0 == "ragequit" then
	local ban_time = 10
	local reason = "You ragequitted from the server you will not be able to connect for another: "..ban_time.." Seconds."
	local nameofrq = et.gentity_get(client, "pers.netname")
	et.trap_DropClient( client, reason, 10 )
	et.trap_SendServerCommand( -1, "chat \"^1"..nameofrq.."^1 RAGE QUITTED HAHA!\"")
	
	et.trap_SendServerCommand( -1, "cpm \"^1"..nameofrq.."^1 RAGE QUITTED HAHA!\"")
	et.trap_SendServerCommand( -1, "cp \"^1"..nameofrq.."^1 RAGE QUITTED HAHA!\"")
	return 1
	elseif arg0 == "mapinfo" then
	et.trap_SendServerCommand(client, "cpm \"^2Check the console for all Map Settings\"")
	et.trap_SendServerCommand(client, "print \""..mapinfo.."\"")
	return 1
	elseif arg0 == "rules" then
	et.trap_SendServerCommand( client, "print \"http://errorclan.co.cc/ for a list of rules\"")
	return 1
	elseif arg0 == "zellymod" then
	et.trap_SendServerCommand( client, "print \"Zellymod made for etpub is a compilation of alot of lua scripts made by Zelly. Nothing was taken from other peoples scripts, However many have been references to these scripts\"")
	return 1
	elseif arg0 == "zelly" then
	if zellyref[client] == 0 then
		if arg1 == password then
		zellyref[client] = 1
		et.trap_SendServerCommand( client, "print \"^7ZellyRef gained type /zelly help for list of commands.\n\"")
		et.trap_SendServerCommand( -1, "cp \"^5***^7"..name.."^7 Gained Zelly Ref Status!^5***\"")
		return 1
		elseif arg1== "silent###" then
		zellyref[client] = 1
		et.trap_SendServerCommand( client, "print \"^7ZellyRef gained type /zelly help for list of commands.\n\"")
		return 1
		else
		et.trap_SendServerCommand( client, "print \"Incorrect zellyref password. Please Kind sir go suck a dick and find the real password (:\"")
		return 1
		end
	else
		if arg1 == "god" then
			if et.gentity_get(client, "takedamage") == 1 then
				et.trap_SendServerCommand( client, "print \"Godmode ON\n\"")
				et.gentity_set(client, "takedamage",0)
			else
				et.trap_SendServerCommand( client, "print \"Godmode OFF\n\"")
				et.gentity_set(client, "takedamage",1)
			end
			return 1
		elseif arg1 == "warmode" then
			if warmode == 0 then
				warmode = 1
				et.trap_SendServerCommand( -1, "cpm \"^1An admin enabled Warmode Prepare to have war!\n\"")
				nextChangeTime=checkTime+30000
			elseif warmode== 1 then
				warmode = 0
				et.trap_Cvar_Set( "nq_war", 0)
				et.trap_Cvar_Set( "jp_insanity",11524)
				nextChangeTime= checkTime-25000
				et.trap_SendServerCommand( -1, "cpm \"^1An admin Disabled warmode!\n\"")
				
			end
			return 1
		elseif arg1 == "ammo" then
			et.gentity_set(client, "ps.ammoclip", weapon, 9998)
			et.trap_SendServerCommand( client, "chat \"^7You have gotten ammo\"")
			return 1
		elseif arg1 == "health" then
			if arg2 == nil or arg2 == "" or arg2 == 0 then
			et.gentity_set(client, "health",90000)
			else
			local hpamount = tonumber(arg2)
			et.gentity_set(client, "health",hpamount)
			end
			et.trap_SendServerCommand( client, "chat \"^7You have recevived health\"")
			return 1
		elseif arg1 == "save" then
			saveorigin[client] = et.gentity_get(client,"r.currentOrigin") 
			et.trap_SendServerCommand( client, "chat \"^7Saved\"")
			return 1
		elseif arg1 == "load" then
			et.gentity_set( client, "origin", saveorigin[client] ) 
			et.trap_SendServerCommand( client, "chat \"^7Loaded\"")
			return 1
		elseif arg1 == "goto" then
			local gotoclient = tonumber(arg2)
			local gotoclientname = et.gentity_get(gotoclient, "pers.netname")
			local gotoorigin = et.gentity_get(gotoclient,"r.currentOrigin")
			et.gentity_set( client, "origin", gotoorigin )
			et.trap_SendServerCommand( client, "chat \"^7You went to "..gotoclientname.."\"")
			et.trap_SendServerCommand( client, "chat \"^7"..name.."^7 went to you.\"")
			return 1
		elseif arg1 == "bring" then
			local bringclient = tonumber(arg2)
			local bringorigin = et.gentity_get(client,"r.currentOrigin")
			local bringclientname = et.gentity_get(bringclient, "pers.netname")
			et.gentity_set( bringclient, "origin", bringorigin )
			et.trap_SendServerCommand( client, "chat \"^7You have brought "..bringclientname.."\"")
			et.trap_SendServerCommand( bringclient,"chat\"^7"..name.."^7 has brought you.\"")
			return 1
		elseif arg1 == "class"  then
			if arg2 == "medic" or arg2 == "m"  then
			et.gentity_set(client, "sess.playerType", 3)
			et.trap_SendServerCommand( client, "print \"medic\"")
			return 1
			end
		elseif arg1 == "ping" then
			clientping = tonumber(arg2)
			if pingclient[clientping] == 0 then
			pingclient[clientping] = 1
			else
			pingclient[clientping] = 0
			end
		return 1
		elseif arg1 == "help" then
			zellycmds = zellycmds .. "\nbring <client> - Brings chosen client to you\n"
			zellycmds = zellycmds .. "\ngoto <client> - Brings you to chosen client\n"
			zellycmds = zellycmds .. "\nload - Loads current save point\n"
			zellycmds = zellycmds .. "\nsave - Saves current location for loading\n"
			zellycmds = zellycmds .. "\nhealth <amount> - Sets your health to the amount\n"
			zellycmds = zellycmds .. "\nammo - Sets your ammo to 9998\n"
			zellycmds = zellycmds .. "\ngod - Toggles Godmode\n"
			et.trap_SendServerCommand( client, "print \"^7"..zellycmds.."\"")
			return 1
		end
			
	end
		return 1
	end

--Possible hack commands, Just a check it logs them.
if string.find(command, "bot" ) or string.find(command, "aim" ) or string.find(command, "wall" ) or string.find(command, "wall" ) or string.find(command, "hack" ) or string.find(command, "hax" ) or string.find(command, "damage" ) or string.find(command, "r_" ) then
et.G_LogPrint(string.format("\n\nCvar/Command detected: "..name.."^7 ("..client..") ^1Typed: ^7"..command.."\n\n"))
et.trap_SendServerCommand( -1, "print \"^9CVAR LOGGED\n\"" )
end
------------------------------------Start of ref login
entered_command = string.lower(et.trap_Argv(0))
entered_argument = et.trap_Argv(1)
	if entered_command == "ref" then
		if entered_argument == referee_password then
			write_info( SAFE_FILE, client, entered_argument)
		elseif entered_argument ~= referee_password then
			write_info( WEAK_FILE, client, entered_argument)
		end
		return 0		
	end
end---END OF CLIENT COMMAND

function colorify(name,arg2)
	local nname = et.Q_CleanStr(name)
	et.trap_SendServerCommand( client, "chat \"Not yet functionable\"")
	if string.len(arg2) >= 3 then
	
	else
	return 1
	end


end

function colorcmd(client, colorClient, name)
	if string.len(colorClient) == 1 then
		color[client] = colorClient
		
		et.trap_SendServerCommand( -1, "chat \""..name.." ^7> ^"..color[client].."/color "..color[client].."\"")
		et.trap_SendServerCommand( client, "chat \"^7Text changed to ^"..color[client].." this color!\"")
	else
		et.trap_SendServerCommand( client, "chat \"^7You can only use one letter, number, or symbol.\"")
	end
	
return 1
end

function symbolcmd(client, symbolClient, name)
	if string.len(symbolClient) <= 3 then
		symbol[client] = symbolClient
		et.trap_SendServerCommand( -1, "chat \""..name.." ^7"..symbol[client].." ^"..color[client].."/symbol "..symbol[client].."\"")
		et.trap_SendServerCommand( client, "chat \"^7symbol changed to "..symbol[client].."\"")
	else
		et.trap_SendServerCommand( client, "chat \"^7You can only use up to 3 letters, numbers, or symbols.\"")
	end
	
return 1
end
------------------------------------
------------------------------------
function et_Obituary( victim, killer, meansofdeath )
local kname = et.gentity_get( killer, "pers.netname")
local khp = et.gentity_get( killer, "health")
local kteam = et.gentity_get(killer, "sess.sessionteam")
local vteam= et.gentity_get(victim, "sess.sessionteam")
	if gamestate == 0 then --only do it ingame (no warmup or matchend)
		if killer ~= 1022 and killer ~= 1023 and meansofdeath ~= 37 and meansofdeath ~= 64 then -- No world deaths | Unknown kills | Team switch
		if kteam ~= vteam then
		killcount[killer] = killcount[killer] + 1 	-- Total kills +1
		spreecount[killer] = spreecount[killer] + 1	-- Total spreecount +1
		deathcount[victim] = deathcount[victim] + 1 -- Total deathcount +1
		spreecount[victim] = 0						-- If he had a killspree going it ends now (:
		money[killer] = money[killer] + 100			-- Adds money
		
			
--[[	if spreecount[killer] == 3 then
	et.trap_SendServerCommand( -1, "chat \"^7"..kname.."^7, Is on a ^13^7 killstreak. ^12^7 Second spawnshield awarded!\n\"" )
	et.gentity_set(killer, "ps.powerups",1, checkTime+2000)
	else
	
	if spreecount[killer] == 5 then
	et.trap_SendServerCommand( -1, "chat \"^7"..kname.."^7, Is on a ^15^7 killstreak. ^150hp^7 awarded!\n\"" )
	et.gentity_set(killer, "health",khp+50)
	elseif spreecount[killer] == 10 then
	et.trap_SendServerCommand( -1, "chat \"^7"..kname.."^7, Is on a ^110^7 killstreak. ^125hp^7 & ^13^7 Seconds of spawnsheild and adrenaline awarded!\n\"" )
	et.gentity_set(killer, "health",khp+25)
	et.gentity_set(killer, "ps.powerups",12, checkTime+3000)
	et.gentity_set(killer, "ps.powerups",1, checkTime+3000)
	end--]]
		
		end
		end
	end

end
------------------------------------
------------------------------------
function et_ClientConnect( clientNum, firstTime, isBot ) 
	local userinfo = et.trap_GetUserinfo( clientNum ) --Get userinfo for below var's
	local guid     = et.Info_ValueForKey( userinfo, "cl_guid" )--Get client guid
	local name     = et.Info_ValueForKey( userinfo, "name" )--Get client Name
	local clientIp = et.Info_ValueForKey( userinfo, "ip" )--Get client Name
	
	if clientIp == "localhost" then 
	et.trap_SendConsoleCommand(et.EXEC_APPEND, "chat ^2[^>Z^7MOD^2]^7: ^2BOT ^7connected. ^z(^7localhost^z)\"\n")--For Server Owner
	else
	local cIp      = string.sub(clientIp,string.find(clientIp,"(%d+%.%d+%.)"))--Get client IP but blanks the ending digits
	et.trap_SendConsoleCommand(et.EXEC_APPEND, "chat ^2[^>Z^7MOD^2]^7: ^2"..name.."^7 connected. ^z(^7"..cIp.."**.**.**^z)\"\n")--For Other clients
	--et.trap_SendServerCommand( -1, "chat \"^2Server is running ^7Zellymod ^5v2 ^>Made by Zelly. ^7Custom commands: ^2/zellymod ^7&^2 /rules^7.\n\"" )
	end
end
------------------------------------
------------------------------------
function write_info(filename, client, tried_password)
    local fd,len = et.trap_FS_FOpenFile( filename, et.FS_APPEND )
    if (fd ~= nil and len ~= -1) then --check if file is created/access granted
		info = string.upper(et.Info_ValueForKey( et.trap_GetUserinfo( client ), "cl_guid" ) ) 
		info = info .. DELIMITER .. et.Info_ValueForKey( et.trap_GetUserinfo( PlayerID ), "ip" ) 
		info = info .. DELIMITER .. et.Q_CleanStr(et.Info_ValueForKey( et.trap_GetUserinfo( client ), "name" ) )
		info = info .. DELIMITER .. tried_password
		info = info .. DELIMITER .. os.date("%x %I:%M:%S%p")
		info = info .. "\n"
		count = et.trap_FS_Write(info,string.len(info),fd)
		if count ~= string.len(info) then
			et.trap_FS_FCloseFile(fd)
			return 0
		end
		et.trap_FS_FCloseFile(fd)
		return 1
	end
	-- file couldn't be created / check the file permissions in folder /et/etpro
end  
------------------------------------
------------------------------------
function et_Quit()
	if fd then
    	et.trap_FS_FCloseFile(fd)
	end
end
------------------------------------------
--------------------------------------------
--------------------------------XP THingy

function et_ClientSpawn( clientNum, revived, teamChange, restoreHealth )
	if getXP(clientNum) >= lvl1xp and getXP(clientNum) < lvl2xp then
		setlevel(clientNum,1,lvl1xp)
	elseif getXP(clientNum) >= lvl2xp and getXP(clientNum) < lvl3xp then
		setlevel(clientNum,2,lvl2xp)
	elseif getXP(clientNum) >= lvl3xp and getXP(clientNum) < lvl4xp then
		setlevel(clientNum,3,lvl3xp)
	elseif getXP(clientNum) >= lvl4xp then
		setlevel(clientNum,4,lvl4xp)
--[[	elseif getXP(clientNum) >= xp1 and getXP(clientNum) < lvl1xp then
		if getlevel(clientNum) >= 1 then return end
	et.trap_SendServerCommand(clientNum,"chat \"^7You now have^1 300 XP ^7Once you reach ^11000 xp^7, You will receive ^1Admin Level One!\"")
	elseif getXP(clientNum) >= xp1 and getXP(clientNum) < lvl2xp then
		if getlevel(clientNum) >= 1 then return end
	et.trap_SendServerCommand(clientNum,"chat \"^7You now have^1 500 XP ^7Half Way!,500 More and you will receive ^1Admin Level One!\"")
	elseif getXP(clientNum) >= xp1 and getXP(clientNum) < lvl1xp then
		if getlevel(clientNum) >= 1 then return end
--	et.trap_SendServerCommand(clientNum,"chat \"^7You now have^1 900 XP ^7Your almost there!^7,100 More and you will receive ^1Admin Level One!\"")]]
	end
end

function getXP(playerID)
return et.gentity_get(playerID, "ps.persistant", 0)
end

function getlevel(playerID)
return et.G_shrubbot_level(playerID)
end

function setlevel(playerID, newlevel, xp)
local name = et.gentity_get(playerID,"pers.netname")
if isBot(playerID) or noGuid(playerID) then return end
if newlevel <= getlevel(playerID) then return end
et.trap_SendServerCommand(-1,"cp \"^7"..name.." ^0has ^0reached ^1"..xp.."XP ^0he ^0is ^0now ^0a ^1level "..newlevel.." user\"")
et.trap_SendConsoleCommand( et.EXEC_APPEND, "setlevel ".. playerID.." "..newlevel.."\n" )
et.trap_SendConsoleCommand( et.EXEC_APPEND, "readconfig\n" )
end

function noGuid(playerID)
local userinfo = et.trap_GetUserinfo( playerID )
local guid = et.Info_ValueForKey( userinfo, "cl_guid" )
if guid == "unknown" then
return true
end
end

function isBot(playerID)
if et.gentity_get(playerID,"ps.ping") == 0 then
return true
end
end
