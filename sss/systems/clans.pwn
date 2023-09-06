#include <YSI_Coding\y_hooks>

const MAX_CLANS = (10);

new
	Iterator:ClansCreated<MAX_CLANS>,
	AlreadyInvited[MAX_PLAYERS];

CMD:createclan(playerid, const params[])
{
	if (PI[playerid][pPremium] != 1)
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must have a premium rank to use this option!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Morate biti premium rank da biste koristili tu opciju!");	
	}

	if ((Iter_Count(ClansCreated)) == 5)
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Number of maximum clans is already created!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Maksimalni broj klanova je vec napravljen!");
	}

	if (PI[playerid][pCreatedClan])
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You already create clan!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Vec ste napravili klan!");
	}

	if (sscanf(params, "s[24]", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/createclan <clan name>");

	if (PI[playerid][pLang] == 1)
		va_SendClientMessage(playerid, 0x0070D0FF, "[Clan]: {FFFFFF}You've created clan {0070D0}%s{FFFFFF}.", params[0]);
	else if (PI[playerid][pLang] == 2)
		va_SendClientMessage(playerid, 0x0070D0FF, "[Clan]: {FFFFFF}Napravili ste klan {0070D0}%s{FFFFFF}.", params[0]);

	format(PI[playerid][pClanName], 24, params[0]);
	format(PI[playerid][pClanLeader], 24, GetName(playerid));

	PI[playerid][pClanMembers] ++;
	PI[playerid][pCreatedClan] = 1;

	new query[200];
	mysql_format(SQL, query, sizeof(query), "UPDATE `users` SET `ClanName` = '%e',\
		`ClanLeader` = '%e', `ClanMembers` = '%d', `CreatedClan` = '%d' WHERE \
		`ID` = '%d'", PI[playerid][pClanName], PI[playerid][pClanLeader],
		PI[playerid][pClanMembers], PI[playerid][pCreatedClan], PI[playerid][pSQLID]);
	mysql_tquery(SQL, query);

	Iter_Add(ClansCreated, 1);
	return 1;
}

CMD:inviteclan(playerid, const params[])
{
	if (!PI[playerid][pCreatedClan])
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must have create a clan!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Morate napraviti klan!");
	}

	if (PI[playerid][pClanMembers] == 5)
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Your clan is full!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Vas klan je pun!");
	}

	if (sscanf(params, "r", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/inviteclan <playerid>");

	if (params[0] == INVALID_PLAYER_ID)
    {
	    if(PI[playerid][pLang] == 1)
        	return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}That player is not connected.");
   		else if (PI[playerid][pLang] == 2)
	    	return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Taj igrac nije na serveru.");
   	}

   	if (AlreadyInvited[params[0]])
   	{
   		if (PI[playerid][pLang] == 1)
   			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}That player already invited!");
   		else if (PI[playerid][pLang] == 2)
   			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Taj igrac je vec pozvan!");
   	}

   	if (PI[params[0]][pInClan] == 1)
   	{
   		if (PI[playerid][pLang] == 1)
   			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}That player is already in clan!");
   		else if (PI[playerid][pLang] == 2)
   			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Taj igrac je vec u nekom klanu!");
   	}

   	if (PI[playerid][pLang] == 1 || PI[params[0]][pLang] == 1)
   	{
   		va_SendClientMessage(params[0], 0x0070D0FF, "[Clan]: {FFFFFF}Leader %s invited you in his clan ({0070D0}%s){FFFFFF}.", GetName(playerid), PI[playerid][pClanName]);
   		SendClientMessage(params[0], 0x0070D0FF, "To accept invite type /acceptinvite");

   		va_SendClientMessage(playerid, 0x0070D0FF, "[Clan]: {FFFFFF}You invited player {0070D0}%s {FFFFFF}into your clan.", GetName(params[0]));
   	}
   	else if (PI[playerid][pLang] == 2 || PI[params[0]][pLang] == 2)
   	{
   		va_SendClientMessage(params[0], 0x0070D0FF, "[Clan]: {FFFFFF}Lider %s vas je pozvao u njegov klan ({0070D0}%s){FFFFFF}.", GetName(playerid), PI[playerid][pClanName]);
   		SendClientMessage(params[0], 0x0070D0FF, "Da prihvatite poziv kucajte /acceptinvite");

   		va_SendClientMessage(playerid, 0x0070D0FF, "[Clan]: {FFFFFF}Pozvali ste igraca {0070D0}%s {FFFFFF}u svoj klan.", GetName(params[0]));
   	}

   	AlreadyInvited[params[0]] = 1;
   	PlayerWhoInvite = playerid;
	return 1;
}

