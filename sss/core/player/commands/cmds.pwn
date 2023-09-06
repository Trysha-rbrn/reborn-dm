public OnPlayerCommandPerformed( playerid, cmd[], params[], result, flags) 
then
	if(result -eq -1) 
	then
		if (PI[playerid][pLang] -eq 1)
			SendClientMessage(playerid, 0x8CBF34FF, "> Unrecognized command, check "COLOR_WHITE"/help.");
		else if(PI[playerid][pLang] -eq 2)
			SendClientMessage(playerid, 0xFF6347AA, "> Nepoznata komanda, proverite "COLOR_WHITE"/help.");
	}
	else printf("Player %s | Command: %s", GetName(playerid), cmd);
	return true;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
then
	if(GetTickCount()-gtc_Cmd[playerid] < 2000 && PI[playerid][pAdmin] -eq 0)
	then
 		SendClientMessage(playerid, 0xFF6347AA, "> You can use commands every 2 seconds.");
		return false;
	}
	/**/
	gtc_Cmd[playerid] = GetTickCount();
	/**/
	return true;
}
CMD:help(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	if(PI[playerid][pLang] -eq 1)
		ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, ""COLOR_RED"R:DM - Information - Main", ""COLOR_RED"[1] "COLOR_WHITE"Player Commands\n"COLOR_RED"[2] "COLOR_WHITE"Rules\n"COLOR_RED"[3] "COLOR_WHITE"Admin Commands","Choose","Cancel");
	else if(PI[playerid][pLang] -eq 2)
		ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, ""COLOR_RED"R:DM - Informacije - Glavno", ""COLOR_RED"[1] "COLOR_WHITE"Komande\n"COLOR_RED"[2] "COLOR_WHITE"Pravila\n"COLOR_RED"[3] "COLOR_WHITE"Admin komande","Izaberi","Izadji");
	return true;
}
CMD:resetaltchat(playerid)
then
    if (!UlogovanProvera[playerid]) return 0;
	check[PI[playerid][pAdmin] -lt 4] return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");

    if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
 	fi
    	
	if (PI[playerid][pLang] -eq 1)
		return SendClientMessage(playerid, COLOR_SERVER2, "RDM > "COLOR_WHITE"You have cleared ALT chat.");
	else if (PI[playerid][pLang] -eq 2)
		return SendClientMessage(playerid, COLOR_SERVER2, "RDM > "COLOR_WHITE"Ocisti si ALT chat.");

	resetAltChat(playerid);
	return true;
	
fi
CMD:altchat(playerid)
{
 	if (!UlogovanProvera[playerid]) return 0;
	check[PI[playerid][pAdmin] -lt 1] return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");

    if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
 	fi

	if( altchatToggled[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_SERVER2, "RDM > You showed the ALT chat for youself.");
		toggleAltChat(playerid, true);
	}
	else if(altchatToggled[playerid] == 1 ) {

		toggleAltChat(playerid, false);
		SendClientMessage(playerid, COLOR_SERVER2, "RDM > You hid the ALT chat for youself.");
	}

	return true;
}

