#include <YSI_Coding\y_hooks>


CMD:premiums(playerid)
{
	if (PI[playerid][pAdmin] -lt 4)
		return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You are not authorised.");
	
	mysql_tquery(SQL, "SELECT `Username`, `Premium` FROM `users` WHERE `Premium` > 0 ORDER BY `Premium` DESC", "Premiums", "d", playerid);
	return 1;
}

public Premiums(playerid)
{
	if(playerid != INVALID_PLAYER_ID)
    {
        new pname[MAX_PLAYER_NAME + 1], s_P[2500], s_Pp[256];
        if(cache_num_rows() > 0)
        {
            format(s_Pp, sizeof(s_Pp), "Nick\tOn/Of\n");
            strcat(s_P, s_Pp);
            for(new i = 0, r = cache_num_rows(); i < r; i ++)
            {
                cache_get_value_name(i, "Username", pname, MAX_PLAYER_NAME + 1);

                if(!IsPlayerConnected(GetPlayerIdFromName(pname)))
                {
                    format(s_Pp, sizeof(s_Pp), "%s\t{80FF80}Online"COLOR_WHITE"\n", pname);
                    strcat(s_P, s_Pp);
                }
                else
                {
					format(s_Pp, sizeof(s_Pp), "%s\t"COLOR_RED"Offline"COLOR_WHITE"\n", pname);
					strcat(s_P, s_Pp);
                }
            }
            ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_TABLIST_HEADERS, ""COLOR_RED"Premium {FFFFFF}List", s_P, "X", "");
        }
        else return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Premium list is empty.");
    }
	return 1;
}
CMD:makepremium(playerid, const params[])
{
	check [PI[playerid][pAdmin] -lt 4]
		return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You are not authorised.");

	check [sscanf(params, "ri", params[0], params[1])]
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/makepremium <playerid> <0-1>");

	check [params[0] -eq INVALID_PLAYER_ID]
	then
		if(PI[playerid][pLang] -eq 1)
        	return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}That player is not connected.");
   		else if (PI[playerid][pLang] -eq 2)
	    	return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}Taj igrac nije na serveru.");
	fi

	check [params[1] -lt 0 or params[1] -gt 1]
	then
		if (PI[playerid][pLang] -eq 1)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You can't go below 0 and above 1!");
		else if (PI[playerid][pLang] -eq 2)
			return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}Ne mozete ispod 0 i iznad 1!");
	fi

	check [params[1] -eq 0]
	{
		if (PI[params[0]][pLang] == 1)
			va_SendClientMessage(params[0], 0x0070D0FF, "*** Preimum: {FFFFFF}%s has set your premium rank to 0!", GetName(playerid));
		else if (PI[playerid][pLang] == 2)
			va_SendClientMessage(params[0], 0x0070D0FF, "*** Preimum: {FFFFFF}%s ti je postavio premium rank na 0!", GetName(playerid));

		PI[params[0]][pPremium] = 0;
	}
	else
	{
		if (PI[params[0]][pLang] == 1)
			va_SendClientMessage(params[0], 0x0070D0FF, "*** Preimum: {FFFFFF}%s has set your premium rank to 1!", GetName(playerid));
		else if (PI[playerid][pLang] == 2)
			va_SendClientMessage(params[0], 0x0070D0FF, "*** Preimum: {FFFFFF}%s ti je postavio premium rank na 1!", GetName(playerid));

		PI[params[0]][pPremium] = 1;	
	}
	sql_user_update_integer(params[0], "Premium", PI[params[0]][pPremium]);
	return 1;
}