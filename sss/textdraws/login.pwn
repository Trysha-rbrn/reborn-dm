new PlayerText:LoginTD[MAX_PLAYERS][3];

stock ShowLoginTextDraws(playerid, bool:status)
{
	if (status)
	{
		LoginTD[playerid][0] = CreatePlayerTextDraw(playerid, 316.833129, 133.116973, "Reborn_Deathmatch");
		PlayerTextDrawLetterSize(playerid, LoginTD[playerid][0], 0.462222, 1.960888);
		PlayerTextDrawAlignment(playerid, LoginTD[playerid][0], 2);
		PlayerTextDrawColor(playerid, LoginTD[playerid][0], -1);
		PlayerTextDrawSetShadow(playerid, LoginTD[playerid][0], 1);
		PlayerTextDrawSetOutline(playerid, LoginTD[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][0], 255);
		PlayerTextDrawFont(playerid, LoginTD[playerid][0], 3);
		PlayerTextDrawSetProportional(playerid, LoginTD[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, LoginTD[playerid][0], 1);

		LoginTD[playerid][1] = CreatePlayerTextDraw(playerid, 316.833129, 154.192199, "00:00:00");
		PlayerTextDrawLetterSize(playerid, LoginTD[playerid][1], 0.239444, 1.145778);
		PlayerTextDrawAlignment(playerid, LoginTD[playerid][1], 2);
		PlayerTextDrawColor(playerid, LoginTD[playerid][1], -1);
		PlayerTextDrawSetShadow(playerid, LoginTD[playerid][1], 1);
		PlayerTextDrawSetOutline(playerid, LoginTD[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][1], 255);
		PlayerTextDrawFont(playerid, LoginTD[playerid][1], 2);
		PlayerTextDrawSetProportional(playerid, LoginTD[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, LoginTD[playerid][1], 1);

		LoginTD[playerid][2] = CreatePlayerTextDraw(playerid, 316.833129, 173.693389, "This account is registered, type password in the field bellow.");
		PlayerTextDrawLetterSize(playerid, LoginTD[playerid][2], 0.239444, 1.145778);
		PlayerTextDrawAlignment(playerid, LoginTD[playerid][2], 2);
		PlayerTextDrawColor(playerid, LoginTD[playerid][2], -1);
		PlayerTextDrawSetShadow(playerid, LoginTD[playerid][2], 1);
		PlayerTextDrawSetOutline(playerid, LoginTD[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][2], 255);
		PlayerTextDrawFont(playerid, LoginTD[playerid][2], 1);
		PlayerTextDrawSetProportional(playerid, LoginTD[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, LoginTD[playerid][2], 1);

		loop i in {0 .. 3}
		do
			PlayerTextDrawShow(playerid, LoginTD[playerid][i]);
		done
	}
	else if (!status)
	{
		loop i in {0 .. 3}
		do
			PlayerTextDrawHide(playerid, LoginTD[playerid][i]);
		done
	}
	return 1;
}

ptask UpdateLoginTime[1000](playerid)
{
	new 
		hours, 
		minutes, 
		seconds,
		str[24];

	gettime(hours, minutes, seconds);
	format(str, sizeof(str), "%d:%d:%d", hours, minutes, seconds);
	PlayerTextDrawSetString(playerid, LoginTD[playerid][1], str);
	return 1;
}