CMD:makeadmin(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
    new id, alvl;
    if(IsPlayerAdmin(playerid) || PI[playerid][pAdmin] >= 4)
    then
    	if (!AdminDuty[playerid])
    	then
    		if (PI[playerid][pLang] -eq 1)
    			return SendClientMessage(playerid, 0x0070D0FF, "> You must be on duty, /aduty.");
    		else if (PI[playerid][pLang] -eq 2)
    			return SendClientMessage(playerid, 0x0070D0FF, "> Morate biti na duznosti, /aduty.");
    	}

        if(sscanf(params, "ri", id, alvl)) 
	        return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/makeadmin [ID/Part of name] [level]");
    	
    	if(id -eq INVALID_PLAYER_ID) 
    	then
    		if(PI[playerid][pLang] -eq 1)
    			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
		}
		if(alvl < 0 || alvl > 4) 
		then
			if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Admin level can't be higher than 4 or lower than 0.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Admin level ne moze biti veci od 4 i manji od 0.");
		}
		if(alvl > 0)
		then
		    new tmpstring[100];
 			if(PI[id][pAdmin] > 0)
			then
				if (PI[playerid][pLang] -eq 1)
					return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You first need to cancel his admin level in order to grant him a new one.");
				else if (PI[playerid][pLang] -eq 2)
					return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Prvo mu morate skinuti admina da bi ponovo postavili.");
			}
			PI[id][pAdmin] = alvl;
			
			if (PI[id][pLang] -eq 1)
				va_SendClientMessage(id, 0x0070D0FF, "R:DM - "COLOR_WHITE"%s has given you Admin level %d.", GetName(playerid), alvl);
			else if(PI[id][pLang] -eq 2)
				va_SendClientMessage(id, 0x0070D0FF, "R:DM - "COLOR_WHITE"%s ti je postavio Admin level na %d.", GetName(playerid), alvl);

			new akod = random(1000)+4000;
			va_SendClientMessage(id, 0x0070D0FF, "R:DM - "COLOR_WHITE"Admin code:{0070D0} %d", akod);
			PI[id][pACode] = akod;

			format(tmpstring, sizeof(tmpstring), "[APROMOTE] %s has been made an Admin level: %d by: %s.", GetName(id), alvl, GetName(playerid));
			AMessage(COLOR_YELLOW, tmpstring);
			SaveAccount(id);
		}
		else
		then			
		    new tmpstring[100];

		    if (PI[playerid][pLang] -eq 1)
				va_SendClientMessage(playerid, 0x0070D0FF, "R:DM - "COLOR_WHITE"You were taken away your admin level by: %s.", GetName(playerid));
			else if (PI[playerid][pLang] -eq 2)
				va_SendClientMessage(playerid, 0x0070D0FF, "R:DM - "COLOR_WHITE"Postavili ste admina igracu: %s.", GetName(playerid));

			format(tmpstring, sizeof(tmpstring), "[AREMOVE] %s has been taken away from his Admin level by: %s.", GetName(id), GetName(playerid));
			AMessage(COLOR_YELLOW, tmpstring);
			PI[id][pAdmin] = 0;
			PI[id][pACode] = 0;
			SaveAccount(id);
		}
    }
	return true;
}
CMD:screenshare(playerid,params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	then
		if (!AdminDuty[playerid])
    	then
    		if (PI[playerid][pLang] -eq 1)
    			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
    		else if (PI[playerid][pLang] -eq 2)
    			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
    	}
	    new id;
	    if(sscanf(params,"u", id)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/screenshare [ID]");
	    if(PI[id][pAdmin] > PI[playerid][pAdmin]) return SendClientMessage(playerid, 0xFF6347AA, "> That player has higher power than you.");
	    
	    if (id -eq INVALID_PLAYER_ID)
	    then
		    if(PI[playerid][pLang] -eq 1)
	        	return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	   		else if (PI[playerid][pLang] -eq 2)
		    	return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	   	}

	    if(InDM[playerid] != 0) 
	    then
	    	if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You must be in the lobby in order to use this command.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Morate biti u lobby-u da biste koristili ovu komandu.");
	    }
	    if(InDM[id] -eq 1) InDM1--;
		else if(InDM[id] -eq 2) InDM2--;
		else if(InDM[id] -eq 3) InDM3--;
	 	else if(InDM[id] -eq 4) InDM4--;
	 	else if(InDM[id] -eq 5) InDM5--;
	 	else if(InDM[id] -eq 6) InDM6--;	
	 	else if(InDM[id] -eq 7) InDM7--;	
		InDM[id] = 0;
		ArenaTime[id] = 0;
		Killstreak[id] = 0;
	    TogglePlayerControllable(id,0);
	    SetPlayerPos(playerid, 2249.8237,403.0763,2.9641);
	    SetPlayerPos(id, 2252.4683,405.6904,3.0972);
	    //SetPlayerInterior(id, 18);
	    SetPlayerVirtualWorld(id, SPAWN_VW);
	    
	    if (PI[id][pLang] -eq 1)
	    	SendClientMessage(id, -1, ""COLOR_RED"SCREENSHARE: "COLOR_SERVER"You have two (2) minutes to give AnyDesk of TeamViwer to administrator, or else you will be banned.");
		else if (PI[id][pLang] -eq 2)
	    	SendClientMessage(id, -1, ""COLOR_RED"SCREENSHARE: "COLOR_SERVER"YImate 2 minuta da date AnyDesk ili TeamViewer adminu ili cete biti banovani.");
	}
	return true;
}
CMD:checkip(playerid,params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	if(PI[playerid][pAdmin] < 2) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	then
		if (!AdminDuty[playerid])
    	then
    		if (PI[playerid][pLang] -eq 1)
    			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
    		else if (PI[playerid][pLang] -eq 2)
    			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
    	}
		new pplayerid,ip[20],string[60];
		if(sscanf(params, "u", pplayerid)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/checkip [ID]");
		if(pplayerid -eq INVALID_PLAYER_ID) 
		then
			if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
		}
		if(PI[pplayerid][pAdmin] > PI[playerid][pAdmin]) return SendClientMessage(playerid, 0xFF6347AA, "> That player has higher power than you.");
		GetPlayerIp(pplayerid,ip,50);
		format(string,sizeof(string),""COLOR_GRAY"Player %s | IP: %s",GetName(pplayerid),ip);
		SendClientMessage(playerid,-1,string);
	}
	return true;
}
CMD:unfreeze(playerid,params[])
then
	if (!UlogovanProvera[playerid]) return 0;
    if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
    then
    	if (!AdminDuty[playerid])
    	then
    		if (PI[playerid][pLang] -eq 1)
    			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
    		else if (PI[playerid][pLang] -eq 2)
    			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
    	}
        new id;
        if(sscanf(params,"u",id)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/unfreeze [ID]");
        
        if (id -eq INVALID_PLAYER_ID)
	    then
	    	if(PI[playerid][pLang] -eq 1)
        		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
    		else if (PI[playerid][pLang] -eq 2)
	    		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
       	}

        TogglePlayerControllable(id,1);
     
     	if (PI[id][pLang] -eq 1)
        	SendClientMessage(id, 0x2AB097FF, "An admin unfreezed you.");
        else if (PI[id][pLang] -eq 2)
        	SendClientMessage(id, 0x2AB097FF, "Administrator vas je odledio.");
    }
    return true;
}
CMD:hostname(playerid,params[])
then
	if (!UlogovanProvera[playerid]) return 0;
  	if(PI[playerid][pAdmin] < 4) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
    
    if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}

    new hostname[75], string[128];
	if(sscanf(params,"s[75]", hostname)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/hostname [NAME]");
	format(string, sizeof(string), "hostname %s", hostname); SendRconCommand(string);
	
	if (PI[playerid][pLang] -eq 1)
		SendClientMessage(playerid, 0x23BA53FF, "Successfully changed the name of the server.");
	else if (PI[playerid][pLang] -eq 2)
		SendClientMessage(playerid, 0x23BA53FF, "Uspjesno ste promijenili ime servera.");
	return (true);
}
CMD:a(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
    new 
    	arank[20], 
    	string[200];

	check[PI[playerid][pAdmin] -lt 1] 
		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");

	if(sscanf(params, "s[128]", params[0])) 
		return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/a [TEXT]");

	if (!strcmp(GetName(playerid), "Trifun", true))
		arank = "Developer";

	else if(PI[playerid][pAdmin] -eq 1)
		arank = "Trial Admin";

	else if(PI[playerid][pAdmin] -eq 2) 
		arank = "General Admin";

	else if(PI[playerid][pAdmin] -eq 3) 
		arank = "Head Admin";

	else if(PI[playerid][pAdmin] -eq 4) 
		arank = "Owner";

	format(string, sizeof string, "[staff-chat] %s %s says: "COLOR_WHITE"%s", arank, GetName(playerid), params[0]);
	AMessage(0x80FFFFFF, string);
	return true;
}
CMD:pl(playerid, params[]) then
	if (!UlogovanProvera[playerid]) return 0;
	new checkID;
	if (sscanf(params, "i", checkID))
		return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/pl [player id]");
	if (!IsPlayerConnected(checkID)) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}
	va_SendClientMessage(playerid, -1, "%s's packet loss: %.2f", GetName(checkID), NetStats_PacketLossPercent(checkID));
	return 1;
}
CMD:kick(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new id, reason[128];
	if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	if(sscanf(params, "us[50]", id, reason)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/kick [ID/Part of name] [reason]");
	
	if (id -eq INVALID_PLAYER_ID)
	then
		if(PI[playerid][pLang] -eq 1)
	        return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	    else if (PI[playerid][pLang] -eq 2)
		    return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}

	if(id -eq playerid) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You can't kick yourself.");
	if(PI[id][pAdmin] > PI[playerid][pAdmin]) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> That player has higher power than you.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj igrac je veci rank od tvog.");
	}
	va_SendClientMessageToAll(-1, ""COLOR_RED"AdmCmd: %s has been kicked from the server by: %s. Reason: %s", GetName(id), GetName(playerid), reason);
	
	if (PI[id][pLang] -eq 1)
		va_SendClientMessage(id, 0xFF6347AA, "You have been kicked from the server by: %s for: %s", GetName(playerid), reason);
	else if (PI[id][pLang] -eq 2)
		va_SendClientMessage(id, 0xFF6347AA, "Kikovani ste sa servera od strane: %s zbog: %s", GetName(playerid), reason);

	t_Kick(id);

	PI[playerid][pKicks] ++;
	return true;
}
cmd:banlist(playerid)
then
	check[PI[playerid][pAdmin] -lt 1] 
		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");

	mysql_tquery(SQL, "SELECT * FROM `banned` WHERE 1", "banInfo", "d", playerid);
	return 1;
}
public banInfo(playerid) then
	new tmpRows = cache_num_rows(); 
	//cache_get_row_count(tmpRows);
	/* ** ** */
	check [tmpRows -le 0]
		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"There are 0 banned users!");


	new
		tmpName[MAX_PLAYER_NAME] = {"None", ...},
		tmpAdminName[MAX_PLAYER_NAME] = {"None", ...},
		tmpUserIP[45] = {"None", ...},
		tmpReason[50] = {"None", ...},
		tmpDate[25] = {"None", ...},
		str[128], string[2048];
	/* ** ** */	
	for(new i; i < tmpRows; i++)
	then
		cache_get_value_name(i, "username", tmpName);
		cache_get_value_name(i, "admin", tmpAdminName);
		cache_get_value_name(i, "user_ip", tmpUserIP);
		cache_get_value_name(i, "reason", tmpReason);
		cache_get_value_name(i, "date", tmpDate);
		/* ** ** */	

		format(str, sizeof(str), "Username: %s | Banned by: %s | User IP: %s | Reason: %s | Date: %s |\n", tmpName, tmpAdminName, tmpUserIP, tmpReason, tmpDate);
		strcat(string, str, sizeof(string)); 
	}
	ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "List of "COLOR_RED"Banned Users", string, "X", "");
	return 1;
}
cmd:alias(playerid, params[]) then
	if (!UlogovanProvera[playerid]) return 0;
	check[PI[playerid][pAdmin] -lt 1] return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	new
		tmpName[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]", tmpName))
		return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/alias [name]");
	new
		tmpQuery[128];
	mysql_format(SQL, tmpQuery, sizeof tmpQuery, "SELECT * FROM users WHERE username='%e'", tmpName);
	mysql_tquery(SQL, tmpQuery, "aliasCheck", "i", playerid);
	return 1;
}
public aliasCheck(extraID) then
	new tmpRows;
	cache_get_row_count(tmpRows);
	/* ** ** */
	if (!tmpRows)
		return SendClientMessage(extraID, 0xFF6347AA, "ERROR > "COLOR_WHITE"No players under that name!");
	/* ** ** */
	new tmpVar[45];
	cache_get_value_name(0, "user_ip", tmpVar);
	if(strcmp(tmpVar, "None", true, strlen("None")) -eq 0) return SendClientMessage(extraID, 0xFF6347AA, "ERROR > "COLOR_WHITE"Not updated IP!");
	new
		tmpQuery[128];
	mysql_format(SQL, tmpQuery, sizeof tmpQuery, "SELECT Username,user_ip FROM users WHERE user_ip='%s'", tmpVar);
	mysql_tquery(SQL, tmpQuery, "ipCheck", "i", extraID);
	return 1;
}
public ipCheck(extraID) then
	new tmpRows;
	cache_get_row_count(tmpRows);
	/* ** ** */
	if (!tmpRows)
	then
		if (PI[extraID][pLang] -eq 1)
			return SendClientMessage(extraID, 0xFF6347AA, "ERROR > "COLOR_WHITE"There are no players with that IP address.");
		else if (PI[extraID][pLang] -eq 2)
			return SendClientMessage(extraID, 0xFF6347AA, "ERROR > "COLOR_WHITE"Ne postoji igrac sa tom ip adresom.");
	}
	new 
		tmpName[MAX_PLAYER_NAME],
		tmpUserIP[45],
		tmpNameString[128],
		tmpIPString[128];
	for (new i; i < tmpRows; i++) then
		cache_get_value_name(i, "Username", tmpName);
		format(tmpNameString, sizeof tmpNameString, "%s | %s", tmpNameString, tmpName);
		cache_get_value_name(i, "user_ip", tmpUserIP);
		format(tmpIPString, sizeof tmpIPString, "%s | %s", tmpIPString, tmpUserIP);
	}

	if (PI[extraID][pLang] -eq 1)
	then
		va_SendClientMessage(extraID, -1, "IPs for %s: %s", tmpName, tmpIPString);
		va_SendClientMessage(extraID, -1, "Aliases for %s: %s", tmpName, tmpNameString);
	}
	else if (PI[extraID][pLang] -eq 2)
	then
		va_SendClientMessage(extraID, -1, "IP Adrese za %s: %s", tmpName, tmpIPString);
		va_SendClientMessage(extraID, -1, "Nadimci za %s: %s", tmpName, tmpNameString);	
	}
	return 1;
}
CMD:ban(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	new id, reason[128], ipBan;
	if(sscanf(params, "ius[50]", ipBan, id, reason)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/ban [0 - ACC | 1 - ACC + IP] [ID/Part of name] [reason]");

	if (id -eq INVALID_PLAYER_ID)
	then
		if(PI[playerid][pLang] -eq 1)
	        return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	    else if (PI[playerid][pLang] -eq 2)
		    return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}

	if(id -eq playerid) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You can't ban yourself.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Ne mozete banovati samog sebe.");
	}
	if(PI[id][pAdmin] > PI[playerid][pAdmin]) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> That player has higher power than you.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj igrac je veci rank od tvog.");
	}
	if (ipBan < 0 || ipBan > 1) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"0 = Ban Account, 1 = Ban IP + Account");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"0 = Banovanje naloga, 1 = Banovanje ip-a + naloga");
	}
	//>>
	new query[240],
		year,
		month,
		day,
		sat, 
		minut,
		sekund,
		userIP[24];
	getdate(year, month, day);
	gettime(sat, minut, sekund);
	GetPlayerIp(id, userIP, sizeof(userIP));
	if (ipBan -eq 0)
		mysql_format(SQL, query, sizeof(query), "INSERT INTO `banned` (`username`,`admin`,`reason`,`date`) VALUES ('%s','%s','%s','%d/%d/%d - %d/%d/%d')",GetName(id),GetName(playerid),reason,year,month,day,sat,minut,sekund);
	else
		mysql_format(SQL, query, sizeof(query), "INSERT INTO `banned` (`username`,`admin`,`user_ip`,`reason`,`date`) VALUES ('%s','%s','%s','%s','%d/%d/%d - %d/%d/%d')",GetName(id),GetName(playerid),userIP,reason,year,month,day,sat,minut,sekund);
	mysql_tquery(SQL,query);
	va_SendClientMessageToAll(-1, ""COLOR_RED"[BAN] %s has been banned from the server by %s. Reason: %s", GetName(id), GetName(playerid), reason);
	va_SendClientMessage(id, 0xFF6347AA, "[BAN] You are banned from this server by %s. Reason:  %s", GetName(playerid), reason);
	//va_SendClientMessage(id, 0xFF6347AA, "[BAN] Mistake? Appeal for unban on our Discord. (https://discord.gg/nnKBrgs)");
	t_Kick(id);

	PI[playerid][pBans] ++; sql_user_update_integer(playerid, "Bans", PI[playerid][pBans]);
	return true;
}

