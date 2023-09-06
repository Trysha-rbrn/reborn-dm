#if defined top_five_included
	#endinput
#endif
#define top_five_included

/* ** ** */
#if !defined mysql_included
	#error "Include a_mysql.inc first!"
#endif

/* ** ** */
#include <YSI_Coding\y_hooks>
new repeatspawn;
/* ** ** */
static
	tfTimer,
	Text3D: tfLabel[3],
	tfActor[3];

hook OnGameModeInit() {
	repeatspawn = 0;
	tfTimer = SetTimer("topCheck", 60000, true);
	return 1;
}

hook OnGameModeExit() {
	KillTimer(tfTimer);
	return 1;
}

forward topCheck();
public topCheck() {
	/* ** ** */
	mysql_tquery(SQL, "SELECT Username,Kills,Skin FROM users ORDER BY Kills DESC LIMIT 3", "topQuery");
	/* ** ** */
	return 1;
}

forward topQuery();
public topQuery() {
	/* ** ** */
	if(repeatspawn == 0 || repeatspawn == 1)
	{
		repeatspawn ++;
		new tmpSkin = -1, tmpKills = -1, tmpName[MAX_PLAYER_NAME+1], tmpString[124],
		Float: tmpPosX, Float: tmpPosY, Float: tmpPosZ, Float: tmpAngle,
		tmpRows;

		cache_get_row_count(tmpRows);

		if(!tmpRows) return print("U bazi nema korisnickih racuna!");

		for (new i; i < tmpRows; i++) 
		{
			// OVA FUNKC
			cache_get_value_name(i, "Username", tmpName);
			cache_get_value_name_int(i, "Kills", tmpKills);
			cache_get_value_name_int(i, "Skin", tmpSkin);
			/* ** int vars ** */
			breaker i of
				_case 0)
					tmpPosX = 804.2048;
					tmpPosY = 2577.3174;
					tmpPosZ = 1387.3208;
					tmpAngle = 88.2875;
				_case 1)
					tmpPosX = 804.3538;
					tmpPosY = 2580.5747;
					tmpPosZ = 1386.2394;
					tmpAngle = 91.6126;
				_case 2)
					tmpPosX = 804.1870;
					tmpPosY = 2574.1621;
					tmpPosZ = 1385.5393;
					tmpAngle = 91.5142;
			esac
			/* ** actor ** */
			if (IsValidDynamicActor(tfActor[i]))
				DestroyDynamicActor(tfActor[i]);
			tfActor[i] = CreateDynamicActor(tmpSkin, tmpPosX, tmpPosY, tmpPosZ, tmpAngle, 0, 100.0, SPAWN_VW, 0);
			SetDynamicActorInvulnerable(tfActor[i], true);
			/* ** label ** */
			if (IsValidDynamic3DTextLabel(tfLabel[i]))
				DestroyDynamic3DTextLabel(tfLabel[i]);
			format(tmpString, sizeof tmpString, "%s\n{FFFFFF}%i kills", tmpName, tmpKills);
			tfLabel[i] = CreateDynamic3DTextLabel(tmpString, 0x0070D0FF, tmpPosX, tmpPosY, tmpPosZ, 16.0);
		}
	}
	else if (repeatspawn >= 30)
	{
		repeatspawn = 0;
	}
	/* ** ** */
	return 1;
}