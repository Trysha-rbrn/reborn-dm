public OnPlayerGiveDamageDynamicActor(playerid, actorid, Float:amount, weaponid, bodypart)
{
	/*check[actorid -eq DMActor]
	    callcmd::dm(playerid, "");

	check[actorid -eq HelpActor]
	    callcmd::help(playerid, "");*/
	return 1;
}
public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
    check[issuerid -ne INVALID_PLAYER_ID && (weapon -eq 4 or weapon -eq 41 or weapon -eq 42 or weapon -eq 9 or weapon -eq 35 or weapon -eq 36 or weapon -eq 38 or weapon -eq 16)]
        return 0;

    check[issuerid -ne INVALID_PLAYER_ID]
    then
        check[InDM[playerid] -eq 0 && !IsPlayerDueling(playerid)] return 0;
        new string[50];
        format(string, sizeof(string), ""COLOR_SERVER"-%.2f "COLOR_RED"by %s", amount, GetName(issuerid));
        SetPlayerChatBubble(playerid, string, -1, 13.0, 3200);
        TextDrawShowForPlayer(issuerid, HitMark[0]);
        SetTimerEx("HitRemove", 200, false, "i", issuerid);
    fi
    return (true);
}