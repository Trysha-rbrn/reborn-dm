#include <YSI_Coding\y_hooks>

hook OnPlayerDeath(playerid, killerid, reason)
{
	Killstreak[killerid]++;

    check[Killstreak[killerid] -eq 2]
    then
    	GameTextForPlayer(killerid, "~y~DOUBLE KILL!", 3000, 3);
    elif[Killstreak[killerid] -eq 3]
    	GameTextForPlayer(killerid, "~y~TRIPLE KILL!", 3000, 3);

    	new string[124];
    	format(string, sizeof(string), "\
    		Spree: {FFFFFF}%s is on 3 killing spree !",
			GetName(killerid)
		);
    	SCMTA(0x0070D0FF, string);
    elif[Killstreak[killerid] -eq 5]
    	new Float:armour = GetPlayerArmour(killerid, armour);
    	SetPlayerArmour(killerid, armour+25);

    	new string[124];
    	format(string, sizeof(string), "\
    		Spree: {FFFFFF}%s is on 5 killing spree !",
			GetName(killerid)
		);
    	SCMTA(0x0070D0FF, string);
    elif[Killstreak[killerid] -eq 10]
    	new Float:armour = GetPlayerArmour(killerid, armour);
    	SetPlayerArmour(killerid, armour+50);

    	new string[124];
    	format(string, sizeof(string), "\
    		Spree: {FFFFFF}%s is on 10 killing spree !",
			GetName(killerid)
		);
    	SCMTA(0x0070D0FF, string);
    elif[Killstreak[killerid] -eq 15]
    	new Float:armour = GetPlayerArmour(killerid, armour);
    	SetPlayerArmour(killerid, armour+75);

    	new string[124];
    	format(string, sizeof(string), "\
    		Spree: {FFFFFF}%s is on 15 killing spree !",
			GetName(killerid)
		);
    	SCMTA(0x0070D0FF, string);
    elif[Killstreak[killerid] -eq 20]
    	new Float:armour = GetPlayerArmour(killerid, armour);
    	SetPlayerArmour(killerid, 100);

    	new string[124];
    	format(string, sizeof(string), "\
    		Spree: {FFFFFF}%s is on 20 killing spree !",
			GetName(killerid)
		);
    	SCMTA(0x0070D0FF, string);
    fi

	breaker PI[playerid][pKills] of
		_case 100)
			if (PI[killerid][pLang] == 1)
				InfoMessage(killerid, "Congratulations on being promoted to the rank: Newbie");
			else if (PI[killerid][pLang] == 2)
				InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Newbie");

			PI[killerid][pRank] = 1;
			SaveAccount(killerid);
		_case 500)
			if (PI[killerid][pLang] == 1)
				InfoMessage(killerid, "Congratulations on being promoted to the rank: Trainee");
			else if (PI[killerid][pLang] == 2)
				InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Trainee");

			PI[killerid][pRank] = 2;
			SaveAccount(killerid);
		_case 1000)

			if (PI[killerid][pLang] == 1)
				InfoMessage(killerid, "Congratulations on being promoted to the rank: Average");
			else if (PI[killerid][pLang] == 2)
				InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Average");
			PI[killerid][pRank] = 3;
			SaveAccount(killerid);
		_case 10000)
			if (PI[killerid][pLang] == 1)
				InfoMessage(killerid, "Congratulations on being promoted to the rank: Master");
			else if (PI[killerid][pLang] == 2)
				InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Master");
			PI[killerid][pRank] = 4;
			SaveAccount(killerid);
		_case 50000)

			if (PI[killerid][pLang] == 1)
				InfoMessage(killerid, "Congratulations on being promoted to the rank: Legend");
			else if (PI[killerid][pLang] == 2)
				InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Legend");
			PI[killerid][pRank] = 5;
			SaveAccount(killerid);
		_case 100000)
			if (PI[killerid][pLang] == 1)
				InfoMessage(killerid, "Congratulations on being promoted to the rank: God");
			else if (PI[killerid][pLang] == 2)
				InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Bog");
			PI[killerid][pRank] = 6;
			SaveAccount(killerid);
	esac
	//
    PI[killerid][pKills]++;

    PI[playerid][pDeaths]++;
    PI[killerid][pUbistva]++;
    PI[playerid][pSmrti]++;
    
    Killstreak[playerid] = 0;

    SetPlayerScore(killerid, PI[killerid][pKills]);
    if(InDM[playerid] > 0) {
    	foreach (new i : Player) {
    		if (InDM[i] == InDM[playerid]) {
    			SendDeathMessageToPlayer(i, killerid, playerid, reason);
    		}
    	}
    }

    Killed[playerid] = true;
    SaveAccount(playerid);
    SaveAccount(killerid);
    //GiveMoney(killerid, 100);
    return Y_HOOKS_CONTINUE_RETURN_1;
}