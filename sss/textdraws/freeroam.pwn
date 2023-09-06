#include <YSI_Coding\y_hooks>

new
	PlayerText:FreeroamTDs[MAX_PLAYERS][6];

stock ShowFreeroamTextDraws(playerid, bool:status)
{
	if (status)
	{
		FreeroamTDs[playerid][0] = CreatePlayerTextDraw(playerid, -77.222198, -48.466678, "LD_SPAC:white");
		PlayerTextDrawLetterSize(playerid, FreeroamTDs[playerid][0], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, FreeroamTDs[playerid][0], 982.000000, 696.000000);
		PlayerTextDrawAlignment(playerid, FreeroamTDs[playerid][0], 1);
		PlayerTextDrawColor(playerid, FreeroamTDs[playerid][0], 255);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, FreeroamTDs[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, FreeroamTDs[playerid][0], 255);
		PlayerTextDrawFont(playerid, FreeroamTDs[playerid][0], 4);
		PlayerTextDrawSetProportional(playerid, FreeroamTDs[playerid][0], 0);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][0], 0);

		FreeroamTDs[playerid][1] = CreatePlayerTextDraw(playerid, 236.810852, 176.521820, "LD_SPAC:white");
		PlayerTextDrawLetterSize(playerid, FreeroamTDs[playerid][1], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, FreeroamTDs[playerid][1], 168.000000, 67.000000);
		PlayerTextDrawAlignment(playerid, FreeroamTDs[playerid][1], 1);
		PlayerTextDrawColor(playerid, FreeroamTDs[playerid][1], 7393535);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, FreeroamTDs[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, FreeroamTDs[playerid][1], 255);
		PlayerTextDrawFont(playerid, FreeroamTDs[playerid][1], 4);
		PlayerTextDrawSetProportional(playerid, FreeroamTDs[playerid][1], 0);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][1], 0);

		FreeroamTDs[playerid][2] = CreatePlayerTextDraw(playerid, 237.332977, 177.066223, "LD_SPAC:white");
		PlayerTextDrawLetterSize(playerid, FreeroamTDs[playerid][2], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, FreeroamTDs[playerid][2], 167.000000, 66.019577);
		PlayerTextDrawAlignment(playerid, FreeroamTDs[playerid][2], 1);
		PlayerTextDrawColor(playerid, FreeroamTDs[playerid][2], 255);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, FreeroamTDs[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, FreeroamTDs[playerid][2], 255);
		PlayerTextDrawFont(playerid, FreeroamTDs[playerid][2], 4);
		PlayerTextDrawSetProportional(playerid, FreeroamTDs[playerid][2], 0);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][2], 0);

		FreeroamTDs[playerid][3] = CreatePlayerTextDraw(playerid, 285.567108, 170.777770, "");
		PlayerTextDrawLetterSize(playerid, FreeroamTDs[playerid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, FreeroamTDs[playerid][3], 73.000000, 79.000000);
		PlayerTextDrawAlignment(playerid, FreeroamTDs[playerid][3], 1);
		PlayerTextDrawColor(playerid, FreeroamTDs[playerid][3], 7393535);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, FreeroamTDs[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, FreeroamTDs[playerid][3], 0);
		PlayerTextDrawFont(playerid, FreeroamTDs[playerid][3], 5);
		PlayerTextDrawSetProportional(playerid, FreeroamTDs[playerid][3], 0);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][3], 0);
		PlayerTextDrawSetPreviewModel(playerid, FreeroamTDs[playerid][3], 19377);
		PlayerTextDrawSetPreviewRot(playerid, FreeroamTDs[playerid][3], 0.000000, -24.000000, 0.000000, 1.000000);

		FreeroamTDs[playerid][4] = CreatePlayerTextDraw(playerid, 278.144317, 204.333312, "FREEROAM");
		PlayerTextDrawTextSize(playerid, FreeroamTDs[playerid][4], 8.0, 20.0);
		PlayerTextDrawLetterSize(playerid, FreeroamTDs[playerid][4], 0.316111, 1.400889);
		PlayerTextDrawAlignment(playerid, FreeroamTDs[playerid][4], 2);
		PlayerTextDrawColor(playerid, FreeroamTDs[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, FreeroamTDs[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, FreeroamTDs[playerid][4], 255);
		PlayerTextDrawFont(playerid, FreeroamTDs[playerid][4], 3);
		PlayerTextDrawSetProportional(playerid, FreeroamTDs[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][4], 0);
		PlayerTextDrawSetSelectable(playerid, FreeroamTDs[playerid][4], true);

		FreeroamTDs[playerid][5] = CreatePlayerTextDraw(playerid, 363.049499, 204.333312, "LOBBY");
		PlayerTextDrawTextSize(playerid, FreeroamTDs[playerid][5], 8.0, 20.0);
		PlayerTextDrawLetterSize(playerid, FreeroamTDs[playerid][5], 0.316111, 1.400889);
		PlayerTextDrawAlignment(playerid, FreeroamTDs[playerid][5], 2);
		PlayerTextDrawColor(playerid, FreeroamTDs[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, FreeroamTDs[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, FreeroamTDs[playerid][5], 255);
		PlayerTextDrawFont(playerid, FreeroamTDs[playerid][5], 3);
		PlayerTextDrawSetProportional(playerid, FreeroamTDs[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, FreeroamTDs[playerid][5], 0);
		PlayerTextDrawSetSelectable(playerid, FreeroamTDs[playerid][5], true);

		loop i in {0 .. 6}
		do
			PlayerTextDrawShow(playerid, FreeroamTDs[playerid][i]);
		done
		SelectTextDraw(playerid, 0x0070D0FF);
	}
	else if (!status)
	{
		loop i in {0 .. 6}
		do
			PlayerTextDrawHide(playerid, FreeroamTDs[playerid][i]);
		done
		CancelSelectTextDraw(playerid);
	}
	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if (playertextid == FreeroamTDs[playerid][4])
	{
		ShowFreeroamTextDraws(playerid, false);
		new rand = random(sizeof(FreeroamSpawn));
  //   	SetSpawnInfo(playerid, PI[playerid][pSkin], 0, FreeroamSpawn[rand][0], FreeroamSpawn[rand][1], FreeroamSpawn[rand][2], FreeroamSpawn[rand][3], 0, 0, 0, 0, 0, 0);
		// SpawnPlayer(playerid);
		SetPlayerPos(playerid, FreeroamSpawn[rand][0], FreeroamSpawn[rand][1], FreeroamSpawn[rand][2]);
		SetPlayerFacingAngle(playerid, FreeroamSpawn[rand][3]);
		SetPlayerSkin(playerid, PI[playerid][pSkin]);
	}

	if (playertextid == FreeroamTDs[playerid][5])
	{
		if (InFreeroam[playerid])
		{
			ShowFreeroamTextDraws(playerid, false);
			SetPlayerPos(playerid, -3256.5210,-279.3459,34.3255);
			SpawnSetup(playerid);
			ToggleTeleport[playerid] = true;
			InFreeroam[playerid] = false;
			SetCbugAllowed(false);

			if (fr_SpawnedVehicle[playerid])
			{
				fr_SpawnedVehicle[playerid] = false;
				DestroyVehicle(fr_VehicleID[playerid]);
			}
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}