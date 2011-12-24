--Zombie Lua Attempt # 33839712
--Lots of re organizing to do.
--For now I am focusing on getting everything that is not related to the Zombiemod in.
--Small todoList
--All Zombie stuff
--Console command: Time
--Console command: Rules(For shrubbot as well)
					--Along with website command and others.
--[[

		Do Console Commands in general!!
		
		]]--


Modname="Zellymod.lua"

Version="v3.9"

--Global Variables

---
kill = { }
death = { }
spree = { }
admin = { }
kdr = { }
ping = { }
save = { }
chat = { }
color = { }
symbol = { }
noGuid = { }
banned_guids = {
}
banned_ips = {
}


banned_message = "Sorry you weren't able to connect."
mod_info = Modname .. Version
help_text = "login,logout,ping,pingother,god,save,load,bring,goto And more to come :P"
admin_password = "cheesus"
---
--Rules
---
NUM_RULES = 3
rules = {
"Respect Everyone",
"No hacks",
"Dont ask for admin"
}
---

function et_InitGame(levelTime,randomSeed,restart)
	et.RegisterModname(Modname .. " " .. Version)
	et.trap_SendServerCommand( -1, "chat \"^2Server is running ^1"..Modname.." ^2 Version ^1"..Version.."\n\"")
	referee_password = et.trap_Cvar_Get("refereePassword")
	rcon_password = et.trap_Cvar_Get("rconPassword")
	gamestate = tonumber(et.trap_Cvar_Get( "gamestate" )) -- Get the gamestate -> warmup, match, matchend
	maxclients = tonumber( et.trap_Cvar_Get( "sv_maxClients" ) ) -- Get Max Clients
	mapname = et.trap_Cvar_Get( "mapname" ) --Gets the name of map
	beginTime=levelTime
	local currentver = et.trap_Cvar_Get("mod_version")
	et.trap_SendConsoleCommand(et.EXEC_APPEND, "forcecvar mod_version \"" .. currentver .. " - ZMOD" .. Version .. "\"" .. "\n" )
	for z = 0, maxclients - 1 do
		kill[z] = 0
		death[z] = 0
		spree[z] = 0
		admin[z] = false
		kdr[z] = 0
		chat[z] = false
		color[z] = 2
		symbol[z] = ":"
	end
end