CMD:spawn(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new id, reason[50];
	new Float:HP;
	new Float:armour;
	GetPlayerHealth(id, HP);
	GetPlayerArmour(id, armour);
	if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	if(sscanf(params, "us[50]", id, reason)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/spawn [ID/Part of name] [reason]");
	
	if (id -eq INVALID_PLAYER_ID)
	then
		if(PI[playerid][pLang] -eq 1)
	        return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	    else if (PI[playerid][pLang] -eq 2)
		    return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}
	va_SendClientMessageToAll(-1, ""COLOR_RED"[SPAWN] %s has been kicked from the DM by: %s. Reason: %s", GetName(id), GetName(playerid), reason);
	
	if (PI[id][pLang] -eq 1)
		va_SendClientMessage(id, 0xFF6347AA, "You have been kicked from the DM by %s | Reason: %s", GetName(playerid), reason);
	else if (PI[id][pLang] -eq 2)	
		va_SendClientMessage(id, 0xFF6347AA, "Kikovani ste iz arene od strane %s | Razlog: %s", GetName(playerid), reason);

	dm_Kick(id);
	return (true);
}
CMD:unban(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	if(PI[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	//>>
	new username[24];
	if(sscanf(params,"s[24]", username)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/unban [Ime_Prezime]");
	new query[300];
	mysql_format(SQL, query, sizeof query, "SELECT `username` FROM `banned` WHERE `username` = '%e' LIMIT 1", username);
	mysql_tquery(SQL, query, "CheckUnban", "is", playerid, username);
	return true;
}
CMD:unbanip(playerid, params[]) then
	if (!UlogovanProvera[playerid]) return 0;
    if(PI[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	new playersIP[24];
	if(sscanf(params, "s[24]", playersIP)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/banip [IP]");
	new query[300];
	mysql_format(SQL, query, sizeof query, "SELECT * FROM `banned` WHERE `user_ip`='%s' LIMIT 1", playersIP);
	mysql_tquery(SQL, query, "checkIPUnban", "is", playerid, playersIP);
	return 1;
}
CMD:mute(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new idm, time,reason[50], tmpstring[100];
	if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	if(sscanf(params, "uis[50]", idm ,time, reason)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/mute [ID/Part of name] [time in minutes] [reason]");
	if(idm -eq INVALID_PLAYER_ID) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}
	if(time < 1 || time > 100) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"It can't be less than 1 or more than 100 minutes");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Minute ne mozete staviti manje od 1 i vece od 100");
	}
	if(PI[idm][pAdmin] > PI[playerid][pAdmin]) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> That player has higher power than you.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj igrac je veci rank od tvog.");
	}
	format(tmpstring, sizeof(tmpstring), ""COLOR_RED"[MUTE] %s has muted %s for %d minutes. Reason: %s", GetName(playerid), GetName(idm), time, reason);
	SCMTA(-1, tmpstring);
	PI[idm][pMuted] = time*60;
	if (PI[idm][pLang] -eq 1)
		va_SendClientMessage(idm, 0xFF6347AA, "You have been muted by: %s for: %d minutes. Reason: %s", GetName(playerid), time, reason);
	else if (PI[idm][pLang] -eq 2)
		va_SendClientMessage(idm, 0xFF6347AA, "Mutirani ste od strane: %s na: %d minuta. Razlog: %s", GetName(playerid), time, reason);

	SaveAccount(idm);

	PI[playerid][pMutes] ++;
	return (true);
}
CMD:unmute(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new id;
    if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
    if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
    if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/unmute (id)");
    
    if (id -eq INVALID_PLAYER_ID)
    then
	    if(PI[playerid][pLang] -eq 1)
	        return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	    else if (PI[playerid][pLang] -eq 2)
		    return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
    }

    if(PI[id][pMuted] -eq 0) 
    then
    	if (PI[playerid][pLang] -eq 1)
    		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"That player is not muted.");
    	else if (PI[playerid][pLang] -eq 2)
    		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj igrac nije mutiran.");
   	}
    PI[id][pMuted] = 0;

    if (PI[id][pLang] -eq 1)
    	va_SendClientMessage(id, 0xFF6347AA, "You have been unmuted by Admin %s.", GetName(playerid));
	else if (PI[id][pLang] -eq 2)
		va_SendClientMessage(id, 0xFF6347AA, "Vise niste mutirani, odmutirao vas je admin %s.", GetName(playerid));
	return (true);
}
CMD:jail(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new id, time, reason[128];
	check[PI[playerid][pAdmin] -lt 1] return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	if(sscanf(params, "uis[50]", id,time, reason)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/jail [ID/Part of name] [time in minutes] [reason]");
	if(time < 3 || time > 100) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Player can't be jailed for less than 3 minutes, or more than 100 minutes.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Igrac ne moze biti zatvoren na manje od 3 minuta i duze od 100 minuta.");
	}
	if (id -eq INVALID_PLAYER_ID)
	then
		if(PI[playerid][pLang] -eq 1)
	        return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	    else if (PI[playerid][pLang] -eq 2)
		    return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}

	check[PI[id][pAdmin] -gt PI[playerid][pAdmin]] 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> That player has higher power than you.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj igrac je veci rank od tvog.");
	fi
	check[PI[id][pJailed] -gt 1]
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> That player is being already jailed.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj igrac je vec zatvoren.");
	fi
	va_SendClientMessageToAll(-1, ""COLOR_RED"[JAIL] %s has been jailed by %s for %d minutes | Reason: %s", GetName(id), GetName(playerid),time, reason);
	PI[id][pJailed] = time*60;
	
	if (PI[id][pLang] -eq 1)
		va_SendClientMessage(id, 0xFF6347AA, "You have been jailed by: %s for: %d minutes. Reason: %s", GetName(playerid), time, reason);
	else if (PI[id][pLang] -eq 2)
		va_SendClientMessage(id, 0xFF6347AA, "Zatvoreni ste od strane: %s na: %d minuta. Razlog: %s", GetName(playerid), time, reason);

	new rand = random(sizeof(RCRAND));
	SetPlayerPos(id, JAIL[rand][0], JAIL[rand][1], JAIL[rand][2]);
	SetPlayerVirtualWorld(id, JAILED_VW);
	if(InDM[id] -eq 1) InDM1--;
	else if(InDM[id] -eq 2) InDM2--;
	else if(InDM[id] -eq 3) InDM3--;
 	else if(InDM[id] -eq 4) InDM4--;
 	else if(InDM[id] -eq 5) InDM5--;
 	else if(InDM[id] -eq 6) InDM6--;	
 	else if(InDM[id] -eq 7) InDM7--;
	InDM[id] = 0;
	ArenaTime[id] = 0;
	Killstreak[id] = 0;
	SetPlayerInterior(id, 0);
	SaveAccount(id);

	PI[playerid][pJails] ++;
	return (true);
}
CMD:unjail(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new id, tmpstring[100];
	if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	check [!AdminDuty[playerid]]
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
		esac

	if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/unjail [ID/Part of name]");
	check[PI[id][pJailed] -eq 0]  
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"That player is not jailed.");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj igrac nije zatvoren.");
		esac


	check [id -eq INVALID_PLAYER_ID]
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
		esac

	check[PI[id][pAdmin] -gt PI[playerid][pAdmin]] 
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "> That player has higher power than you.");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj igrac je veci rank od tvog.");
		esac

	format(tmpstring, sizeof(tmpstring), "[!UNJAIL!]: %s has unjailed %s.", GetName(playerid), GetName(id));
	AMessage(COLOR_YELLOW, tmpstring);
	PI[id][pJailed] = 0;

	breaker PI[id][pLang] of
		_case 1)
			va_SendClientMessage(id, 0xFF6347AA, "You have been un-jailed by: %s.", GetName(playerid));
		_case 2)
			va_SendClientMessage(id, 0xFF6347AA, "Oslobodjeni ste od strane: %s.", GetName(playerid));
	esac

	SetPlayerPos(id, 1727.8054, -1667.5935, 22.5910);
	SetPlayerInterior(id, 18);
	SetPlayerFacingAngle(id, 269.8542);
	SpawnSetup(id);
	SetPlayerHealth(id, 99);
	SaveAccount(id);
	return (true);
}
CMD:spec(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new pID;
	if(sscanf(params, "u", pID)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/spec [ID]");
	if(pID -eq INVALID_PLAYER_ID) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}
	if(InDM[playerid] != 0) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You must be in the lobby in order to use this command.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Morate biti u lobby-u da biste koristili ovu komandu.");
	}
	if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	if(pID -eq playerid) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You can't spectate yourself.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Ne mozete specati samog sebe.");
	}
	TakeSpectateID[playerid] = pID;
   	SetPlayerInterior(playerid, GetPlayerInterior(pID));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(pID));
    TogglePlayerSpectating(playerid, true);
    PlayerSpectatePlayer(playerid, pID);
    SetPlayerInterior(playerid, GetPlayerInterior(pID));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(pID));
	return true;
}
CMD:specoff(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	TogglePlayerSpectating(playerid, (false));
    TakeSpectateID[playerid] = INVALID_PLAYER_ID;
    SetPlayerVirtualWorld(playerid, SPAWN_VW);
    SetPlayerSkinn(playerid, PI[playerid][pSkin]);
    SaveAccount(playerid);
	return true;
}
CMD:cc(playerid)
then
	if (!UlogovanProvera[playerid]) return 0;
	new tmpstring[128];
	if(PI[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}
	foreach(new i : Player) then if(IsPlayerConnected(i)) ClearFPlayer(i, 20); }
	format(tmpstring, sizeof(tmpstring), ""COLOR_RED"[admin] %s "COLOR_WHITE"has cleared the existing chat.", GetName(playerid));
	SCMTA(-1, tmpstring);
	return (true);
}
GetPlayerID(const playerName[]) then
	foreach (new i : Player) then
		new checkName[MAX_PLAYER_NAME];
		GetPlayerName(i, checkName, sizeof checkName);
		if(strcmp(checkName, playerName, true, strlen(playerName)) -eq 0)
			return i;
	}
  	return INVALID_PLAYER_ID;
}