CMD:acceptinvite(playerid, const params[])
{
	if (!AlreadyInvited[playerid])
   	{
   		if (PI[playerid][pLang] == 1)
   			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Nobody invite you in clan!");
   		else if (PI[playerid][pLang] == 2)
   			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Niko vas nije pozvao u klan!");
   	}

   	if (PI[playerid][pLang] == 1 || PI[PlayerWhoInvite][pLang] == 1)
 	{
 		va_SendClientMessage(playerid, 0x0070D0FF, "[Clan]: {FFFFFF}Welcome to clan {0070D0}%s{FFFFFF}!", PI[PlayerWhoInvite][pClanName]);
 		va_SendClientMessage(PlayerWhoInvite, 0x0070D0FF, "[Clan]: {FFFFFF}Player %s accepted your invite!", GetName(playerid));
 	}
 	else if (PI[playerid][pLang] == 2 || PI[PlayerWhoInvite][pLang] == 2)
 	{
 		va_SendClientMessage(playerid, 0x0070D0FF, "[Clan]: {FFFFFF}Dobrodosli u klan {0070D0}%s{FFFFFF}!", PI[PlayerWhoInvite][pClanMembers]);
 		va_SendClientMessage(PlayerWhoInvite, 0x0070D0FF, "[Clan]: {FFFFFF}Igrac %s je prihvatio vas poziv!", GetName(playerid));
 	}

 	PI[PlayerWhoInvite][pClanMembers] ++;
 	AlreadyInvited[playerid] = 0;
 	PI[PlayerWhoInvite][pInClan] = 1;
 	PI[playerid][pInClan] = 1;
	return 1;
}

CMD:clans(playerid, const params[])
{
	foreach(new i: Player)
	{
		va_SendClientMessage(playerid, -1, "Clans: %d | Clan Name: %s | Members: %d | Leader: %s", Iter_Count(ClansCreated), PI[i][pClanName], PI[playerid][pClanMembers], PI[i][pClanLeader]);
	}
	return 1;
}

