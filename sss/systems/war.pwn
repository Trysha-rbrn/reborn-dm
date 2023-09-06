const MAX_MEMBERS_IN_WAR = (5);

new 
	bool:WarSent[MAX_PLAYERS],
	PlayerWhoSent,
	InvitedPlayer,
	bool:PlayerInvited[MAX_PLAYERS],
	WarStarted,
	bool:ChoosingMembers[MAX_PLAYERS],
	FirstMember[MAX_PLAYERS],
	SecondMember[MAX_PLAYERS],
	ThirdMember[MAX_PLAYERS],
	TotalMembers[MAX_PLAYERS],
	FourthMember[MAX_PLAYERS],
	FifthMember[MAX_PLAYERS];

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

	if ((PI[params[0]][pClanMembers]) < 3)
	{
		if (PI[playerid][pLang] == 1)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}The opposing clan does not have enough members!");
		else if (PI[playerid][pLang] == 2)
			return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Protivnicki klan nema dovoljno clanova!");
	}

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
	}
	return 1;
}

COMMAND:addwar(playerid, const params[])
{
	if (!ChoosingMembers[PlayerWhoSent] ||
		!ChoosingMembers[InvitedPlayer]
	) {
		if (PI[PlayerWhoSent][pLang] == 1)
			return va_SendClientMessage(PlayerWhoSent, 0xFF6347AA, "Error: {FFFFFF}Player %s doesn't accept your invite!", GetName(InvitedPlayer));	
		else if (PI[PlayerWhoSent][pLang] == 2)
			return va_SendClientMessage(PlayerWhoSent, 0xFF6347AA, "Error: {FFFFFF}Igrac %s nije prihvatio vas poziv!", GetName(InvitedPlayer));	
	}

	if (sscanf(params, "rrrrr", params[0], params[1], params[2], params[3], params[4]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/addwar <player 1> <player 2> <player 3> <player 4> <player 5>");

	if (params[0] == INVALID_PLAYER_ID ||
		params[1] == INVALID_PLAYER_ID ||
		params[2] == INVALID_PLAYER_ID ||
		params[3] == INVALID_PLAYER_ID ||
		params[4] == INVALID_PLAYER_ID
	)	return 0;

	FirstMember[PlayerWhoSent] = params[0];
	FirstMember[InvitedPlayer] = params[0];

	SecondMember[PlayerWhoSent] = params[1];
	SecondMember[InvitedPlayer] = params[1];

	ThirdMember[PlayerWhoSent] = params[2];
	ThirdMember[InvitedPlayer] = params[2];

	FourthMember[PlayerWhoSent] = params[3];
	FourthMember[InvitedPlayer] = params[3];

	FifthMember[PlayerWhoSent] = params[4];
	FifthMember[InvitedPlayer] = params[4];

	TotalMembers[PlayerWhoSent] ++;
	TotalMembers[InvitedPlayer] ++;

	if (TotalMembers[PlayerWhoSent] == MAX_MEMBERS_IN_WAR 
		|| TotalMembers[InvitedPlayer] == MAX_MEMBERS_IN_WAR
	) {
		defer WarCountdown();

		foreach(new i: Player)
			va_SendClientMessage(i, 0x0070D0FF, "[Clan - War]: {FFFFFF}The war between %s and %s started!", GetName(PlayerWhoSent), GetName(InvitedPlayer));

		defer WarCountdown();

		WarStarted = SetTimer("WarCountdown", 600000, false);

		// Setting pos of leaders

		// Leader 1
		SetPlayerPos(PlayerWhoSent, -974.4783,1073.2551,1344.9957);
		SetPlayerFacingAngle(PlayerWhoSent, 94.7447);

		GivePlayerWeapon(PlayerWhoSent, 24, cellmax);
		GivePlayerWeapon(PlayerWhoSent, 31, cellmax);
		GivePlayerWeapon(PlayerWhoSent, 34, cellmax);

		// Leader 2
		SetPlayerPos(InvitedPlayer, -1129.8607,1046.4152,1345.7344);
		SetPlayerFacingAngle(InvitedPlayer, 271.3201);

		GivePlayerWeapon(InvitedPlayer, 24, cellmax);
		GivePlayerWeapon(InvitedPlayer, 31, cellmax);
		GivePlayerWeapon(InvitedPlayer, 34, cellmax);

		// Setting pos of members

		// Team 1
		SetPlayerPos(FirstMember[PlayerWhoSent], -974.4783,1073.2551,1344.9957);
		SetPlayerPos(SecondMember[PlayerWhoSent], -974.4783,1073.2551,1344.9957);
		SetPlayerPos(ThirdMember[PlayerWhoSent], -974.4783,1073.2551,1344.9957);
		SetPlayerPos(FourthMember[PlayerWhoSent], -974.4783,1073.2551,1344.9957);
		SetPlayerPos(FifthMember[PlayerWhoSent], -974.4783,1073.2551,1344.9957);
	
		SetPlayerFacingAngle(FirstMember[PlayerWhoSent], 94.7447);
		SetPlayerFacingAngle(SecondMember[PlayerWhoSent], 94.7447);
		SetPlayerFacingAngle(ThirdMember[PlayerWhoSent], 94.7447);
		SetPlayerFacingAngle(FourthMember[PlayerWhoSent], 94.7447);
		SetPlayerFacingAngle(FifthMember[PlayerWhoSent], 94.7447);

		GivePlayerWeapon(FirstMember[PlayerWhoSent], 24, cellmax);
		GivePlayerWeapon(SecondMember[PlayerWhoSent], 24, cellmax);
		GivePlayerWeapon(ThirdMember[PlayerWhoSent], 24, cellmax);
		GivePlayerWeapon(FourthMember[PlayerWhoSent], 24, cellmax);
		GivePlayerWeapon(FifthMember[PlayerWhoSent], 24, cellmax);

		GivePlayerWeapon(FirstMember[PlayerWhoSent], 31, cellmax);
		GivePlayerWeapon(SecondMember[PlayerWhoSent], 31, cellmax);
		GivePlayerWeapon(ThirdMember[PlayerWhoSent], 31, cellmax);
		GivePlayerWeapon(FourthMember[PlayerWhoSent], 31, cellmax);
		GivePlayerWeapon(FifthMember[PlayerWhoSent], 31, cellmax);

		GivePlayerWeapon(FirstMember[PlayerWhoSent], 34, cellmax);
		GivePlayerWeapon(SecondMember[PlayerWhoSent], 34, cellmax);
		GivePlayerWeapon(ThirdMember[PlayerWhoSent], 34, cellmax);
		GivePlayerWeapon(FourthMember[PlayerWhoSent], 34, cellmax);
		GivePlayerWeapon(FifthMember[PlayerWhoSent], 34, cellmax);

		// Team 2
		SetPlayerPos(FirstMember[InvitedPlayer], -974.4783,1073.2551,1344.9957);
		SetPlayerPos(SecondMember[InvitedPlayer], -974.4783,1073.2551,1344.9957);
		SetPlayerPos(ThirdMember[InvitedPlayer], -974.4783,1073.2551,1344.9957);
		SetPlayerPos(FourthMember[InvitedPlayer], -974.4783,1073.2551,1344.9957);
		SetPlayerPos(FifthMember[InvitedPlayer], -974.4783,1073.2551,1344.9957);
	
		SetPlayerFacingAngle(FirstMember[InvitedPlayer], 94.7447);
		SetPlayerFacingAngle(SecondMember[InvitedPlayer], 94.7447);
		SetPlayerFacingAngle(ThirdMember[InvitedPlayer], 94.7447);
		SetPlayerFacingAngle(FourthMember[InvitedPlayer], 94.7447);
		SetPlayerFacingAngle(FifthMember[InvitedPlayer], 94.7447);

		GivePlayerWeapon(FirstMember[InvitedPlayer], 24, cellmax);
		GivePlayerWeapon(SecondMember[InvitedPlayer], 24, cellmax);
		GivePlayerWeapon(ThirdMember[InvitedPlayer], 24, cellmax);
		GivePlayerWeapon(FourthMember[InvitedPlayer], 24, cellmax);
		GivePlayerWeapon(FifthMember[InvitedPlayer], 24, cellmax);

		GivePlayerWeapon(FirstMember[InvitedPlayer], 31, cellmax);
		GivePlayerWeapon(SecondMember[InvitedPlayer], 31, cellmax);
		GivePlayerWeapon(ThirdMember[InvitedPlayer], 31, cellmax);
		GivePlayerWeapon(FourthMember[InvitedPlayer], 31, cellmax);
		GivePlayerWeapon(FifthMember[InvitedPlayer], 31, cellmax);

		GivePlayerWeapon(FirstMember[InvitedPlayer], 34, cellmax);
		GivePlayerWeapon(SecondMember[InvitedPlayer], 34, cellmax);
		GivePlayerWeapon(ThirdMember[InvitedPlayer], 34, cellmax);
		GivePlayerWeapon(FourthMember[InvitedPlayer], 34, cellmax);
		GivePlayerWeapon(FifthMember[InvitedPlayer], 34, cellmax);
	}
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
	SetPlayerPos(FirstMember[PlayerWhoSent], 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(SecondMember[PlayerWhoSent], 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(ThirdMember[PlayerWhoSent], 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(FourthMember[PlayerWhoSent], 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(FifthMember[PlayerWhoSent], 2061.7598,1315.4216,-18.2414);
	
	// Team 2
	SetPlayerPos(FirstMember[InvitedPlayer], 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(SecondMember[InvitedPlayer], 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(ThirdMember[InvitedPlayer], 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(FourthMember[InvitedPlayer], 2061.7598,1315.4216,-18.2414);
	SetPlayerPos(FifthMember[InvitedPlayer], 2061.7598,1315.4216,-18.2414);	
	return 1;
}