CMD:offban(playerid, params[])
then
	if(PI[playerid][pAdmin] < 2) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	new nname[25], reason[50];
	if(sscanf(params, "s[25]s[50]", nname, reason)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/offban [Name] [Reason]");
	if (GetPlayerID(nname) != INVALID_PLAYER_ID) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > That player is connected.");
	//>>
	new query[188],
		year,
		month,
		day,
		sat, 
		minut,
		sekund;
	getdate(year, month, day);
	gettime(sat, minut, sekund);
	mysql_format(SQL, query, sizeof(query), "INSERT INTO `banned` (`username`,`admin`,`reason`,`date`) VALUES ('%s','%s','%s','%d/%d/%d - %d/%d/%d')",nname,GetName(playerid),reason,year,month,day,sat,minut,sekund);
	mysql_tquery(SQL,query);
	va_SendClientMessageToAll(-1, ""COLOR_RED"[BAN] %s has been banned from the server by %s. Reason: %s", nname, GetName(playerid), reason);
	return true;
}
//==============================[ PLAYER CMD ]==================================
CMD:pm(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new id, text[128], string[200];
	if(sscanf(params, "us[128]", id, text)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/pm [ID/Part of name] [text]");
	
	if (id -eq INVALID_PLAYER_ID)
	then
		if(PI[playerid][pLang] -eq 1)
	        return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	    else if (PI[playerid][pLang] -eq 2)
		    return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}
	
	if(id -eq playerid) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You can't send message to yourself.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Ne mozes sam sebi poslati poruku!");
	}
	if(PI[playerid][pMuted] >= 1) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You are muted, you can't use chat.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Ne mozete pisati jer ste mutirani.");
	}
	if(PI[id][pAdmin] != 0)
	then
		if (PI[id][pLang] -eq 1)
			va_SendClientMessage(id, COLOR_YELLOW, "{EFD101}(( PM from "COLOR_RED"%s{EFD101}[%d]: %s ))", GetName(playerid), playerid, text);
		else if (PI[id][pLang] -eq 2)
			va_SendClientMessage(id, COLOR_YELLOW, "{EFD101}(( Poruka od "COLOR_RED"%s{EFD101}[%d]: %s ))", GetName(playerid), playerid, text);

		if (PI[playerid][pLang] -eq 1)
			va_SendClientMessage(playerid, COLOR_YELLOW, "{EFD101}(( PM for "COLOR_RED"%s{EFD101}[%d]: %s ))", GetName(id), id, text);
		else if (PI[playerid][pLang] -eq 2)
			va_SendClientMessage(playerid, COLOR_YELLOW, "{EFD101}(( Poruka za "COLOR_RED"%s{EFD101}[%d]: %s ))", GetName(id), id, text);

		lastPM[id] = playerid;
	}
	else if(PI[id][pAdmin] -eq 0)
	then
		if (PI[id][pLang] -eq 1)
			va_SendClientMessage(id, COLOR_YELLOW, "{EFD101}(( PM from %s[%d]: %s ))", GetName(playerid), playerid, text);
		else if (PI[id][pLang] -eq 2)
			va_SendClientMessage(id, COLOR_YELLOW, "{EFD101}(( Poruka od %s[%d]: %s ))", GetName(playerid), playerid, text);

		if (PI[playerid][pLang] -eq 1)
			va_SendClientMessage(playerid, COLOR_YELLOW, "{EFD101}(( PM for %s[%d]: %s ))", GetName(id), id, text);
		else if (PI[playerid][pLang] -eq 2)
			va_SendClientMessage(playerid, COLOR_YELLOW, "{EFD101}(( Poruka za %s[%d]: %s ))", GetName(id), id, text);
		
		lastPM[id] = playerid;
	}
	if(PI[id][pAdmin] -eq 0 && PI[playerid][pAdmin] -eq 0)
	then
		format(string, sizeof(string), "[!PM ALERT!]: %s[%d] has sent a PM to %s[%d] saying: %s", GetName(playerid), playerid, GetName(id), id, text);
		AMessage(COLOR_YELLOW, string);
		lastPM[id] = playerid;
	}
	else if(PI[id][pAdmin] != 0 && PI[playerid][pAdmin] != 0) return true;
	return true;
}
cmd:r(playerid, params[]) then
	if (!UlogovanProvera[playerid]) return 0;
	if (PI[playerid][pMuted] >= 1) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You are muted, you can't use chat.");
	if (lastPM[playerid] -eq INVALID_PLAYER_ID) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"No-one has sent you a private message!");
	new pmText[126];
	if(sscanf(params, "s[126]", pmText)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/r [text]");
	if(PI[lastPM[playerid]][pAdmin] != 0)
	then
		va_SendClientMessage(lastPM[playerid], COLOR_YELLOW, "{EFD101}(( PM from "COLOR_RED"%s{EFD101}[%d]: %s ))", GetName(playerid), playerid, pmText);
		va_SendClientMessage(playerid, COLOR_YELLOW, "{EFD101}(( PM for "COLOR_RED"%s{EFD101}[%d]: %s ))", GetName(lastPM[playerid]), lastPM[playerid], pmText);
		lastPM[playerid] = INVALID_PLAYER_ID;
	}
	else if(PI[lastPM[playerid]][pAdmin] -eq 0)
	then
		if (PI[lastPM[playerid]][pLang] -eq 1)
			va_SendClientMessage(lastPM[playerid], COLOR_YELLOW, "{EFD101}(( PM from %s[%d]: %s ))", GetName(playerid), playerid, pmText);
		else if (PI[lastPM[playerid]][pLang] -eq 2)
			va_SendClientMessage(lastPM[playerid], COLOR_YELLOW, "{EFD101}(( Poruka od strane %s[%d]: %s ))", GetName(playerid), playerid, pmText);

		if (PI[playerid][pLang] -eq 1)
			va_SendClientMessage(playerid, COLOR_YELLOW, "{EFD101}(( PM for %s[%d]: %s ))", GetName(lastPM[playerid]), lastPM[playerid], pmText);
		else if (PI[playerid][pLang] -eq 2)
			va_SendClientMessage(playerid, COLOR_YELLOW, "{EFD101}(( Poruka za %s[%d]: %s ))", GetName(lastPM[playerid]), lastPM[playerid], pmText);

		lastPM[playerid] = INVALID_PLAYER_ID;
	}
	if(PI[lastPM[playerid]][pAdmin] -eq 0 && PI[playerid][pAdmin] -eq 0)
	then
		new tmpStr[124];
		format(tmpStr, sizeof tmpStr, "[!PM ALERT!]: %s[%d] has sent a PM to %s[%d] saying: %s", GetName(playerid), playerid, GetName(lastPM[playerid]), lastPM[playerid], pmText);
		AMessage(COLOR_YELLOW, tmpStr);
		lastPM[playerid] = INVALID_PLAYER_ID;
	}
	else if(PI[lastPM[playerid]][pAdmin] != 0 && PI[playerid][pAdmin] != 0) return true;
	return 1;
}
CMD:stats(playerid)
then
	if (!UlogovanProvera[playerid]) return 0;
	new string[420],str[20], arank[20],rank[20],Float:ratio=floatdiv(PI[playerid][pKills], PI[playerid][pDeaths]);
	format(str, 20, "%d %d %.2f", PI[playerid][pKills], PI[playerid][pDeaths], ratio);
	if(PI[playerid][pAdmin] -eq 0) arank = "None";
	else if(PI[playerid][pAdmin] -eq 1) arank = "Trial Admin";
	else if(PI[playerid][pAdmin] -eq 2) arank = "General Admin";
	else if(PI[playerid][pAdmin] -eq 3) arank = "Head Admin";
	else if(PI[playerid][pAdmin] -eq 4) arank = "Owner";
    if(PI[playerid][pRank] -eq 0) rank = "Unknown";
	else if(PI[playerid][pRank] -eq 1) rank = "Newbie";
	else if(PI[playerid][pRank] -eq 2) rank = "Trainee";
	else if(PI[playerid][pRank] -eq 3) rank = "Average";
	else if(PI[playerid][pRank] -eq 4) rank = "Master";
	else if(PI[playerid][pRank] -eq 5) rank = "Legend";
	else if(PI[playerid][pRank] -eq 6) rank = "God";
	format(string, sizeof(string), ""COLOR_WHITE"Player: "COLOR_SERVER"%s "COLOR_WHITE"Stats\n\n\n\
	Name: "COLOR_SERVER"%s "COLOR_WHITE"["COLOR_WHITE"ID:"COLOR_SERVER"%d"COLOR_WHITE"]\n\
	Kills: "COLOR_SERVER"%d\n\
	"COLOR_WHITE"Deaths: "COLOR_SERVER"%d\n\
	"COLOR_WHITE"K/D Ratio: "COLOR_SERVER"%.2f\n\
	"COLOR_WHITE"Skin: "COLOR_SERVER"%d\n\
	"COLOR_WHITE"Admin level: "COLOR_SERVER"%s\n\
	"COLOR_WHITE"Premium: "COLOR_SERVER"%s\n\
	"COLOR_WHITE"Rank:"COLOR_SERVER" %s\n\
	"COLOR_WHITE"Hours:"COLOR_SERVER" %.2f\n\
	"COLOR_WHITE"Registration Date:"COLOR_SERVER" %s"
	, GetName(playerid), GetName(playerid), playerid, PI[playerid][pKills],
	PI[playerid][pDeaths], ratio, PI[playerid][pSkin], arank, (PI[playerid][pPremium] -eq 1 ? "Da" : "Ne"), rank,
	PI[playerid][pHours], PI[playerid][pRegistrationDate]);
	ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, ""COLOR_SERVER"STATS", string, "Okay", "");
	return (true);
}
CMD:id(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/id (playerid)");
	
	if (id -eq INVALID_PLAYER_ID)
	then
		if(PI[playerid][pLang] -eq 1)
	        return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	    else if (PI[playerid][pLang] -eq 2)
		    return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}

	va_SendClientMessage(playerid, -1, ""COLOR_SERVER"[ID] "COLOR_WHITE"ID:%d | Ime/Name: %s", id, GetName(id));
	return (true);
}
CMD:skin(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new skinid;
	if(InDM[playerid] != 0) 
	then
		if (PI[playerid][pLang] -eq 1)
		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You must be in the lobby in order to use this command.");
		else if (PI[playerid][pLang] -eq 2)
		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Morate biti u lobby-u da biste koristili ovu komandu.");
	}

	if(sscanf(params, "i", skinid)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/skin [skin id]");
	if(PI[playerid][pAdmin] != 4)
	then
		if(skinid < 1 || skinid > 311)
		then
			if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Invalid skin ID, it goes from 1 to 299.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"ID Skina ne moze biti manji od 1 i veci od 299.");
		}
		if(skinid -eq 74) 
		then
			if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"This skin isn't allowed.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj skin je zabranjen.");
		}
		if(skinid -eq 1) 
		then
			if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"This skin isn't allowed.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj skin je zabranjen.");
		}
		if(skinid -eq 2) 
		then
			if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"This skin isn't allowed.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj skin je zabranjen.");
		}
		if(skinid -eq 86) 
		then
			if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"This skin isn't allowed.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj skin je zabranjen.");
		}
		if(skinid -eq 149) 
		then
			if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"This skin isn't allowed.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj skin je zabranjen.");
		}
		if(skinid >= 265 && skinid <= 272) 
		then
			if (PI[playerid][pLang] -eq 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"This skin isn't allowed.");
			else if (PI[playerid][pLang] -eq 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Taj skin je zabranjen.");
		}
		PI[playerid][pSkin] = skinid;
		SetPlayerSkinn(playerid, PI[playerid][pSkin]);
		new query[128];
		mysql_format(SQL, query, sizeof(query), "UPDATE `"users_table"` SET `Skin` = '%d' WHERE `ID` = '%d'", PI[playerid][pSkin], PI[playerid][pSQLID]);
		mysql_tquery(SQL, query);
		if (PI[playerid][pLang] -eq 1)
		va_SendClientMessage(playerid, 0x0070D0FF, "R:DM - "COLOR_WHITE"You bought skin ID: %d.", skinid);
		else if (PI[playerid][pLang] -eq 2)
		va_SendClientMessage(playerid, 0x0070D0FF, "R:DM - "COLOR_WHITE"Promenili ste skin u ID: %d.", skinid);
	}
	else if(PI[playerid][pAdmin] -eq 4)
	then
		if(skinid < 1 || skinid > 311)
		then
			if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Invalid skin ID, it goes from 1 to 299.");
			else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"ID Skina ne moze biti manji od 1 i veci od 299.");
		}
		PI[playerid][pSkin] = skinid;
		SetPlayerSkinn(playerid, PI[playerid][pSkin]);
		new query[128];
		mysql_format(SQL, query, sizeof(query), "UPDATE `"users_table"` SET `Skin` = '%d' WHERE `ID` = '%d'", PI[playerid][pSkin], PI[playerid][pSQLID]);
		mysql_tquery(SQL, query);
		if (PI[playerid][pLang] -eq 1)
		va_SendClientMessage(playerid, 0x0070D0FF, "R:DM - "COLOR_WHITE"You bought skin ID: %d.", skinid);
		else if (PI[playerid][pLang] -eq 2)
		va_SendClientMessage(playerid, 0x0070D0FF, "R:DM - "COLOR_WHITE"Promenili ste skin u ID: %d.", skinid);
	}
	return true;
}
CMD:toghud(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	if (TogHud[playerid]) then
	    PlayerTextDrawHide(playerid, GUI[playerid][0]);
		PlayerTextDrawHide(playerid, GUI[playerid][1]);
		PlayerTextDrawHide(playerid, GUI[playerid][2]);
		PlayerTextDrawHide(playerid, GUI[playerid][3]);
		PlayerTextDrawHide(playerid, GUI[playerid][4]);
		PlayerTextDrawHide(playerid, GUI[playerid][5]);
		PlayerTextDrawHide(playerid, GUI[playerid][6]);
		PlayerTextDrawHide(playerid, GUI[playerid][7]);
		PlayerTextDrawHide(playerid, GUI[playerid][8]);
		PlayerTextDrawHide(playerid, GUI[playerid][9]);

		if (PI[playerid][pLang] -eq 1)
			SendClientMessage(playerid, -1, ""COLOR_SERVER"[SESSION] "COLOR_WHITE"You turned off Session TD.");
		else if (PI[playerid][pLang] -eq 2)
			SendClientMessage(playerid, -1, ""COLOR_SERVER"[SESSION] "COLOR_WHITE"Sakrili ste sve textdraw-ove.");

		TogHud[playerid] = false;
	}
	else
	then
		TogHud[playerid] = true;
		PlayerTextDrawShow(playerid, GUI[playerid][0]);
		PlayerTextDrawShow(playerid, GUI[playerid][1]);
		PlayerTextDrawShow(playerid, GUI[playerid][2]);
		PlayerTextDrawShow(playerid, GUI[playerid][3]);
		PlayerTextDrawShow(playerid, GUI[playerid][4]);
		PlayerTextDrawShow(playerid, GUI[playerid][5]);
		PlayerTextDrawShow(playerid, GUI[playerid][6]);
		PlayerTextDrawShow(playerid, GUI[playerid][7]);
		PlayerTextDrawShow(playerid, GUI[playerid][8]);
		PlayerTextDrawShow(playerid, GUI[playerid][9]);

		if (PI[playerid][pLang] -eq 1)
			SendClientMessage(playerid, -1, ""COLOR_SERVER"[SESSION] "COLOR_WHITE"You turned on Session TD.");
		else if (PI[playerid][pLang] -eq 2)
			SendClientMessage(playerid, -1, ""COLOR_SERVER"[SESSION] "COLOR_WHITE"Prikazali ste sve textdraw-ove.");
	}
	return true;
}
CMD:fps(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new id;
	if(sscanf(params, "r", id))
		return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/fps [ID/Part of name]");
	if (id -eq INVALID_PLAYER_ID)
	then
		if(PI[playerid][pLang] -eq 1)
	       	return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	   	else if (PI[playerid][pLang] -eq 2)
		  	return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}
	if (PI[playerid][pLang] -eq 1)
	then
		va_SendClientMessage(playerid, COLOR_GRAY2, "Name: %s[%d] FPS: %d.", GetName(id), id, pFPS[id]);
	}
	else if (PI[playerid][pLang] -eq 2)
	then
		va_SendClientMessage(playerid, COLOR_GRAY2, "Name: %s[%d] FPS: %d.", GetName(id), id, pFPS[id]);
	}
	return (true);
}
CMD:color(playerid)
then
	if (!UlogovanProvera[playerid]) return 0;
	check[PI[playerid][pAdmin] -lt 1 and PI[playerid][pPremium] -ne 1] return SendClientMessage(playerid, 0xFF6347AA, "ERROR > You lack the permissions required to use this command.");
	ShowPlayerDialog(playerid, DIALOG_NCOLOR, DIALOG_STYLE_LIST, ""COLOR_SERVER"M-DM: Nickname Color System", "{0070D0}000000\n{15FF00}000000\n{D900FF}000000\n{000000}000000\n{FFF700}000000\n{02A604}000000\n{FF00C3}000000\n{FF8400}000000\n"COLOR_WHITE"000000\n{33A398}000000", "Choose","Close");
	return true;
}

