#include <YSI_Coding\y_hooks>

#define DIALOG_DM 12798//moze ovaj broj radnom je?
new InDM[MAX_PLAYERS] = 0;
new InDM1 = 0;
new InDM2 = 0;
new InDM3 = 0;


CMM:DM(playerid, params[])
{
	if(PI[playerid][pJailed] != 0) return SendClientMessage(playerid, -1, "You are jailed, you cannot use this command.");
	if(InDM[playerid] != 0) return SendClientMessage(playerid, -1, "You must be in the lobby in order to use this command. (/lobby)");
	//
	new str[ 380 ];
	format(str, sizeof(str), "Arena ID\tArena Name\tPlayers\n\
 	"COLOR_RED"Arena 0"COLOR_WHITE"\tLVPD\t%d/10\n\
  	"COLOR_RED"Arena 1"COLOR_WHITE"\tGhost Town\t%d/10\n\
  	"COLOR_RED"Arena 2"COLOR_WHITE"\tRC Battlefield\t%d/10\n\
  	"COLOR_RED"Arena 3"COLOR_WHITE"\tJeferson Motel\t%d/10\n\
  	"COLOR_RED"Arena 4"COLOR_WHITE"\tMeat Factory\t%d/10\n\
  	"COLOR_RED"Arena 5"COLOR_WHITE"\tWare House 1\t%d/10", InDM1, InDM2, InDM3);
	SPD(playerid, DIALOG_DM, DIALOG_STYLE_TABLIST_HEADERS, ""COLOR_WHITE"R:DM | "COLOR_SERVER"Deathmatch Arenas", str, "Join", "Cancel");
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_DM)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(InDM1 == 10) return SendClientMessage(playerid, -1, "arena je puna mrs,");
					new rand = random(sizeof(LVPD));
					SetPlayerVirtualWorld(playerid, LVPD_VW);
					SetPlayerInterior(playerid, 3);
			  		SetPlayerPos(playerid, LVPD[rand][0], LVPD[rand][1], LVPD[rand][2]);
					GivePlayerWeapon(playerid, 24, 200);
					SetPlayerHealth(playerid, 99.0);
					SetPlayerArmour(playerid, 99.0);
					SetPlayerSkin(playerid, PI[playerid][pSkin]);
					SetCbugAllowed(false);
				}
				case 1:
				{
					if(InDM2 == 10) return SendClientMessage(playerid, -1, "arena je puna mrs,");
					SetPlayerVirtualWorld(playerid, GTOWN_VW);
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, GTOWN[rand][0], GTOWN[rand][1], GTOWN[rand][2]);
					GivePlayerWeapon(playerid, 24, 200);
					GivePlayerWeapon(playerid, 25, 150);
					GivePlayerWeapon(playerid, 33,50);
					SetPlayerHealth(playerid, 99.0);
					SetPlayerArmour(playerid, 99.0);
					SetPlayerSkin(playerid, PI[playerid][pSkin]);
					SetCbugAllowed(false);
				}
				case 2:
				{
					if(InDM3 == 10) return SendClientMessage(playerid, -1, "arena je puna mrs,");
					SetPlayerVirtualWorld(playerid, GTOWN_VW);
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, GTOWN[rand][0], GTOWN[rand][1], GTOWN[rand][2]);
					GivePlayerWeapon(playerid, 24, 200);
					GivePlayerWeapon(playerid, 25, 150);
					GivePlayerWeapon(playerid, 33,50);
					SetPlayerHealth(playerid, 99.0);
					SetPlayerArmour(playerid, 99.0);
					SetPlayerSkin(playerid, PI[playerid][pSkin]);
					SetCbugAllowed(false);
				}//posto radimo samo za 3 testno
			}
		}
	}
	return 1;
}
hook OnPlayerSpawn(playerid)
{
	if(InDM[playerid] = 1)
	{
		new rand = random(sizeof(LVPD));
		SetPlayerVirtualWorld(playerid, LVPD_VW);
		SetPlayerInterior(playerid, 3);
  		SetPlayerPos(playerid, LVPD[rand][0], LVPD[rand][1], LVPD[rand][2]);
		GivePlayerWeapon(playerid, 24, 200);
		SetPlayerHealth(playerid, 99.0);
		SetPlayerArmour(playerid, 99.0);
		SetPlayerSkin(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(false);
	}
	else if[InDM[playerid] = 2]
	{
		new rand = random(sizeof(GTOWN));
		SetPlayerVirtualWorld(playerid, GTOWN_VW);
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, GTOWN[rand][0], GTOWN[rand][1], GTOWN[rand][2]);
		GivePlayerWeapon(playerid, 24, 200);
		GivePlayerWeapon(playerid, 25, 150);
		GivePlayerWeapon(playerid, 33,50);
		SetPlayerHealth(playerid, 99.0);
		SetPlayerArmour(playerid, 99.0);
		SetPlayerSkin(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(false);
	}
	else if[InDM[playerid] = 3]
	{
		new rand = random(sizeof(RCRAND));
		SetPlayerVirtualWorld(playerid, RCBTF_VW);
		SetPlayerInterior(playerid, 10);
		SetPlayerPos(playerid, RCRAND[rand][0], RCRAND[rand][1], RCRAND[rand][2]);
		GivePlayerWeapon(playerid, 24, 200);
		GivePlayerWeapon(playerid, 25, 150);
		GivePlayerWeapon(playerid, 31, 300);
		GivePlayerWeapon(playerid, 34,50);
		SetPlayerHealth(playerid, 99.0);
		SetPlayerArmour(playerid, 99.0);
		SetPlayerSkin(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(false);
	}
	return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
	if(InDM[playerid] == 1) { InDM1--; }
	else if(InDM[playerid] == 2) { InDM2--; }
	else if(InDM[playerid] == 3) { InDM3--; }
	return 1;
}
CMD:lobby(playerid)
{
	if (!UlogovanProvera[playerid]) return 0;
	if(PI[playerid][pJailed] != 0) return SendClientMessage(playerid, 0xFF6347AA, "You are jailed, you can't use this command.");
	if(Killed[playerid] == true) return SendClientMessage(playerid, 0xFF6347AA, "You can't do that in this moment.");
	if (InDM[playerid] != 0)
	{
		new Float:HP;
		new Float:armour;
		GetPlayerHealth(playerid, HP);
		GetPlayerArmour(playerid, armour);
		if(HP < 25.0) return SendClientMessage(playerid, 0xFF6347AA, "You can't go to lobby if your health is below 25.0.");
		if(InDM[playerid] == 1) InDM1--;
		else if(InDM[playerid] == 2) InDM2--;
		else if(InDM[playerid] == 3) InDM3--;
		SetPlayerPos(playerid, 1727.8054, -1667.5935, 22.5910);
		SpawnSetup(playerid);
		InDM[playerid] = 0;
		SetCbugAllowed(true);
		SetPlayerInterior(playerid, 18);
	}

	if (InFreeroam[playerid])
	{
		SetPlayerPos(playerid, 1727.8054, -1667.5935, 22.5910);
		SpawnSetup(playerid);
		ToggleTeleport[playerid] = true;
		InFreeroam[playerid] = false;
		SetCbugAllowed(true);
		SetPlayerInterior(playerid, 18);
		if (fr_SpawnedVehicle[playerid])
		{
			fr_SpawnedVehicle[playerid] = false;
			DestroyVehicle(fr_VehicleID[playerid]);
		}
	}
	SetPlayerInterior(playerid, 18);
	return 1;
}
