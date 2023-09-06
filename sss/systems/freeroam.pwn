#include <YSI_Coding\y_hooks>

new
	bool:InFreeroam[MAX_PLAYERS char],
	bool:ToggleTeleport[MAX_PLAYERS char],
	bool:fr_SpawnedVehicle[MAX_PLAYERS char],
	fr_VehicleID[MAX_PLAYERS char],
	Float:FreeroamSpawn[][] =
	{
		{1826.9949,-1337.8915,14.4219,270.0000},
		{1709.7985,1455.6178,10.8163,255.0000},
		{-1970.2654,288.2885,35.1719,90.0000},
		{-2387.2896,-605.1776,132.7250,85.0000}
	};


#define dialog_FRTELEPORT 14

// Hook (OnPlayerConnect) - Reseting variables
hook OnPlayerConnect(playerid)
{
	ToggleTeleport[playerid] = true;
	InFreeroam[playerid] = false;
	fr_SpawnedVehicle[playerid] = false;
	return Y_HOOKS_CONTINUE_RETURN_1;
}

// Commands
COMMAND:freeroam(playerid, const params[])
{
	if(InDM[playerid] != 0) 
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must be in the lobby in order to use this command. (/lobby)");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Ne mozete to dok ste u areni.");
		esac
	}
	if (InFreeroam[playerid])
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You're already in Freeroamm, (/lobby)!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Vec ste u Freeroam-u, (/lobby)!");
		esac
	}

	new
		rand = random(sizeof(FreeroamSpawn));

	breaker PI[playerid][pLang] of
		_case 1)
			SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}You have joined freeroam, to view a list of commands, use /help.");
		_case 2)
			SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}Usli ste u freeroam, da vidite listu komandi, kucajte /help.");
	esac

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);

	SetPlayerPos(playerid, FreeroamSpawn[rand][0], FreeroamSpawn[rand][1], FreeroamSpawn[rand][2]);
	SetPlayerFacingAngle(playerid, FreeroamSpawn[rand][3]);

	InFreeroam[playerid] = true;
	// InDM[playerid] = 8;
	return 1;
}

COMMAND:world(playerid, const params[])
{
	if (!InFreeroam[playerid])
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must be in freeroam mode!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Morate biti u freeroam modu!");
		esac
	}

	if (sscanf(params, "i", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/world [VW ID]");

	check[params[0] -lt 0 or params[0] -gt 100]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You can't go below 0 and above 100.");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Ne mozete ispod 0 i iznad 100.");
		esac
	fi

	SetPlayerVirtualWorld(playerid, params[0]);

	breaker PI[playerid][pLang] of
		_case 1)
			va_SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}Switched to virtual world %d.", params[0]);
		_case 2)
			va_SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}Sada se nalazite u virtual world-u %d.", params[0]);
	esac
	return 1;
}

COMMAND:teleports(playerid, const params[])
{
	if (!InFreeroam[playerid])
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must be in freeroam mode!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Morate biti u freeroam modu!");
		esac
	}

	ShowPlayerDialog(playerid, dialog_FRTELEPORT, DIALOG_STYLE_TABLIST_HEADERS,
		"You can teleport to other players with /tpto!",
		"Teleport name\tLocation\n\
		Skate Park\tLos Santos\n\
		LV Airport\tLas Venturas\n\
		SF Antenna Hill\tSan Fierro\n\
		SF Train Station\tSan Fierro",
		"Teleport", "Close"
	);
	return 1;
}

COMMAND:tpto(playerid, const params[])
{
	if (!InFreeroam[playerid])
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must be in freeroam mode!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Morate biti u freeroam modu!");
		esac
	}

	if (sscanf(params, "r", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/tpto [ID/Part of name]");

	check[params[0] -eq INVALID_PLAYER_ID]
		return 0;

	if (!InFreeroam[params[0]])
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}That player must be in freeroam mode!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Taj igrac mora biti u freeroam modu!");
		esac
	}

	if (!ToggleTeleport[params[0]])
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You can't teleport to this player!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Ne mozete se teleportovati do tog igraca!");
		esac
	}

	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(params[0], x, y, z);

	SetPlayerPos(playerid, x, y, z);

	breaker PI[playerid][pLang] of
		_case 1)
			va_SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}You've teleported to player %s!", GetName(params[0]));
		_case 2)
			va_SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}Teleportovali ste se do igraca %s!", GetName(params[0]));
	esac
	return 1;
}

