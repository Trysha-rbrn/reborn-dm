#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    SetCbugAllowed(false);
    CreatePTextdraws(playerid);
    InDM[playerid] = 0; altchatToggled[playerid] = false; Killed[playerid] = false; UlogovanProvera[ playerid ] = false;
    pDrunkLevelLast[playerid] = 0; Killstreak[playerid] = 0; pFPS[playerid] = 0; ReportedID[ playerid ] = -1;
    PI[playerid][pUbistva] = 0; PI[playerid][pSmrti] = 0; PasswordCheck[playerid] = 0; TogHud[playerid] = true;
    lastPM[playerid] = INVALID_PLAYER_ID; LoggedIn[playerid] = 0;
    
	GetPlayerIp(playerid, playerIP[playerid],50);

    //SendDeathMessage(INVALID_PLAYER_ID,playerid, 200);
    /* ** ** */

    new query[200];
    mysql_format(SQL, query, sizeof(query), "SELECT * FROM `banned` WHERE `user_ip` = '%e'", GetPlayerIP(playerid));
    mysql_tquery(SQL, query, "check_banned_account", "d", playerid);
    // TogglePlayerSpectating(playerid, true);
    return Y_HOOKS_CONTINUE_RETURN_1;
}
