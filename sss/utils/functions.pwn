stock SetPlayerSkinn(playerid, skin)
{
    PlayerTextDrawSetPreviewModel(playerid, GUI[playerid][22], skin);
    PlayerTextDrawShow(playerid, GUI[playerid][22]);
    return SetPlayerSkin(playerid, skin);
}

stock GetName(playerid)
{
    new szName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, szName, sizeof(szName));
    return szName;
}

stock GetPlayerIdFromName(playername[]) 
{
    new name[MAX_PLAYER_NAME];
    foreach(new i : Player) 
    {
        GetPlayerName(i, name, sizeof(name));
        if(strcmp(name, playername)) return i;
    }
    return INVALID_PLAYER_ID;
}

stock GetAdminRank(rank)
{
    new string[14];
    switch(rank)
    {
        case 2: string = "General Admin";
        case 3: string = "Head Admin";
        case 4: string = "Owner";
        default: string = "Trial Admin";
    }
    return string;
}

stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    loop n in {0 .. length}
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock unbanIP(user_ip[]) {
    new query[128];
    
    mysql_format(SQL, query, sizeof query, "UPDATE `banned` SET `user_ip` = 'None' WHERE `user_ip` = '%e'", user_ip);
    mysql_tquery(SQL, query);
    return 1;
}

dm_Kick(playerid)
{
    if(InDM[playerid] == 1) InDM1--;
    else if(InDM[playerid] == 2) InDM2--;
    else if(InDM[playerid] == 3) InDM3--;
    else if(InDM[playerid] == 4) InDM4--;
    else if(InDM[playerid] == 5) InDM5--;
    else if(InDM[playerid] == 6) InDM6--;
    else if(InDM[playerid] == 7) InDM7--;   
    SetPlayerPos(playerid, 1727.8054, -1667.5935, 22.5910);
    SetPlayerFacingAngle(playerid, 90.00);
    SetPlayerInterior(playerid, 18);
    ResetPlayerWeapons(playerid);
    SetPlayerVirtualWorld(playerid, SPAWN_VW);
    SetPlayerHealth(playerid, 99.0);
    GivePlayerWeapon(playerid, 24, 500);
    SetCameraBehindPlayer(playerid);
    SetTimerEx("Free", 3000, false, "d", playerid);
    GameTextForPlayer(playerid, "~w~OBJECTS ~r~LOADING", 2000, 5);
    TogglePlayerControllable(playerid, false);
    InDM[playerid] = 0;
    ArenaTime[playerid] = 0;
    Killstreak[playerid] = 0;
}
ShowRegisterDialog(playerid)
{
    new reg[500];
    format(reg, sizeof(reg), ""COLOR_WHITE"Welcome "COLOR_SERVER"%s"COLOR_WHITE",you can register by entering your password in the field below.", GetName(playerid));
    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, ""COLOR_SERVER"R:DM | Registration ", reg, "Register", "Abort");
    return true;
}
ShowEmailDialog(playerid)
{
    new string[128];
    format(string, sizeof(string), "{0070D0}Email: {FFFFFF}%s, molimo unesite vasu vazecu e-mail adresu..", GetName(playerid));
    ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT,
        "{0070D0}R:DM | E-Mail",
        string,
        "INPUT", "CLOSE"
    );
    return 1;
}
ShowLanguageDialog(playerid)
    return ShowPlayerDialog(playerid, DIALOG_CHOOSELANG, DIALOG_STYLE_MSGBOX,
        "{0070D0}R:DM | Language",
        "{FFFFFF}Please select your language..\n\
        {FFFFFF}Molimo odaberite vas jezik..",
        "English", "Serbian"
    );
GiveMoney(playerid, cash)
{
    PI[playerid][pCash] += cash;
    GivePlayerMoney(playerid, cash);
    return (true);
}
AMessage( color, string[] ) {
    foreach(new i: Player) {
        check [PI[ i ][ pAdmin ] >= 1 || IsPlayerAdmin( i )]
            SendClientMessage( i, color, string ); }
    return true;
}
SpawnSetup(playerid)
{
    ResetPlayerWeapons(playerid);
    SetPlayerFacingAngle(playerid, 269.8542);
    SetPlayerScore(playerid, PI[playerid][pKills]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, SPAWN_VW);
    SetPlayerHealth(playerid, 99.0);
    SetPlayerArmour(playerid, 99.0);
    GivePlayerWeapon(playerid, 24, 500);
    SetCameraBehindPlayer(playerid);
    SetTimerEx("Free", 3000, false, "d", playerid);
    GameTextForPlayer(playerid, "~w~OBJECTS ~r~LOADING", 2000, 5);
    TogglePlayerControllable(playerid, false);
    Killed[playerid] = false;
    return (true);
}

ClearFPlayer(playerid, lines)
{
    check [IsPlayerConnected(playerid)]
        loop i in {0 .. lines}
        do
            SendClientMessage(playerid, -1, "");
        done
    return true;
}

stock GetPlayerIP(playerid)
{
    new p_ip[24];
    GetPlayerIp(playerid, p_ip, sizeof(p_ip));
    return p_ip;
}

stock CheckLoggedIn(playerid)
{
    if (!UlogovanProvera[playerid])
    {
        if(PI[playerid][pLang] == 1)    
            return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You aren't logged in.");
        else if(PI[playerid][pLang] == 2)
            return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Niste ulogovani.");
        return 0;
    }
    return 1;
}
/*public StopSpectate(playerid)
{
    if(RespawningDM[playerid] == 0)
    {
        TakeSpectateID[playerid] = INVALID_PLAYER_ID;
        PlayerTextDrawHide(playerid, DTD[playerid]);
        TogglePlayerSpectating(playerid, 0);
        RespawningDM[playerid] = 0;      
    }
    else
    {

    return 1;
}*/

public sql_user_update_integer( playerid, field[], value ) {

	new q[ 128 ];
	mysql_format( SQL, q, sizeof(q), "UPDATE `"users_table"` SET `%s` = '%d' WHERE `ID` = '%d'", field, value, PI[ playerid ][ pSQLID ] );
    mysql_tquery( SQL, q);
	return 1;
}

public sql_user_update_string(playerid, field[], val[]) {

	new q[ 128 ];
	mysql_format( SQL, q, sizeof(q), "UPDATE `"users_table"` SET `%s` = '%e' WHERE `ID` = '%d'", field, val, PI[ playerid ][ pSQLID ] );
    mysql_tquery( SQL, q);
	return 1;
}

public sql_user_update_float(playerid, field[], Float: val) {

	new q[128];
	mysql_format( SQL, q, sizeof(q), "UPDATE `"users_table"` SET `%s` = '%f' WHERE `ID` = '%d'", field, val, PI[ playerid ][ pSQLID ] );
    mysql_tquery( SQL, q);
	return 1;
}