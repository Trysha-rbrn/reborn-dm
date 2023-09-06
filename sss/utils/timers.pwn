ptask PTime[1000](playerid)
{
	//
	new stringic[20], tmphour, tmpminute, tmpsecond;
	gettime( tmphour, tmpminute, tmpsecond );
	format(stringic, sizeof stringic, "~w~%d:%d:%d", tmphour, tmpminute, tmpsecond);
	PlayerTextDrawSetString(playerid, GUI[playerid][18], stringic);
	//
	if(InDM[playerid] > 0)
	{
		if(RespawningDM[playerid] > 0)
		{
			RespawningDM[playerid]--;
			new string[20];
			format(string, sizeof(string), "respawning_in_%d...", RespawningDM[playerid]);
			PlayerTextDrawSetString(playerid, DTD[playerid], string);
		}
		else if(RespawningDM[playerid] == 0)
		{
			PlayerTextDrawSetString(playerid, DTD[playerid], "respawning_in_0...");
			TakeSpectateID[playerid] = INVALID_PLAYER_ID;
        	PlayerTextDrawHide(playerid, DTD[playerid]);
        	TogglePlayerSpectating(playerid, 0);
		}
    }
	else {}
	if(PI[playerid][pMuted] > 0)
	{
		if(PI[playerid][pMuted] == 1)
		{
			PI[playerid][pMuted] = 0;
			if (PI[playerid][pLang] == 1)
			InfoMessage(playerid, "You are no longer muted.");
			else if (PI[playerid][pLang] == 2)
			InfoMessage(playerid, "Vise niste mutirani.");
		}
		else if(PI[playerid][pMuted] > 1)
		{
			PI[playerid][pMuted] --;
		}
	}
	check [PI[playerid][pJailed] -ne 0 && PI[playerid][pJailed] -ne 0]
	then
		check [PI[playerid][pJailed] -eq 1]
		then
			PI[playerid][pJailed] = 0;
			if (PI[playerid][pLang] == 1)
				InfoMessage(playerid, "You are no longer jailed.");
			else if (PI[playerid][pLang] == 2)
				InfoMessage(playerid, "Vise niste zatvoreni.");
			SetPlayerHealth(playerid, 0.0);
		ifnot
			PI[playerid][pJailed] --;
		fi
	fi
	//JetPack Anticheat
	check [GetPlayerSpecialAction(playerid) -eq SPECIAL_ACTION_USEJETPACK]
	then
		new string[128];
    	format(string, sizeof(string), ""COLOR_RED"[ C-AC ] %s has been kicked from the server by Anticheat. Reason: Cheating ( 3 )", GetName(playerid));
    	SCMTA(-1, string);
		t_Kick(playerid);
	fi 
	//
	if(TogHud[playerid])
	{
		new string1[50], string2[50], string3[50], string5[50], string6[50], string7[50], str[20], Float:ratio=floatdiv(PI[playerid][pUbistva], PI[playerid][pSmrti]);
		format(str, 20, "%d %d %.2f", PI[playerid][pUbistva], PI[playerid][pSmrti], ratio);
		format(string1, 50, "%d", PI[playerid][pUbistva]);
		PlayerTextDrawSetString(playerid, GUI[playerid][23], string1);
		format(string2, 50, "%d", PI[playerid][pSmrti]);
		PlayerTextDrawSetString(playerid, GUI[playerid][24], string2);
		if(PI[playerid][pSmrti] == 0)
		{
			PlayerTextDrawSetString(playerid, GUI[playerid][25], "NaN");
		}	
		else if(PI[playerid][pSmrti] != 0)
		{
			format(string3, 50, "%.2f", ratio);
			PlayerTextDrawSetString(playerid, GUI[playerid][25], string3);
		}
		format(string5, 50, "FPS:~w~_%d", pFPS[playerid]);
		PlayerTextDrawSetString(playerid, GUI[playerid][20], string5);
		format(string6, 50, "PING:~w~_%d", GetPlayerPing(playerid));
		PlayerTextDrawSetString(playerid, GUI[playerid][21], string6);
		format(string7, 50, "%d", Killstreak[playerid]);
		PlayerTextDrawSetString(playerid, GUI[playerid][26], string7);
	}
	return (true);
}

timer t_Kick[1000](playerid)
	return Kick(playerid), GameTextForPlayer(playerid, "~r~KICKED", 10000, 5);

/*timer DeathTimer[3000](playerid)
{
	TextDrawHideForPlayer(playerid, DTD[0]);
	TakeSpectateID[playerid] = INVALID_PLAYER_ID;
	TogglePlayerSpectating(playerid, false);
	return true;
}*/