CMD:dm(playerid, const params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	if(PI[playerid][pJailed] != 0) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You are jailed, you can't use this command.");
	if (InDM[playerid] != 0)
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You must be in lobby (/lobby).");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Ne mozete dok ste u areni (/lobby).");
	}
	check[pFPS[playerid] -gt 120 and PI[playerid][pAdmin] -lt 4]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Your FPS is higher than 120! Enable FPS-Limit in Options !");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Tvoj FPS je veci od 120! Ukljuci FPS-Limit u podesavanjima!");
		esac
	}
	if (InFreeroam[playerid])
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You must be in lobby, (/lobby)!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Morate izaci iz freeroam-a, (/lobby)!");
		esac
	}
	new string[500];
	format(string, sizeof string, "Arena ID\tArena Name\tPlayers\n\
	"COLOR_RED"Arena 0"COLOR_WHITE"\tLVPD\t%d/10\n\
	 "COLOR_RED"Arena 1"COLOR_WHITE"\tGhost Town\t%d/10\n\
	 "COLOR_RED"Arena 2"COLOR_WHITE"\tRC Battlefield\t%d/10\n\
	 "COLOR_RED"Arena 3"COLOR_WHITE"\tLVPD 2\t%d/10\n\
	 "COLOR_RED"Arena 4"COLOR_WHITE"\tGhost Town 2\t%d/10\n\
	 "COLOR_RED"Arena 5"COLOR_WHITE"\tWare House 1\t%d/10\n\
	 "COLOR_RED"Arena 6"COLOR_WHITE"\tSoar Arena\t%d/10",
	 InDM1, InDM2, InDM3, InDM4, InDM5, InDM6, InDM7);

	ShowPlayerDialog(playerid, DIALOG_DM, DIALOG_STYLE_TABLIST_HEADERS, 
		""COLOR_WHITE"R:DM | "COLOR_SERVER"Deathmatch Arenas", 
		string, 
		"Join", "Cancel"
	);
	return 1;
}