COMMAND:toggletp(playerid, const params[])
{
	if (!ToggleTeleport[playerid])
	{
		ToggleTeleport[playerid] = true;

		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}Players can teleport to you again.");
			_case 2)
				return SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}Igraci ce moci da se teleportuju do vas ponovo.");
		esac
	}

	if (ToggleTeleport[playerid])
	{
		ToggleTeleport[playerid] = false;

		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}Players can no teleport to you.");
			_case 2)
				return SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam]: {FFFFFF}Igraci nece moci da se teleportuju do vas.");
		esac
	}
	return 1;
}

COMMAND:veh(playerid, const params[])
{
	if (!InFreeroam[playerid])
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must be in freeroam mode!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Morate biti u freeroam modu!");
		esac
	}

	if (sscanf(params, "iii", params[0], params[1], params[2]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/veh [ID] [COLOR 1] [COLOR 2]");

	check[params[0] -lt 400 or params[0] -gt 611]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You can't go below 400 and above 611!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Ne mozete ispod 400 i iznad 611!");
		esac
	fi

	if (!fr_SpawnedVehicle[playerid])
	{
		new
			Float:x,
			Float:y,
			Float:z,
			Float:a;

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

		fr_SpawnedVehicle[playerid] = true;
		fr_VehicleID[playerid] = CreateVehicle(params[0], x, y, z, a, params[1], params[2], 0, 0);
		PutPlayerInVehicle(playerid, fr_VehicleID[playerid], 0);

		breaker PI[playerid][pLang] of
			_case 1)
				va_SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam] {FFFFFF}You're spawned vehicle ID - %d.", params[0]);
			_case 2)
				va_SendClientMessage(playerid, 0xAFC1C9FF, "[Freeroam] {FFFFFF}Stvorili ste vozilo ID - %d.", params[0]);
		esac
	}
	else if (fr_SpawnedVehicle[playerid])
	{
		fr_SpawnedVehicle[playerid] = false;
		DestroyVehicle(fr_VehicleID[playerid]);
	}
	return 1;
}

COMMAND:gun(playerid, const params[])
{
	if (!InFreeroam[playerid])
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You must be in freeroam mode!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Morate biti u freeroam modu!");
		esac
	}

	if (sscanf(params, "i", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/gun [Weapon ID]");

	fr_CheckValidWeapons(playerid, params[0]);

	GivePlayerWeapon(playerid, params[0], cellmax);
	return 1;
}

// Function
stock fr_CheckValidWeapons(playerid, wid)
{
	check[wid -eq 16 or wid -eq 18 or wid -eq 4 or wid -eq 35 or wid -eq 36 or wid -eq 37 or wid -eq 38 or wid -eq 39 or wid -eq 40 or wid -eq 44 or wid -eq 45]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You can't use that weapon!");
			_case 2)
				SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Ne mozete koristiti to oruzije!");
		esac
		return 1;
	fi
	return 0;
}

// Dialog
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	check[dialogid -eq dialog_FRTELEPORT]
	then
		breaker listitem of
			_case 0)
				SetPlayerPos(playerid, 1826.9949,-1337.8915,14.4219);
				SetPlayerFacingAngle(playerid, 270.0000);
		
			_case 1)
				SetPlayerPos(playerid, 1709.7985,1455.6178,10.8163);
				SetPlayerFacingAngle(playerid, 255.0000);

			_case 2)
				SetPlayerPos(playerid, -1970.2654,288.2885,35.1719);
				SetPlayerFacingAngle(playerid, 90.0000);

			_case 3)
				SetPlayerPos(playerid, -2387.2896,-605.1776,132.7250);
				SetPlayerFacingAngle(playerid, 85.0000);
		esac
	fi
	return 1;
}

// Timer
// ptask UpdateFRHp[1](playerid)
// {
// 	if (InFreeroam[playerid])
// 	{
// 		SetPlayerHealth(playerid, 99.0);
// 		SetPlayerArmour(playerid, 99.0);

// 		if (IsPlayerInAnyVehicle(playerid))
// 		{
// 			RepairVehicle(GetPlayerVehicleID(playerid));
// 			SetVehicleHealth(GetPlayerVehicleID(playerid), 999.0);
// 		}
// 	}
// 	return 1;
// }