CMD:cchat(playerid, const params[])
{
	if (!PI[playerid][pInClan])
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must be in clan!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Morate biti u klanu!");
	}

	if (sscanf(params, "s[124]", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/cchat <text>");

	new 
		String:str = str_format("\
			*** Clan %s | %s: {FFFFFF}%s", PI[PlayerWhoInvite][pClanName], GetName(playerid), params[0]);

	for (new i; i < PI[PlayerWhoInvite][pClanMembers]; i++)
		SendFormatMessage(i, 0x0070D0FF, str);
	return 1;
}

// Hooks
hook OnPlayerDisconnect(playerid, reason)
{
	if (PI[playerid][pInClan])
	{
		if (PI[PlayerWhoInvite][pLang] == 1)
			va_SendClientMessage(PlayerWhoInvite, 0x0070D0FF, "[Clan - %s]: {FFFFFF}Player %s has left the clan (disconnect).", PI[PlayerWhoInvite][pClanName], GetName(playerid));
		else if (PI[PlayerWhoInvite][pLang] == 1)
			va_SendClientMessage(PlayerWhoInvite, 0x0070D0FF, "[Clan - %s]: {FFFFFF}Igrac %s je napustio klan (disconnect).", PI[PlayerWhoInvite][pClanName], GetName(playerid));

		PI[PlayerWhoInvite][pClanMembers] --;
	}

	// if (PlayerWhoInvite)
	// {
	// 	for (new i; i < PI[PlayerWhoInvite][pClanMembers]; i++)
	// 	{
	// 		if (PI[i][pLang] == 1)
	// 			va_SendClientMessage(i, 0x0070D0FF, "[Clan]: {FFFFFF}Leader of your clan ({0070D0}%s{FFFFFF}) has disconnected, clan is deleted!", PI[PlayerWhoInvite][pClanName]);
	// 		else if (PI[i][pLang] == 2)
	// 			va_SendClientMessage(i, 0x0070D0FF, "[Clan]: {FFFFFF}Lider tvog klana ({0070D0}%s{FFFFFF}) je napustio server, klan je obrisan!", PI[PlayerWhoInvite][pClanName]);
	// 	}

	// 	PI[PlayerWhoInvite][pCreatedClan] = 0;
	// 	Iter_Remove(ClansCreated, 1);
	// }
	return Y_HOOKS_CONTINUE_RETURN_1;
}

/* WARS */
const MAX_MEMBERS_IN_WAR = (5);

new 
	bool:WarSent[MAX_PLAYERS],
	PlayerWhoSent,
	InvitedPlayer,
	bool:PlayerInvited[MAX_PLAYERS],
	WarStarted,
	bool:ChoosingFirstTeam,
	bool:ChoosingSecondTeam,
	bool:ChoosingMembers[MAX_PLAYERS],
	FirstMember_TEAM1,
	SecondMember_TEAM1,
	ThirdMember_TEAM1,
	// FourthMember_TEAM1,
	// FifthMember_TEAM1,

	FirstMember_TEAM2,
	SecondMember_TEAM2,
	ThirdMember_TEAM2;
	// FourthMember_TEAM2,
	// FifthMember_TEAM2;

COMMAND:war(playerid, const params[])
{
	if (!PI[playerid][pCreatedClan])
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must have create a clan!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Morate napraviti klan!");
	}

	if (sscanf(params, "r", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/war <playerid>");

	if (params[0] == INVALID_PLAYER_ID)
	{
		if(PI[playerid][pLang] == 1)
	        return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}That player is not connected.");
	    else if (PI[playerid][pLang] == 2)
		    return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Taj igrac nije na serveru.");
	}

	if (!PI[params[0]][pCreatedClan])
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}That player doesn't have clan!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Taj igrac nema klan!");
	}

	// if ((PI[params[0]][pClanMembers]) < 3)
	// {
	// 	if (PI[playerid][pLang] == 1)
	// 		return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}The opposing clan does not have enough members!");
	// 	else if (PI[playerid][pLang] == 2)
	// 		return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Protivnicki klan nema dovoljno clanova!");
	// }

	WarSent[playerid] = true;
	PlayerInvited[params[0]] = true;
	PlayerWhoSent = playerid;

	if (PI[playerid][pLang] == 1 || PI[params[0]][pLang] == 1)
	{
		va_SendClientMessage(params[0], 0x0070D0FF, "[Clan - War]: {FFFFFF}Player %s invite your clan into war!", GetName(playerid));
		SendClientMessage(params[0], 0x0070D0FF, "[Clan - War]: {FFFFFF}To accept invite type /acceptwar!");

		va_SendClientMessage(playerid, 0x0070D0FF, "[Clan - War]: {FFFFFF}Waiting for player %s...", GetName(params[0]));
	}
	else if (PI[playerid][pLang] == 2 || PI[params[0]][pLang] == 2)
	{
		va_SendClientMessage(params[0], 0x0070D0FF, "[Clan - War]: {FFFFFF}Igrac %s izaziva rat protiv vaseg klana!", GetName(playerid));
		SendClientMessage(params[0], 0x0070D0FF, "[Clan - War]: {FFFFFF}Da prihvatite poziv kucajte /acceptwar!");

		va_SendClientMessage(playerid, 0x0070D0FF, "[Clan - War]: {FFFFFF}Cekanje potvrde %s...", GetName(params[0]));
	}
	return 1;
}

COMMAND:acceptwar(playerid, const params[])
{
	if (!PlayerInvited[playerid])
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Nobody invite your clan into war!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Niko nije pozvao vas klan u rat!");
	}

	if (PI[playerid][pLang] == 1)
	{
		va_SendClientMessage(PlayerWhoSent, 0x0070D0FF, "[Clan - War]: {FFFFFF}Player %s accepted war!", GetName(playerid));
		SendClientMessage(PlayerWhoSent, 0x0070D0FF, "[Clan - War]: {FFFFFF}To add members into war type /addwar!");

		va_SendClientMessage(playerid, 0x0070D0FF, "[Clan - War]: {FFFFFF}You've accepted war that %s sent you!", GetName(PlayerWhoSent));
		SendClientMessage(playerid, 0x0070D0FF, "[Clan - War]: {FFFFFF}To add members into war type /addwar!");
	
		PlayerInvited[playerid] = false;
		WarSent[PlayerWhoSent] = false;
		ChoosingMembers[PlayerWhoSent] = true;
		ChoosingMembers[playerid] = true;
		InvitedPlayer = playerid;

		ChoosingFirstTeam = true;
	}
	return 1;
}