function et_ClientCommand(client, command)

	arg0 = string.lower(et.trap_Argv(0)) -- Get First command
	arg1 = string.lower(et.trap_Argv(1)) -- Get Second Command
	arg2 = string.lower(et.trap_Argv(2)) -- Etc.
	arg3 = string.lower(et.trap_Argv(3))
	arg4 = string.lower(et.trap_Argv(4))
	arg5 = string.lower(et.trap_Argv(5))
	arg6 = string.lower(et.trap_Argv(6))
	arg7 = string.lower(et.trap_Argv(7))
	arg8 = string.lower(et.trap_Argv(8))
	
	--New Chat
	if (arg0 == "say") then
		if (chat[client]) then
			local message = et.ConcatArgs(1)
			local name = et.gentity_get(client,"pers.netname")
			if (admin[client]) then
				et.trap_SendServerCommand( -1, "chat \"^7[^"..color[client].."Admin^7]"..name.."^7"..symbol[client].."^"..color[client].." "..message.."\"")
			else
				et.trap_SendServerCommand( -1, "chat \""..name.."^7"..symbol[client].."^"..color[client].." "..message.."\"")
			end
		end
	end
	
	if (arg0 == "color") then
		local arg1 = tonumber(arg1)
		if (arg1 == nil or arg1 == "") then
			return "Missing argument one(numberplease)"
		else
			color[client] = arg1
			return 1
		end		
	end
	if (arg0 == "symbol") then
		if (arg1 == nil or arg1 == "") then
			return "Missing argument one(numberplease)"
		else
			if (strlen(arg1 > 4)) then
				return "Too Long"
			else
				symbol[client] = arg1
			return 1
			end
		end		
	end
	
	--Calculator
	if (arg0 == "say") and (arg1 == "||") then
		local x = tonumber(arg2)
		local s = arg3
		local y = tonumber(arg4)
		local z;
		
		if (s == "+") then
			z=x+y
		elseif (s == "-") then
			z=a-y
		elseif (s == "*") then
			z=x*y
		elseif (s == "/") then
			z=x/y
		else
			z=nil
		end
		
		if (z ~= nil) then
			et.trap_SendServerCommand( -1, "chat \"^5| ^7Your Answer to "..x..""..s..""..y.." is "..z.." ^5|\"")
		else
			et.trap_SendServerCommand( -1, "chat \"^5| ^7Your input was invalid here is an example: || 2 + 2 ^5|\"")
		end
		return 0
	end
	
	---RageQuit
	if (arg0 == "ragequit") or (arg0 == "rage") or (arg0 == "rq") then
		local quitTime = 30
		local reason = "^1You ragequitted from the server you will not be able to connect for another: "..quitTime.." Seconds."
		local name = et.gentity_get(client, "pers.netname")
		et.trap_DropClient( client, reason, 10 )
		et.trap_SendServerCommand( -1, "chat \"^1"..name.."^1 RAGE QUITTED HAHA!\"")
		et.trap_SendServerCommand( -1, "cpm \"^1"..name.."^1 RAGE QUITTED HAHA!\"")
		et.trap_SendServerCommand( -1, "cp \"^1"..name.."^1 RAGE QUITTED HAHA!\"")
		return 1
	end
	
	if (arg0 == "time") then
		local todayDate = os.date("Today is %A, the %d of %B (%I:%M %p)")
		et.trap_SendServerCommand( client, "chat \"^7[^2"..todayDate.."^7]\"")
		return 1
	end
	
	if (arg0 == "zellymod") or (arg0 == "mod") or (arg0 == "zombiemod") or (arg0 == "zmod") or (arg0 == "info") then
		et.trap_SendServerCommand( client, "print \""..mod_info.."\"")
		return 1
	end
	
	if (arg0 == "zelly") then
		if (arg1 == nil) or (arg1 == "") then
			if (admin[client]) then
				et.trap_SendServerCommand( client, "print \""..help_text.."\"")
			else
				et.trap_SendServerCommand( client, "print \"Im sorry you need to be logged in.\"")
			end
		else
			if (arg1 == "login") then
				if (admin[client]) then
					et.trap_SendServerCommand( client, "print \"You are already logged in, you can logout with logout command.\"")
				else
					if (arg2 == nil) or (arg2 == "") then
						et.trap_SendServerCommand( client, "print \"You need to supply a password, as well. Ex. zelly login password\"")
					elseif (arg2 == admin_password) then	
						et.trap_SendServerCommand( client, "print \"Password is correct, type zelly to list commands.\"")
						admin[client] = true
					else
						et.trap_SendServerCommand( client, "print \"Password incorrect, Please get your information correct.\"")
					end
				end	
			elseif (arg1 == "logout") then
				admin[client] = false
			elseif (arg1 == "ping") then
				if (arg2 == nil) or (arg2 == "") then
					et.trap_SendServerCommand( client, "print \"ping: ping #number#\n#number# being the amount of ping you desire.\nNote: this is only for show, and dose not actually affect your ping.\"")
				else
					if (tonumber(arg2) == nil) or (tonumber(arg2)== "") then
						et.trap_SendServerCommand( client, "print \"Must be a number.\"")
					else
						ping[client] = tonumber(arg2)
						et.gentity_set(client, "ps.ping",tonumber(arg2))
					end
				end
			elseif (arg1 == "pingother") then
				if (arg2 == nil) or (arg2 == "") then
					et.trap_SendServerCommand( client, "print \"pingother: pingother #client# #number#\n#client# being the client id of the selected player\n#number# being the amount of ping you desire.\nNote: this is only for show, and dose not actually affect your ping.\"")
				else
					if (tonumber(arg2) == nil) or (tonumber(arg2)== "") then
						et.trap_SendServerCommand( client, "print \"Client must be a number.\"")
					else
						if (tonumber(arg3) == nil) or (tonumber(arg3)== "") then
							et.trap_SendServerCommand( client, "print \"Ping must be a number.\"")
						else
							ping[tonumber(arg2)] = tonumber(arg3)
						end
					end
				end
			elseif (arg1 == "god") then
				if (et.gentity_get(client, "takedamage") ~= 0) then
					et.gentity_set(client, "takedamage",0)
					et.trap_SendServerCommand( client, "print \"^7God Mode Enabled\"")
				else
					et.gentity_set(client, "takedamage",1)
					et.trap_SendServerCommand( client, "print \"^7God Mode Disabled\"")
				end
			elseif (arg1 == "save") then
				save[client] = et.gentity_get(client,"r.currentOrigin") 
				et.trap_SendServerCommand( client, "cpm \"^7___^5Saved^7___\"")
			elseif (arg1 == "load") then
				et.gentity_set( client, "origin", save[client] ) 
				et.trap_SendServerCommand( client, "cpm \"^7___^5Loaded^7___\"")
			elseif (arg1 == "goto") then
				local error_text = "Invalid client ID in argument #2"
				if (arg2 == nil) or (arg2 == "") then
					return error_text
				end
				local gotoClient = tonumber(arg2)
				local gotoName = et.gentity_get(gotoClient, "pers.netname")
				local gotoOrigin = et.gentity_get(gotoClient,"r.currentOrigin")
				local Name = et.gentity_get(client, "pers.netname")
				et.gentity_set( client, "origin", gotoOrigin )
				et.trap_SendServerCommand( client, "cpm \"^5Going to "..gotoName.."^7\"")
				et.trap_SendServerCommand( gotoClient, "cpm \"^7"..Name.."^5 went to you.^7\"")
			elseif (arg1 == "bring") then
				local error_text = "Invalid client ID in argument #2"
				if (arg2 == nil) or (arg2 == "") then
					return error_text
				end
				local bringClient = tonumber(arg2)
				local bringName = et.gentity_get(bringClient, "pers.netname")
				local clientOrigin = et.gentity_get(client,"r.currentOrigin")
				local Name = et.gentity_get(client, "pers.netname")
				et.gentity_set( bringClient, "origin", clientOrigin )
				et.trap_SendServerCommand( client, "cpm \"^5Going to "..bringName.."^7\"")
				et.trap_SendServerCommand( bringClient, "cpm \"^7You are being brought to "..Name.."^7\"")
			end
		end
	return 1
	end
	---Small Hack detection
	
	if (string.find(arg0, "aim")) or (string.find(arg0, "bot")) or (string.find(arg0, "wall")) or (string.find(arg0, "hack")) or (string.find(arg0, "string")) or (string.find(arg0, "hax")) then
		et.G_LogPrint(string.format("\n\nCvar/Command detected: "..name.."^7 ("..client..") ^1Typed: ^7"..arg0.."\n\n"))
	end
	
	if (arg0 == "ref") and (arg1 ~= string.lower(referee_password)) then
		et.G_LogPrint(string.format("\n\nCvar/Ref Attempt: "..name.."^7 ("..client..") ^1Typed: ^7"..arg0.." "..arg1.."\n\n"))
	end
	if (arg0 == "rcon") and (arg1 ~= string.lower(rcon_password)) then
		et.G_LogPrint(string.format("\n\nCvar/Ref Attempt: "..name.."^7 ("..client..") ^1Typed: ^7"..arg0.." "..arg1.."\n\n"))
	end