CMD:lobby(playerid)
then
	if (!UlogovanProvera[playerid]) return 0;
	if(PI[playerid][pJailed] != 0) return SendClientMessage(playerid, 0xFF6347AA, "You are jailed, you can't use this command.");
	// if(InDM[playerid] -eq 0) return SendClientMessage(playerid, 0xFF6347AA, "You are already in lobby.");
	if(Killed[playerid] == true) return SendClientMessage(playerid, 0xFF6347AA, "You can't do that in this moment.");
	if (InDM[playerid] != 0)
	then
		new Float:HP;
		new Float:armour;
		new lastdm;
		GetPlayerHealth(playerid, HP);
		GetPlayerArmour(playerid, armour);
		if(HP < 25.0) return SendClientMessage(playerid, 0xFF6347AA, "You can't go to lobby if your health is below 25.0.");
		lastdm = InDM[playerid];
		SetPlayerPos(playerid, 1727.8054, -1667.5935, 22.5910);
		SetPlayerInterior(playerid, 18);
		SetPlayerFacingAngle(playerid, 90.00);
		SpawnSetup(playerid);
		InDM[playerid] = 0;
		Killstreak[playerid] = 0;
		ArenaTime[playerid] = 0;
		SetCbugAllowed(false); 
		if(lastdm -eq 1)
		then
			InDM1--;
			foreach(new i : Player)
         	then
                if(InDM[i] -eq 1)
                then
                    va_SendClientMessage(i, 0x0070D0FF, "[DM]:"COLOR_WHITE" %s has left LVPD 1.", GetName(playerid));
                }
            }
		}
		if(lastdm -eq 2)
		then
			InDM2--;
			foreach(new i : Player)
         	then
                if(InDM[i] -eq 2)
                then
                    va_SendClientMessage(i, 0x0070D0FF, "[DM]:"COLOR_WHITE" %s has left Ghost Town.", GetName(playerid));
                }
            }
		}
		if(lastdm -eq 3)
		then
			InDM3--;
			foreach(new i : Player)
         	then
                if(InDM[i] -eq 3)
                then
                    va_SendClientMessage(i, 0x0070D0FF, "[DM]:"COLOR_WHITE" %s has left RC Battlefield.", GetName(playerid));
                }
            }
		}
		if(lastdm -eq 4)
		then
			InDM2--;
			foreach(new i : Player)
         	then
                if(InDM[i] -eq 4)
                then
                    va_SendClientMessage(i, 0x0070D0FF, "[DM]:"COLOR_WHITE" %s has left LVPD 2.",GetName(playerid));
                }
            }
		}
		if(lastdm -eq 5)
		then
			InDM2--;
			foreach(new i : Player)
         	then
                if(InDM[i] -eq 5)
                then
                    va_SendClientMessage(i, 0x0070D0FF, "[DM]:"COLOR_WHITE" %s has left Ghost Town 2.", GetName(playerid));
                }
            }
		}
		if(lastdm -eq 6)
		then
			InDM2--;
			foreach(new i : Player)
         	then
                if(InDM[i] -eq 6)
                then
                    va_SendClientMessage(i, 0x0070D0FF, "[DM]:"COLOR_WHITE" %s has left Warehouse 1.", GetName(playerid));
                }
            }
		}
		if(lastdm -eq 7)
		then
			InDM2--;
			foreach(new i : Player)
         	then
                if(InDM[i] -eq 7)
                then
                    va_SendClientMessage(i, 0x0070D0FF, "[DM]:"COLOR_WHITE" %s has left Soar Arena.", GetName(playerid));
                }
            }
		}
	}

	if (InFreeroam[playerid])
	then
		SetPlayerInterior(playerid, 18);
		SetPlayerPos(playerid, 1727.8054, -1667.5935, 22.5910);
		SetPlayerFacingAngle(playerid, 269.8542);
		SpawnSetup(playerid);
		ToggleTeleport[playerid] = true;
		InFreeroam[playerid] = false;
		SetCbugAllowed(false);

		if (fr_SpawnedVehicle[playerid])
		then
			fr_SpawnedVehicle[playerid] = false;
			DestroyVehicle(fr_VehicleID[playerid]);
		}
	}
	SetPlayerInterior(playerid, 18);
	return (true);
}
CMD:report(playerid, params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new id, currenttime = gettime();
	if(PI[playerid][pJailed] != 0) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You are jailed, you can't use this command.");
	if(sscanf(params, "uis", id)) return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/report [ID/Part of name]");
	
	if (id -eq INVALID_PLAYER_ID)
	then
		if(PI[playerid][pLang] -eq 1)
	        return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Invalid player.");
	    else if (PI[playerid][pLang] -eq 2)
		    return SendClientMessage(playerid, 0xFF6347AA, "ERROR > Igrac nije na serveru.");
	}

	if(id -eq playerid) 
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You can't report yourself.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Ne mozes prijaviti sam sebe.");
	} 
	if(currenttime < (ReportCooldown[playerid] + 60))
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You can use this command every 60 seconds.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Prijavljivati mozete svakih 60 sekundi.");
	}
	ReportCooldown[ playerid ] = gettime();
	ReportedID[ playerid ] = id;
	
	if (PI[playerid][pLang] -eq 1)
		ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_LIST, ""COLOR_SERVER"M-DM: Report System", "Hacking\nBraking The Rules\nSpam", "Subimt","Close");
	else if (PI[playerid][pLang] -eq 2)
		ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_LIST, ""COLOR_SERVER"M-DM: Prijavljivanje", "Citovanje\nKrsenje pravila\nSpam", "Potvrdi","Izadji");
	return true;
}