COMMAND:addfirstteam(playerid, const params[])
{
	if (!ChoosingFirstTeam)
		return 0;

	if (sscanf(params, "rrr", params[0], params[1], params[2]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/addfirstteam <player 1> <player 2> <player 3>");

	if (params[0] == INVALID_PLAYER_ID ||
		params[1] == INVALID_PLAYER_ID ||
		params[2] == INVALID_PLAYER_ID
	)	return 0;

	FirstMember_TEAM1 = params[0];
	SecondMember_TEAM1 = params[1];
	ThirdMember_TEAM1 = params[2];

	ChoosingFirstTeam = false;
	ChoosingSecondTeam = true;
	return 1;
}

COMMAND:addsecondteam(playerid, const params[])
{
	if (!ChoosingSecondTeam)
		return 0;

	if (sscanf(params, "rrr", params[0], params[1], params[2]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/addsecondteam <player 1> <player 2> <player 3>");

	if (params[0] == INVALID_PLAYER_ID ||
		params[1] == INVALID_PLAYER_ID ||
		params[2] == INVALID_PLAYER_ID
	)	return 0;

	FirstMember_TEAM2 = params[0];
	SecondMember_TEAM2 = params[1];
	ThirdMember_TEAM2 = params[2];

	ChoosingSecondTeam = false;

	callcmd::wardebug(playerid, "");
	return 1;
}

COMMAND:wardebug(playerid, const params[])
{
	foreach(new i: Player)
		va_SendClientMessage(i, 0x0070D0FF, "[Clan - War]: {FFFFFF}The war between %s and %s started!", GetName(PlayerWhoSent), GetName(InvitedPlayer));

	WarStarted = SetTimer("WarCountdown", 600000, false);

	// Setting pos of leaders

	// Leader 1
	SetPlayerPos(PlayerWhoSent, -974.4783,1073.2551,1344.9957);
	SetPlayerFacingAngle(PlayerWhoSent, 94.7447);
	SetPlayerInterior(PlayerWhoSent, 10);

	GivePlayerWeapon(PlayerWhoSent, 24, cellmax);
	GivePlayerWeapon(PlayerWhoSent, 31, cellmax);
	GivePlayerWeapon(PlayerWhoSent, 34, cellmax);

	// Leader 2
	SetPlayerPos(InvitedPlayer, -1129.8607,1046.4152,1345.7344);
	SetPlayerFacingAngle(InvitedPlayer, 271.3201);
	SetPlayerInterior(InvitedPlayer, 10);

	GivePlayerWeapon(InvitedPlayer, 24, cellmax);
	GivePlayerWeapon(InvitedPlayer, 31, cellmax);
	GivePlayerWeapon(InvitedPlayer, 34, cellmax);

	// Setting pos of members

	// Team 1
	SetPlayerPos(FirstMember_TEAM1, -974.4783,1073.2551,1344.9957);
	SetPlayerPos(SecondMember_TEAM1, -974.4783,1073.2551,1344.9957);
	SetPlayerPos(ThirdMember_TEAM1, -974.4783,1073.2551,1344.9957);
	SetPlayerInterior(FirstMember_TEAM1, 10);
	SetPlayerInterior(SecondMember_TEAM1, 10);
	SetPlayerInterior(ThirdMember_TEAM1, 10);
	// SetPlayerPos(FourthMember[PlayerWhoSent], -974.4783,1073.2551,1344.9957);
	// SetPlayerPos(FifthMember[PlayerWhoSent], -974.4783,1073.2551,1344.9957);

	SetPlayerFacingAngle(FirstMember_TEAM1, 94.7447);
	SetPlayerFacingAngle(SecondMember_TEAM1, 94.7447);
	SetPlayerFacingAngle(ThirdMember_TEAM1, 94.7447);
	// SetPlayerFacingAngle(FourthMember[PlayerWhoSent], 94.7447);
	// SetPlayerFacingAngle(FifthMember[PlayerWhoSent], 94.7447);

	GivePlayerWeapon(FirstMember_TEAM1, 24, cellmax);
	GivePlayerWeapon(SecondMember_TEAM1, 24, cellmax);
	GivePlayerWeapon(ThirdMember_TEAM1, 24, cellmax);
	// GivePlayerWeapon(FourthMember[PlayerWhoSent], 24, cellmax);
	// GivePlayerWeapon(FifthMember[PlayerWhoSent], 24, cellmax);

	GivePlayerWeapon(FirstMember_TEAM1, 31, cellmax);
	GivePlayerWeapon(SecondMember_TEAM1, 31, cellmax);
	GivePlayerWeapon(ThirdMember_TEAM1, 31, cellmax);
	// GivePlayerWeapon(FourthMember[PlayerWhoSent], 31, cellmax);
	// GivePlayerWeapon(FifthMember[PlayerWhoSent], 31, cellmax);

	GivePlayerWeapon(FirstMember_TEAM1, 34, cellmax);
	GivePlayerWeapon(SecondMember_TEAM1, 34, cellmax);
	GivePlayerWeapon(ThirdMember_TEAM1, 34, cellmax);
	// GivePlayerWeapon(FourthMember[PlayerWhoSent], 34, cellmax);
	// GivePlayerWeapon(FifthMember[PlayerWhoSent], 34, cellmax);

	// Team 2
	SetPlayerPos(FirstMember_TEAM2, -974.4783,1073.2551,1344.9957);
	SetPlayerPos(SecondMember_TEAM2, -974.4783,1073.2551,1344.9957);
	SetPlayerPos(ThirdMember_TEAM2, -974.4783,1073.2551,1344.9957);
	SetPlayerInterior(FirstMember_TEAM2, 10);
	SetPlayerInterior(SecondMember_TEAM2, 10);
	SetPlayerInterior(ThirdMember_TEAM2, 10);
	// SetPlayerPos(FourthMember[InvitedPlayer], -974.4783,1073.2551,1344.9957);
	// SetPlayerPos(FifthMember[InvitedPlayer], -974.4783,1073.2551,1344.9957);

	SetPlayerFacingAngle(FirstMember_TEAM2, 94.7447);
	SetPlayerFacingAngle(SecondMember_TEAM2, 94.7447);
	SetPlayerFacingAngle(ThirdMember_TEAM2, 94.7447);
	// SetPlayerFacingAngle(FourthMember[InvitedPlayer], 94.7447);
	// SetPlayerFacingAngle(FifthMember[InvitedPlayer], 94.7447);

	GivePlayerWeapon(FirstMember_TEAM2, 24, cellmax);
	GivePlayerWeapon(SecondMember_TEAM2, 24, cellmax);
	GivePlayerWeapon(ThirdMember_TEAM2, 24, cellmax);
	// GivePlayerWeapon(FourthMember[InvitedPlayer], 24, cellmax);
	// GivePlayerWeapon(FifthMember[InvitedPlayer], 24, cellmax);

	GivePlayerWeapon(FirstMember_TEAM2, 31, cellmax);
	GivePlayerWeapon(SecondMember_TEAM2, 31, cellmax);
	GivePlayerWeapon(ThirdMember_TEAM2, 31, cellmax);
	// GivePlayerWeapon(FourthMember[InvitedPlayer], 31, cellmax);
	// GivePlayerWeapon(FifthMember[InvitedPlayer], 31, cellmax);

	GivePlayerWeapon(FirstMember_TEAM2, 34, cellmax);
	GivePlayerWeapon(SecondMember_TEAM2, 34, cellmax);
	GivePlayerWeapon(ThirdMember_TEAM2, 34, cellmax);
	// GivePlayerWeapon(FourthMember[InvitedPlayer], 34, cellmax);
	// GivePlayerWeapon(FifthMember[InvitedPlayer], 34, cellmax);
	return 1;
}

timer WarCountdown[600000]()
{
	KillTimer(WarStarted);

	SetPlayerPos(PlayerWhoSent, 2061.7598,1315.4216,-18.2414);
	SpawnSetup(PlayerWhoSent);

	SetPlayerPos(InvitedPlayer, 2061.7598,1315.4216,-18.2414);
	SpawnSetup(InvitedPlayer);

	// Spawning members on spawn (default)

	// Team 1
	SetPlayerPos(FirstMember_TEAM1, 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(SecondMember_TEAM1, 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(ThirdMember_TEAM1, 2061.7598,1315.4216,-18.2414);
	// SetPlayerPos(FourthMember[PlayerWhoSent], 2061.7598,1315.4216,-18.2414);
	// SetPlayerPos(FifthMember[PlayerWhoSent], 2061.7598,1315.4216,-18.2414);
	
	// Team 2
	SetPlayerPos(FirstMember_TEAM2, 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(SecondMember_TEAM2, 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(ThirdMember_TEAM2, 2061.7598,1315.4216,-18.2414);
	// SetPlayerPos(FourthMember[InvitedPlayer], 2061.7598,1315.4216,-18.2414);
	// SetPlayerPos(FifthMember[InvitedPlayer], 2061.7598,1315.4216,-18.2414);	
	return 1;
}