end

--[[function et_ConsoleCommand()
	local arg0 = string.lower(et.trap_Argv(0))
	local arg1 = string.lower(et.trap_Argv(1))
	local arg2 = string.lower(et.trap_Argv(2))
	
end--]]

function et_ClientConnect( clientNum, firstTime, isBot ) 
	local userinfo = et.trap_GetUserinfo( clientNum ) --Get userinfo for below var's
	local guid     = string.lower(et.Info_ValueForKey( userinfo, "cl_guid" ))--Get client guid
	local name     = et.Info_ValueForKey( userinfo, "name" )--Get client Name
	local clientIp = et.Info_ValueForKey( userinfo, "ip" )--Get client Name
	if clientIp == "localhost" then 
	et.trap_SendConsoleCommand(et.EXEC_APPEND, "chat ^2[^>Z^7MOD^2]^7: ^2BOT ^7connected. ^z(^7localhost^z)\"\n")--For BOTS
	else
	local cIp      = string.sub(clientIp,string.find(clientIp,"(%d+%.%d+%.)"))--Get client IP but blanks the ending digits
	et.trap_SendConsoleCommand(et.EXEC_APPEND, "chat ^2[^>Z^7MOD^2]^7: ^2"..name.."^7 connected. ^z(^7"..cIp.."**.**.**^z)\"\n")--For Other clients
	end
	
	if (guid == "noguid") or (guid == "no_guid") or (guid == "unknown") or (guid == "") then
		noGuid[clientNum] = true
	end
	if (guid == banned_guids) or (clientIp == banned_ips) then
		return banned_message
	end
end


function et_Obituary( victim, killer, meansofdeath )
	local kname = et.gentity_get( killer, "pers.netname")
	local vname = et.gentity_get( victim, "pers.netname")
	local khp = et.gentity_get( killer, "health")
	local kteam = et.gentity_get(killer, "sess.sessionteam")
	local vteam= et.gentity_get(victim, "sess.sessionteam")

	if (gamestate == 0) then
		if (victim ~= killer) and (vteam ~= kteam) then
			kill[killer] = kill[killer] + 1
			death[victim] = death[victim] + 1
			spree[killer] = spree[killer] + 1
			spree[victim] = 0
			kdr[killer] = (kill[killer]/death[killer])
			kdr[victim] = (kill[victim]/death[victim])
			digits = 2		-- you want 1 digit after the decimal point
			 
			shift = 10 ^ digits
			kdr[killer] = math.floor( kdr[killer]*shift + 0.5 ) / shift
			kdr[victim] = math.floor( kdr[killer]*shift + 0.5 ) / shift
			et.trap_SendServerCommand( killer, "cpm \"You are on a "..spree[killer].." killingspree.\"")
			et.trap_SendServerCommand( killer, "cpm \"Your total kills are: "..kill[killer]..". Total deaths are: "..death[killer]..". Your KDR is "..kdr[killer].."\"")
			et.trap_SendServerCommand( victim, "cpm \"Your total kills are: "..kill[victim]..". Total deaths are: "..death[victim]..". Your KDR is "..kdr[victim].."\"")
			if (spree[killer] == 3) then
				et.trap_SendServerCommand( -1, "chat \"^1"..kname.." ^2Is on a 3 Killspree.\"")
			elseif (spree[killer] == 5) then
				et.trap_SendServerCommand( -1, "chat \"^1"..kname.." ^2Is on a 5 Killspree.\"")
			elseif (spree[killer] == 10) then
				et.trap_SendServerCommand( -1, "chat \"^1"..kname.." ^2Is on a 10 Killspree.\"")
			end
		end
	end
end

function et_RunFrame( levelTime )
	for z = 0, maxclients - 1 do
		if (ping[z] ~= nil) then
			et.gentity_set(z, "ps.ping",ping[z])
		end
	end

end