CMD:lang(playerid, const params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	ShowPlayerDialog(playerid, dialog_CHOOSELANG, DIALOG_STYLE_LIST,
		"R:DM - "COLOR_SERVER"Language",
		""COLOR_SERVER"[1]. "COLOR_WHITE"English\n\
		"COLOR_SERVER"[2]. "COLOR_WHITE"Srspki",
		""COLOR_SERVER"SELECT", "EXIT"
	);
	return 1;
}

CMD:changepassword(playerid, const params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	new password[24];
	if (sscanf(params, "s[24]", password)) return SendClientMessage(playerid, 0x797979FF, "Usage: "COLOR_WHITE"/changepassword [Password] (6-12 characters)");
	if(strlen(password) < 6  || strlen(password) > 12) return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"Invalid password lenght!");
	PI[playerid][pPass] = udb_hash(password);
	SendClientMessage(playerid, 0xFF6347AA, "[IMPORTANT] PASSWORD SUCESSFULLY CHANGED!");
	va_SendClientMessage(playerid, 0xFF6347AA, "[IMPORTANT] YOUR NEW PASSWORD IS "COLOR_WHITE"%sthenFF6347}!", password);
	/*
	if (!UlogovanProvera[playerid]) return 0;
	if (PI[playerid][pLang] -eq 1)
		ShowPlayerDialog(playerid, dialog_CHANGEPASS, DIALOG_STYLE_INPUT,
			""COLOR_SERVER"R:DM - "COLOR_WHITE"Change password",
			""COLOR_SERVER"- "COLOR_WHITE"Enter your desired password in the field below..",
			""COLOR_SERVER"INPUT", "CLOSE"
		);
	else if (PI[playerid][pLang] -eq 2)
		ShowPlayerDialog(playerid, dialog_CHANGEPASS, DIALOG_STYLE_INPUT,
			""COLOR_SERVER"R:DM - "COLOR_WHITE"Promeni lozinku",
			""COLOR_SERVER"- "COLOR_WHITE"Unesite vasu zeljenu lozinku u prazno polje ispod..",
			""COLOR_SERVER"UNESI", "IZADJI"
		);*/
	return 1;
}

