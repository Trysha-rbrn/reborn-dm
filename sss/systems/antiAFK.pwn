/* ** anti afk in dm ** */
#include <YSI_Coding\y_hooks>

new
	afkTimer[MAX_PLAYERS];
	// bool:afkMsgSent;

hook OnPlayerConnect(playerid) {
	AdminDuty[playerid] = false;
	afkTimer[playerid] = SetTimerEx("afkCheck", 1000, true, "d", playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason) {
	KillTimer(afkTimer[playerid]);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

forward afkCheck(playerid);
public afkCheck(playerid) {
	// if (PI[playerid][pAdmin] >= 1)
	// {
	// 	if (AdminDuty[playerid])
	// 	{
	// 		if ((GetTickCount() - s_LastUpdate[playerid]) > 60000)
	// 			Kick(playerid);

	// 		if (!afkMsgSent)
	// 		{
	// 			foreach(new i: Player)
	// 			{
	// 				if (PI[i][pAdmin] >= 1)
	// 				{
	// 					new String:str = str_format("
	// 						[AntiCheat]: {FFFFFF}Player {FF6347}%s {FFFFFF}has been kicked from the server for AFK on Admin Duty!", 
	// 						GetName(playerid)
	// 					);
	// 					SendFormatMessage(i, 0xFF6347FF, str);
	// 					afkMsgSent = true;
	// 				}
	// 			}
	// 		}
	// 	}
	// }

	if (InDM[playerid] > 0) {
		if(GetTickCount() - s_LastUpdate[playerid] > 20000) {
			switch (InDM[playerid]) {
			case 1: InDM1 -= 1;
			case 2: InDM2 -= 1;
			case 3: InDM3 -= 1;
			case 4: InDM4 -= 1;
			case 5: InDM5 -= 1;
			case 6: InDM6 -= 1;
			case 7: InDM7 -= 1;
			}
			SetPlayerPos(playerid, 778.3023,2577.3352,1388.3441);
			SetPlayerFacingAngle(playerid, 269.8542);
			SpawnSetup(playerid);
			InDM[playerid] = 0;
			ArenaTime[playerid] = 0;

			if (PI[playerid][pLang] == 1)
				SendClientMessage(playerid, COLOR_RED2, "You have been sent to the lobby because your AFK time exceed 20 seconds!");
			else if (PI[playerid][pLang] == 2)
				SendClientMessage(playerid, COLOR_RED2, "Izbaceni ste iz arene jer ste bili afk duze od 20 sekundi u dm areni!");
		}
	}
	/*if(InDM[playerid] > 3) 
	{
		if (pFPS[playerid] >= 105) 
		{
			switch (InDM[playerid]) 
			{
				case 1: InDM4 -= 1;
				case 2: InDM5 -= 1;
				case 3: InDM6 -= 1;
			}
			SetPlayerPos(playerid, 778.3023,2577.3352,1388.3441);
			SetPlayerFacingAngle(playerid, 269.8542);
			SpawnSetup(playerid);
			InDM[playerid] = 0;
			SendClientMessage(playerid, COLOR_SERVER2, "You have been sent to the lobby because your FPS is over 120!");
		}
	}*/
	/*if(pFPS[playerid] > 120 && PI[playerid][pAdmin] < 3) 
	{
		if(InDM[playerid] != 4 && InDM[playerid] != 5)
		{
			if(InDM[playerid] == 1)
			{
				InDM1 -= 1;
				SetPlayerPos(playerid, 778.3023,2577.3352,1388.3441);
				SetPlayerFacingAngle(playerid, 269.8542);
				SpawnSetup(playerid);
				InDM[playerid] = 0;
				ArenaTime[playerid] = 0;
				SendClientMessage(playerid, COLOR_SERVER2, "You have been sent to the lobby because your FPS is over 120!");
			}
			if(InDM[playerid] == 2)
			{
				InDM2 -= 1;
				SetPlayerPos(playerid, 778.3023,2577.3352,1388.3441);
				SetPlayerFacingAngle(playerid, 269.8542);
				SpawnSetup(playerid);
				InDM[playerid] = 0;
				ArenaTime[playerid] = 0;
				SendClientMessage(playerid, COLOR_SERVER2, "You have been sent to the lobby because your FPS is over 120!");
			}
			if(InDM[playerid] == 3)
			{
				InDM3 -= 1;
				SetPlayerPos(playerid, 778.3023,2577.3352,1388.3441);
				SetPlayerFacingAngle(playerid, 269.8542);
				SpawnSetup(playerid);
				InDM[playerid] = 0;
				ArenaTime[playerid] = 0;
				SendClientMessage(playerid, COLOR_SERVER2, "You have been sent to the lobby because your FPS is over 120!");
			}
			if(InDM[playerid] == 6)
			{
				InDM6 -= 1;
				SetPlayerPos(playerid, 778.3023,2577.3352,1388.3441);
				SetPlayerFacingAngle(playerid, 269.8542);
				SpawnSetup(playerid);
				InDM[playerid] = 0;
				ArenaTime[playerid] = 0;
				SendClientMessage(playerid, COLOR_SERVER2, "You have been sent to the lobby because your FPS is over 120!");
			}
			if(InDM[playerid] == 7)
			{
				InDM7 -= 1;
				SetPlayerPos(playerid, 778.3023,2577.3352,1388.3441);
				SetPlayerFacingAngle(playerid, 269.8542);
				SpawnSetup(playerid);
				InDM[playerid] = 0;
				ArenaTime[playerid] = 0;
				SendClientMessage(playerid, COLOR_SERVER2, "You have been sent to the lobby because your FPS is over 120!");
			}
		}
	}*/
	return 1;
}