CMD:checkadminstats(playerid, const params[])
then
	if (!UlogovanProvera[playerid]) return 0;
	if (PI[playerid][pAdmin] < 4)
		return SendClientMessage(playerid, 0xFF6347AA, "ERROR > "COLOR_WHITE"You're not authorized!");

	if (!AdminDuty[playerid])
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "> You must be on duty, /aduty.");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "> Morate biti na duznosti, /aduty.");
	}

	if (sscanf(params, "r", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: "COLOR_WHITE"/checkadminstats <playerid>");

	new String:str = str_format("\
		{0070D0}Division "COLOR_WHITE"Admin Stats\n\
		{0070D0}[1]. "COLOR_WHITE"Hours in staff: {0070D0}%d\n\
		{0070D0}[1]. "COLOR_WHITE"Kicks: {0070D0}%d\n\
		{0070D0}[1]. "COLOR_WHITE"Bans: {0070D0}%d\n\
		{0070D0}[1]. "COLOR_WHITE"Jails: {0070D0}%d\n\
		{0070D0}[1]. "COLOR_WHITE"Mutes: {0070D0}%d",
		PI[params[0]][pDutyTime], PI[params[0]][pKicks],
		PI[params[0]][pBans], PI[params[0]][pJails],
		PI[params[0]][pMutes]
	);

	SPD(playerid, dialog_CADMINSTATS, DIALOG_STYLE_MSGBOX,
		""COLOR_SERVER"R:DM - "COLOR_WHITE"Admin Stats",
		str,
		""COLOR_SERVER"X", ""
	);
	return 1;
}
