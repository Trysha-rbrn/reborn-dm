/*=================================================================
* proveriti komandu /changepassword
* napraviti funkciju koja salje igracima u areni da je neko napustio
  example:  leavedm(playerid, arenaid)
  za lobby vec postoji nesto napisano na brzinu
* objekat vrata (desno) na spawnu se ne ucitava lepo
* rework komande /dm (dialog dm id i ime arene, broj igraca, dozvoljen cbug/fpsunloker)
* kada izazvanom stize duel ne ispisuje mu ceo string
* ulaz iz spawna u jail
* rework registracije (na osnovu logina)
* kada ide /dm , da se lepo sve to sredi
* srpske i engleske poruke
* srpske i engleske reci izjednaciti

Trifun:

* dodati samo da odredjena imena imaju pristup odredjin komandama
* dodati cmd da se provere svi admini								[ 100% ]
* dodati cmd da se provere svi premiumi								[ 100% ]
* dodati da se cuvaju premiumi										[ 100% ]
* boja premiuma u chatu												[ 100% ]	
* izbaciti cmd baninfo i da se doda lista banovanih					[ 100% ]
* srediti login dialog i admin code :D								[ 100% ]
* srediti admin help												[ 100% ]
* srediti team DM                                                   [ 0%   ]
* srediti cuvanje boje                                              [ 50% ]
* srediti jail                                                      [ 100% ]
* dodati privilegiju da Premium moze da udje i u DM ako je pun      [ 100% ]
=================================================================*/
#define YSI_NO_HEAP_MALLOC
#pragma unused PlayerColors
// Main Library
#include <a_samp>
#include <weapon-config>
#include <SKY>
#include <a_mysql>
#include <sscanf2>
#include <streamer>
#include <YSI_Coding\y_timers>
#include <YSI_Coding\y_va>
#include <Pawn.CMD>
#include <mSelection>
#include <rAgc>
#include <PawnPlus>
#include <regex>

// Modules
#include "../sss/utils/pawnplus.pwn"
#include "../sss/core/shortcuts.pwn"
#include "../sss/core/enums.pwn"
#include "../sss/utils/variables.pwn"

// MySQL Settings
#include "../sss/mysql/settings.pwn"

// Server
#include "../sss/core/server/init.pwn"

// Player
#include "../sss/core/player/connect.pwn"
#include "../sss/core/admin/duty.pwn"
#include "../sss/core/admin/admini.pwn"
#include "../sss/core/admin/altchat.pwn"
#include "../sss/core/admin/antiaim.pwn"
#include "../sss/systems/freeroam.pwn"
#include "../sss/systems/premium.pwn"
#include "../sss/core/player/commands/cmds.pwn"
#include "../sss/core/player/dialogs.pwn"
#include "../sss/core/player/damage.pwn"

// Character (SKIN)
#include "../sss/core/char/skin_ui_selection.pwn"

// Other
#include "../sss/utils/forwards.pwn"
#include "../sss/utils/functions.pwn"

// TextDraws
#include "../sss/textdraws/main.pwn"
#include "../sss/textdraws/login.pwn"
#include "../sss/textdraws/freeroam.pwn"

// World
#include "../sss/core/world/maps.pwn"

// Systems
#include "../sss/systems/topFive.pwn"
#include "../sss/systems/antiAFk.pwn"
#include "../sss/systems/duelSystem.pwn"
//#include "../sss/systems/tdm.pwn"
//#include "../sss/systems/clans-system.pwn"

// Timers
#include "../sss/utils/timers.pwn"

// Anticheat
#include "../sss/utils/anticheat/weapon.pwn"

// Public entry
main()
then
	loop i in { 0 .. 30 }
	do
		echo " "
	done
	echo * Mode successfully loaded..\n* Max Players: %d, MAX_PLAYERS
fi

public OnPlayerText(playerid, text[])
then
    /**/
   	if(!UlogovanProvera[ playerid ])
	then
		breaker PI[playerid][pLang] of
			_case 1)
				SendClientMessage(playerid, 0xA8115DFF, "ERROR » You aren't logged in.");
			_case 2)
				SendClientMessage(playerid, 0xA8115DFF, "ERROR » Niste ulogovani.");
		esac
		return(false);
	fi
	/**/
    check[PI[playerid][pMuted] -ge 1]
    then
		SendClientMessage(playerid, 0xFF6347AA, "ERROR » You are muted, you can't speak.");
		return false;
	fi
	/**/
	check[GetTickCount()-gtc_text[playerid] -lt 2000 && PI[playerid][pAdmin] -eq 0]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				SendClientMessage(playerid, 0xFF6347AA, "ERROR » You can use chat every 2 seconds.");
			_case 2)
				SendClientMessage(playerid, 0xFF6347AA, "ERROR » Komande mozete koristiti svake 2 sekunde.");
		esac
		return(false);
	ifnot
		new string[256];

		format(string, 256, "{%06x}» %s(%d):"COLOR_WHITE" %s",GetPlayerColor(playerid) >>> 8 , GetName(playerid), playerid, text);
		foreach(new i : Player)
		then
			if(UlogovanProvera[i])
			then
				SendClientMessage(i, -1, string);
			esac
		gtc_text[playerid] = GetTickCount();

	fi
	/**/
	return false;
fi

public OnPlayerDisconnect(playerid, reason)
then
    UlogovanProvera[ playerid ] = false;
	check[InDM[playerid] -eq 1] 
		then InDM1--;
	elif[InDM[playerid] -eq 2] InDM2--;
	elif[InDM[playerid] -eq 3] InDM3--;
 	elif[InDM[playerid] -eq 4] InDM4--;
 	elif[InDM[playerid] -eq 5] InDM5--;
 	elif[InDM[playerid] -eq 6] InDM6--;
 	elif[InDM[playerid] -eq 7] InDM7--;
 	fi
	InDM[playerid] = 0;
	ArenaTime[playerid] = 0;
	PI[playerid][pSQLID] = -1;
	Killed[playerid] = false;
	va_SendClientMessageToAll(-1, "{9F1616}Disconnected: "COLOR_WHITE"%s has left the server.", GetName(playerid));
	//SendDeathMessage(INVALID_PLAYER_ID,playerid, 201);
	SaveAccount(playerid);
	return (true);
fi

public OnPlayerUpdate(playerid)
then
	new drunknew;
    drunknew = GetPlayerDrunkLevel(playerid);
    check[drunknew -lt 100]
    then
        SetPlayerDrunkLevel(playerid, 2000);
    ifnot
        check[pDrunkLevelLast[playerid] -ne drunknew]
        then
            new wfps = pDrunkLevelLast[playerid] - drunknew;
            check[(wfps -gt 0) && (wfps -lt 200)]
                pFPS[playerid] = wfps;
            pDrunkLevelLast[playerid] = drunknew;
	esac
    return true;
fi

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	/*if(newkeys & KEY_SECONDARY_ATTACK)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2.0, 786.4310,2566.1306,1388.3312)) // spawn >> jail
	    {
			SetPlayerPos(playerid, 195.2212,1388.9219,551.2960);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, JAILED_VW);
			SetCameraBehindPlayer(playerid);
			SetTimerEx("Free", 3000, false, "d", playerid);
			breaker PI[playerid][pLang] of
				_case 1)
					GameTextForPlayer(playerid, "~w~OBJECTS ~r~LOADING", 2000, 5);
				_case 2)
					GameTextForPlayer(playerid, "~w~UCITAVANJE ~r~OBJEKATA", 2000, 5);
			esac
			TogglePlayerControllable(playerid, false);
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 2.0, 195.2212,1388.9219,551.2960)) // jail >> Spawn
	    {
			SetPlayerPos(playerid, 786.4310,2566.1306,1388.3312);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, SPAWN_VW);
			SetCameraBehindPlayer(playerid);
			SetTimerEx("Free", 3000, false, "d", playerid);
			breaker PI[playerid][pLang] of
				_case 1)
					GameTextForPlayer(playerid, "~w~OBJECTS ~r~LOADING", 2000, 5);
				_case 2)
					GameTextForPlayer(playerid, "~w~UCITAVANJE ~r~OBJEKATA", 2000, 5);
			esac
			TogglePlayerControllable(playerid, false);
	    }
	}*/
	return 1;
}
public HitRemove(playerid)
then
	TextDrawHideForPlayer(playerid, HitMark[0]);
	return true;

fi
public Free(playerid)
then
	TogglePlayerControllable(playerid, true);

	breaker PI[playerid][pLang] of
		_case 1)
			GameTextForPlayer(playerid, "~w~OBJECTS ~g~LOADED", 2000, 5);
		_case 2)
			GameTextForPlayer(playerid, "~w~OBJEKTI ~g~UCITANI", 2000, 5);
	esac		
	return (true);
fi

public UnFreezePlayer(playerid)
	return TogglePlayerControllable( playerid, 1 );

public OnPlayerDeath(playerid, killerid, reason)
then
	forfeitPlayerDuel(playerid);
	check[InDM[playerid] -ne 0]
    then
        /*TakeSpectateID[playerid] = killerid;
        SetPlayerInterior(playerid, GetPlayerInterior(killerid));
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(killerid));
        TogglePlayerSpectating(playerid, true);
        PlayerSpectatePlayer(playerid, killerid);
        SetPlayerInterior(playerid, GetPlayerInterior(killerid));
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(killerid));   
        TextDrawShowForPlayer(playerid, DTD[0]);
        DeathTimer(playerid);*/
       	new intkiller = GetPlayerInterior(killerid);
        new vwkiller = GetPlayerVirtualWorld(killerid);
        TakeSpectateID[playerid] = killerid;
        TogglePlayerSpectating(playerid, 1);
        PlayerSpectatePlayer(playerid, killerid);
        SetPlayerInterior(playerid, intkiller);
        SetPlayerVirtualWorld(playerid, vwkiller);  
        PlayerTextDrawShow(playerid, DTD[playerid]);
  		PlayerTextDrawSetString(playerid, DTD[playerid], "respawning_in_4...");
        RespawningDM[playerid] = 4;
        //SetTimerEx("StoprSpectate", 4000, false, "i", playerid );
    fi

    if(killerid -ne INVALID_PLAYER_ID)
    then
		Killstreak[killerid]++;
		GiveMoney(killerid, 100);
		if(Killstreak[playerid] -gt 2)
		then
			//strcat(string, "");
			new pName[MAX_PLAYER_NAME+1];
			GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
 			new stringLength = strlen(pName);
			strins(pName, "'s", stringLength);
			va_SendClientMessageToAll(-1, "{d869a1}[Killing Spree]: "COLOR_WHITE"%s{d869a1} has ended "COLOR_WHITE"%s{d869a1} %d killing spree.", GetName(killerid), pName, Killstreak[playerid]);
		fi
		breaker Killstreak[killerid] of
			_case 2)
			    GameTextForPlayer(killerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~DOUBLE KILL!", 3000, 3);
			_case 3)
			    new Float:armour = GetPlayerArmour(killerid, armour);
	    		SetPlayerArmour(killerid, armour+25.0);
		    	GameTextForPlayer(killerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~TRIPLE KILL!", 3000, 3);
		    	new string[124];
		    	format(string, sizeof(string), "\
		    		Spree: "COLOR_WHITE"%s is on 3 killing spree !",
					GetName(killerid));
				SCMTA(COLOR_SERVER2, string);
	    		breaker PI[killerid][pLang] of
					_case 1)
						InfoMessage(killerid, "You got +25 armor because of your 3 killing spree.");
					_case 2)
						InfoMessage(killerid, "Dobili ste +25 armora zbog 3 uzastopna ubistva.");
				esac
			_case 5)
				new Float:armour = GetPlayerArmour(killerid, armour);
	    		SetPlayerArmour(killerid, armour+50);
		    	GameTextForPlayer(killerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~PENTA KILL!", 3000, 3);
		    	new string[124];
		    	format(string, sizeof(string), "\
		    		[Killing Spree]: "COLOR_WHITE"%s is on 5 killing spree !",
					GetName(killerid));
				SCMTA(COLOR_SERVER2, string);
				breaker PI[killerid][pLang] of
					_case 1)
						InfoMessage(killerid, "You got +50 armor because of your 5 killing spree.");
					_case 2)
						InfoMessage(killerid, "Dobili ste +50 armora zbog 5 uzastopna ubistva.");
				esac
		esac
	   
 		if(Killstreak[killerid] -gt 9 && Killstreak[killerid]%5 -eq 0)
	    then
	    	new Float:armour = GetPlayerArmour(killerid, armour);
    		SetPlayerArmour(killerid, armour+99.9);
	    	GameTextForPlayer(killerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~DOMINATING!", 3000, 3);
	    	new string[124];
	    	format(string, sizeof(string), "\
	    		[Killing Spree]: "COLOR_WHITE"%s is on %d killing spree !",
				GetName(killerid), Killstreak[killerid]);
			SCMTA(COLOR_SERVER2, string);
			
    		breaker PI[killerid][pLang] of
				_case 1)
					va_SendClientMessage(killerid, 0x0070D0FF,"You got +100 armor because of your %d killing spree.", Killstreak[killerid]);
				_case 2)
					va_SendClientMessage(killerid, 0x0070D0FF,"Dobili ste +100 armora zbog %d uzastopnih ubistava", Killstreak[killerid]);
			esac
		fi

		breaker PI[killerid][pKills] of
			_case 100)
				breaker PI[killerid][pLang] of
					_case 1)
						InfoMessage(killerid, "Congratulations on being promoted to the rank: Newbie");
					_case 2)
						InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Newbie");
				esac
				PI[killerid][pRank] = 1;
				sql_user_update_integer(killerid, "Rank", PI[killerid][pRank]);
			_case 500)
				breaker PI[killerid][pLang] of
					_case 1)
						InfoMessage(killerid, "Congratulations on being promoted to the rank: Trainee");
					_case 2)
						InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Trainee");
				esac
				PI[killerid][pRank] = 2;
				sql_user_update_integer(killerid, "Rank", PI[killerid][pRank]);
			_case 1000)
	 
				breaker PI[killerid][pLang] of
					_case 1)
						InfoMessage(killerid, "Congratulations on being promoted to the rank: Average");
					_case 2)
						InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Average");
				esac
				PI[killerid][pRank] = 3;
				sql_user_update_integer(killerid, "Rank", PI[killerid][pRank]);
			_case 10000)
				breaker PI[killerid][pLang] of
					_case 1)
						InfoMessage(killerid, "Congratulations on being promoted to the rank: Master");
					_case 2)
						InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Master");
				esac
				PI[killerid][pRank] = 4;
				sql_user_update_integer(killerid, "Rank", PI[killerid][pRank]);
			_case 50000)
				breaker PI[killerid][pLang] of
					_case 1)
						InfoMessage(killerid, "Congratulations on being promoted to the rank: Legend");
					_case 2)
						InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Legend");
				esac
				PI[killerid][pRank] = 5;
				sql_user_update_integer(killerid, "Rank", PI[killerid][pRank]);
			_case 100000)
				breaker PI[killerid][pLang] of
					_case 1)
						InfoMessage(killerid, "Congratulations on being promoted to the rank: God");
					_case 2)
						InfoMessage(killerid, "Cestitamo, unapredjeni ste u rank: Bog");
				esac
				PI[killerid][pRank] = 6;
				sql_user_update_integer(killerid, "Rank", PI[killerid][pRank]);
		esac
		//
	    PI[killerid][pKills]++;
	    PI[killerid][pUbistva]++;
	    SetPlayerScore(killerid, PI[killerid][pKills]);

	    sql_user_update_integer(killerid, "Kills", PI[killerid][pKills]);
	    //SaveAccount(killerid);
	fi

    PI[playerid][pDeaths]++;
    PI[playerid][pSmrti]++;
    Killstreak[playerid] = 0;
    SendDeathMessage(killerid, playerid, reason);
    Killed[playerid] = true;
    SaveAccount(playerid);
    return 1;
fi

public OnPlayerSpawn(playerid)
then
	TogglePlayerSpectating(playerid, false);
	check[TogHud[playerid]]
		TextdrawSetup(playerid);
	
	check[PI[playerid][pJailed] -ne 0]
	then
	    new rand = random(sizeof(JAIL));
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, JAIL[rand][0], JAIL[rand][1], JAIL[rand][2]);
		SetPlayerVirtualWorld(playerid, JAILED_VW);
	
		breaker PI[playerid][pLang] of
			_case 1)
				InfoMessage(playerid, "You are being returned to jail due to not finishing your time in jail.");
			_case 2)
				InfoMessage(playerid, "Vraceni ste u zatvor jer niste odlezali vase vreme zatvora.");
		esac
	fi
	check[InDM[playerid] -eq 0 and GunSpawn[playerid] -eq 0]
	then
		GunSpawn[playerid] = 1;
		GivePlayerWeapon(playerid, 24, 500);
	fi

	
	Killed[playerid] = false;

	check[InDM[playerid] -eq 1]
	then
		new rand = random(sizeof(LVPD));
		SetPlayerVirtualWorld(playerid, LVPD_VW);
		SetPlayerInterior(playerid, 3);
  		SetPlayerPos(playerid, LVPD[rand][0], LVPD[rand][1], LVPD[rand][2]);
		GivePlayerWeapon(playerid, 24, 200);
		SetPlayerHealth(playerid, 99.0);
		SetPlayerArmour(playerid, 99.0);
		SetPlayerSkinn(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(false);

	elif[InDM[playerid] -eq 2]
		new rand = random(sizeof(GTOWN));
		SetPlayerVirtualWorld(playerid, GTOWN_VW);
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, GTOWN[rand][0], GTOWN[rand][1], GTOWN[rand][2]);
		GivePlayerWeapon(playerid, 24, 200);
		GivePlayerWeapon(playerid, 25, 150);
		GivePlayerWeapon(playerid, 33,50);
		SetPlayerHealth(playerid, 99.0);
		SetPlayerArmour(playerid, 99.0);
		SetPlayerSkinn(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(false);
	elif[InDM[playerid] -eq 3]
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
		SetPlayerSkinn(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(false);
	elif[InDM[playerid] -eq 4]
		new rand = random(sizeof(LVPD2));
		SetPlayerVirtualWorld(playerid, LVPD2_VW);
		SetPlayerInterior(playerid, 3);
		SetPlayerPos(playerid, LVPD2[rand][0], LVPD2[rand][1], LVPD2[rand][2]);
		GivePlayerWeapon(playerid, 24, 200);
		GivePlayerWeapon(playerid, 25, 150);
		SetPlayerHealth(playerid, 99.0);
		SetPlayerArmour(playerid, 99.0);
		SetPlayerSkinn(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(false);
	elif[InDM[playerid] -eq 5]
		new rand = random(sizeof(GHOST2));
		SetPlayerVirtualWorld(playerid, GHOST2_VW);
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, GHOST2[rand][0], GHOST2[rand][1], GHOST2[rand][2]);
		GivePlayerWeapon(playerid, 24, 200);
		GivePlayerWeapon(playerid, 25, 150);
		SetPlayerHealth(playerid, 99.0);
		SetPlayerArmour(playerid, 99.0);
		SetPlayerSkinn(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(false);
	elif[InDM[playerid] -eq 6]
		new rand = random(sizeof(WHOUSE));
		SetPlayerVirtualWorld(playerid, WHOUSE_VW);
		SetPlayerInterior(playerid, 1);
		SetPlayerPos(playerid, WHOUSE[rand][0], WHOUSE[rand][1], WHOUSE[rand][2]);
		GivePlayerWeapon(playerid, 24, 200);
		SetPlayerHealth(playerid, 99.0);
		SetPlayerArmour(playerid, 99.0);
		SetPlayerSkinn(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(true);		
	elif[InDM[playerid] -eq 7]
		new rand = random(sizeof(WHOUSE));
		SetPlayerVirtualWorld(playerid, WHOUSE_VW);
		SetPlayerInterior(playerid, 1);
		SetPlayerPos(playerid, SoarArena[rand][0], SoarArena[rand][1], SoarArena[rand][2]);
		GivePlayerWeapon(playerid, 24, 200);
		SetPlayerHealth(playerid, 99.0);
		SetPlayerArmour(playerid, 99.0);
		SetPlayerSkinn(playerid, PI[playerid][pSkin]);
		SetCbugAllowed(false);
	fi

	check [InFreeroam[playerid]]
    then
    	ShowFreeroamTextDraws(playerid, true);
    	// SetPlayerInterior(playerid, 1);
    	// new rand = random(sizeof(FreeroamSpawn));
    	// AddPlayerClass(PI[playerid][pSkin], FreeroamSpawn[rand][0], FreeroamSpawn[rand][1], FreeroamSpawn[rand][2], FreeroamSpawn[rand][3], 0, 0, 0, 0, 0, 0);
    fi
    
    SetPlayerSkinn(playerid, PI[playerid][pSkin]); // mora se zbog TD-a bejbe :D
	return 1;
fi

public OnPlayerRequestClass(playerid, classid )
then
	if(UlogovanProvera[ playerid ] == true )
	then
		GunSpawn[playerid] = 0;
		SetSpawnInfo(playerid, 0, PI[playerid][pSkin], 1727.8054, -1667.5935, 22.5910, 90.00, 24, 500, 0, 0, 0, 0);
	    SetPlayerFacingAngle(playerid, 90.00);
	    SetPlayerScore(playerid, PI[playerid][pKills]);
	    SetPlayerInterior(playerid, 18);
	    SetPlayerVirtualWorld(playerid, SPAWN_VW);
	    SetPlayerHealth(playerid, 99.0);
	    SetPlayerArmour(playerid, 99.0);
	    GivePlayerWeapon(playerid, 24, 500);
	    SetCameraBehindPlayer(playerid);
	    SetTimerEx("Free", 3000, false, "d", playerid);
		breaker PI[playerid][pLang] of
			_case 1)
				GameTextForPlayer(playerid, "~w~OBJECTS ~r~LOADING", 2000, 5);
			_case 2)
				GameTextForPlayer(playerid, "~w~UCITAVANJE ~r~OBJEKATA", 2000, 5);
		esac	
	    TogglePlayerControllable(playerid, false);
	    Killed[playerid] = false;
	fi
    else return(false);
	return 1;
fi

// Creating account
public sql_OnAccountCreate(playerid) then
	if(!IsPlayerConnected(playerid)) then
		return false;
	fi

	TogglePlayerSpectating(playerid, false);
    SetPlayerVirtualWorld(playerid, SPAWN_VW);
	PI[playerid][pSQLID] = cache_insert_id();

	echo "#MySQL: New account created ! Name: %s | SQLID: %d", GetName(playerid), PI[playerid][pSQLID]
	
	PI[playerid][pCash] = 0;
	PI[playerid][pAdmin] = 0;
	PI[playerid][pKills] = 0;
	PI[playerid][pDeaths] = 0;
	PI[playerid][pUbistva] = 0;
	PI[playerid][pSmrti] = 0;
	PI[playerid][pSkin] = 250;
	PI[playerid][pMuted] = 0;
	PI[playerid][pJailed] = 0;
	PI[playerid][pRank] = 0;
	PI[playerid][pDutyTime] = 0.0;
	PI[playerid][pBans] = 0;
	PI[playerid][pKicks] = 0;
	PI[playerid][pJails] = 0;
	PI[playerid][pMutes] = 0;
	PI[playerid][pHours] = 0.0;
	PI[playerid][pPremium] = 0;
	PI[playerid][pACode] = 0;
	PI[playerid][pColor] = 0;
	PI[PlayerWhoInvite][pCreatedClan] = 0;
	PI[PlayerWhoInvite][pClanMembers] = 0;
	PI[playerid][pInClan] = 0;
	return 1;
fi

// Saving account
SaveAccount(playerid)
then
	new query[400];
	format(query, sizeof query, "`Password` = '%d', `Cash`='%d', `Admin`='%d',\
		`Deaths`='%d', `Kills`='%d', `Skin`='%d', `Muted`='%d', `Jailed`='%d', \
		`Rank`='%d', `Lang` = '%d', `DutyTime` = '%f', `Premium` = '%d', \
		`Kicks` = '%d', `Bans` = '%d', `Jails` = '%d', `Mutes` = '%d',\
		`Hours` = '%f', `InClan` = '%d', `ACode` = '%d', `Color` = '%d'",
	PI[playerid][pPass],
	PI[playerid][pCash],
	PI[playerid][pAdmin],
	PI[playerid][pDeaths],
	PI[playerid][pKills],  
	PI[playerid][pSkin],
	PI[playerid][pMuted],
	PI[playerid][pJailed],
	PI[playerid][pRank],
	PI[playerid][pLang],
	PI[playerid][pDutyTime],
	PI[playerid][pPremium],
	PI[playerid][pBans],
	PI[playerid][pKicks],
	PI[playerid][pJails],
	PI[playerid][pMutes],
	PI[playerid][pHours],
	PI[playerid][pInClan],
	PI[playerid][pACode],
	PI[playerid][pColor]);
	mysql_format(SQL, query, sizeof query, "UPDATE `"users_table"` SET %s WHERE `ID`='%d'", query, PI[playerid][pSQLID]);
    mysql_tquery(SQL, query);
	return true;
fi

// Other functions
public checkIPUnban(playerid, const checkIP[]) then
	if(!cache_num_rows()) SendClientMessage(playerid, 0xFF6347AA, "ERROR » That IP isn't banned!");
	else
	then
		/* ** ** */
		new ip[45];
		for (new i; i -lt cache_num_rows(); i++)
		then
			cache_get_value_name(i, "user_ip", ip, 45);
			unbanIP(ip);
		fi
		/* ** ** */
		new string[124];
		format(string, sizeof string, "[UNBAN-IP] %s has sucessfully unnbaned IP address '%s' - (/unbanip)", GetName(playerid), checkIP);
		AMessage(COLOR_YELLOW, string);

		breaker PI[playerid][pLang] of
			_case 1)
				va_SendClientMessage(playerid, 0xFF6347AA, "» You have sucessfully unbanned IP address '%s'.", checkIP);
			_case 2)
			va_SendClientMessage(playerid, 0xFF6347AA, "» Uspesno ste unbanovali ip adresu '%s'.", checkIP);
		esac
	fi
	return 1;
fi
public CheckUnban(playerid, user_name[]) then
	new query[44 + 24];

	if(!cache_num_rows()) 
	then
		breaker PI[playerid][pLang] of
        	_case 1)
        		return SendClientMessage(playerid, 0xFF6347AA, "ERROR » That player was not found in our database.");
    		_case 2)
    			return SendClientMessage(playerid, 0xFF6347AA, "ERROR » Taj igrac nije pronadjen u nasoj databazi.");
		esac
	fi
	else
	then
		va_SendClientMessageToAll(-1, ""COLOR_RED"» Unban: %s unbanned player %s.", GetName(playerid), user_name);
		mysql_format(SQL, query, sizeof query, "DELETE FROM `banned` WHERE `username`='%e'", user_name);
		mysql_tquery(SQL, query);
	fi
	return 1;
fi

// Reg/Log
function check_banned_account(playerid)
then
	if (cache_num_rows())
	then
		ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "BANNED", "Your IP address has been banned from this server!","OK", "X");
		t_Kick(playerid);
	fi
	else
	then
		new query[80];
		ClearFPlayer(playerid, 20);
		mysql_format(SQL, query, sizeof query,"SELECT * FROM `banned` WHERE `username`='%e'", GetName(playerid));
		mysql_tquery(SQL, query, "banned_account","d",playerid);
	fi
	return 1;
fi

function banned_account(playerid)
then
	if (cache_num_rows())
	then
		ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "BANNED", "Your account has been banned from this server!","OK", "X");
		t_Kick(playerid);
	fi
	else
	then
		new query[200];
		mysql_format(SQL, query, sizeof(query), "SELECT * FROM `"users_table"` WHERE `Username` = '%e' LIMIT 1", GetName(playerid));
		mysql_tquery(SQL, query, "check_account_registered", "d", playerid);
	fi
	return 1;
fi

function check_account_registered(playerid)
then
	if (cache_num_rows())
	then
		new query[200];
		mysql_format(SQL, query, sizeof query, "SELECT * FROM `"users_table"` WHERE `Username`='%e'", GetName(playerid));
		mysql_tquery(SQL, query, "sql_LoadPlayerData", "d", playerid);
	fi
	else
	then
		ShowRegisterDialog(playerid);
		InterpolateCameraPos(playerid, 1039.624511, -1955.488037, 227.646926, 1479.973632, -2255.286376, 50.983421, 15000);
    	InterpolateCameraLookAt(playerid, 1043.405029, -1958.182128, 225.789596, 1475.610107, -2252.845214, 50.968055, 1000);
	fi
	return 1;
fi

function sql_LoadPlayerData(playerid)
then
	new query[200];
	cache_get_value_name_int(0, 	"ID", 					PI[playerid][pSQLID]);
    cache_get_value_name_int(0, 	"Password",				PI[playerid][pPass]);
    cache_get_value_name(0, 		"user_ip",				PI[playerid][pPlayerIP]);
    cache_get_value_name_int(0, 	"Cash", 				PI[playerid][pCash]);
    cache_get_value_name_int(0, 	"Admin", 				PI[playerid][pAdmin]);  
	cache_get_value_name_int(0, 	"Deaths",				PI[playerid][pDeaths]);  
	cache_get_value_name_int(0, 	"Kills", 				PI[playerid][pKills]);  
	cache_get_value_name_int(0, 	"Skin", 				PI[playerid][pSkin]);  
	cache_get_value_name_int(0, 	"Muted", 				PI[playerid][pMuted]);
	cache_get_value_name_int(0, 	"Jailed", 				PI[playerid][pJailed]);
	cache_get_value_name_int(0, 	"Rank", 				PI[playerid][pRank]);
	cache_get_value_name_float(0, 	"DutyTime", 			PI[playerid][pDutyTime]);
	cache_get_value_name_int(0, 	"Kicks", 				PI[playerid][pKicks]);
	cache_get_value_name_int(0, 	"Bans", 				PI[playerid][pBans]);
	cache_get_value_name_int(0, 	"Jails", 				PI[playerid][pJails]);
	cache_get_value_name_int(0, 	"Lang", 				PI[playerid][pLang]);
	cache_get_value_name_int(0, 	"Mutes", 				PI[playerid][pMutes]);
	cache_get_value_name_float(0, 	"Hours", 				PI[playerid][pHours]);
	cache_get_value_name_int(0, 	"Premium", 				PI[playerid][pPremium]);
	cache_get_value_name_int(0, 	"InClan", 				PI[playerid][pInClan]);
	cache_get_value_name_int(0, 	"ACode", 				PI[playerid][pACode]);
	cache_get_value_name_int(0, 	"Color", 				PI[playerid][pColor]);
	cache_get_value_name(0, 		"RegistrationDate",		PI[playerid][pRegistrationDate]);
	mysql_format(SQL, query, sizeof query, "SELECT * FROM `"users_table"` WHERE `Username`='%s'", GetName(playerid));
	mysql_tquery(SQL, query, "CheckAccountIsRegForLogin", "d", playerid);	
	return 1;
fi

function CheckAccountIsRegForLogin(playerid)
then
	if (cache_num_rows())
	then
		ShowLoginTextDraws(playerid, true);
		InterpolateCameraPos(playerid, 1039.624511, -1955.488037, 227.646926, 1479.973632, -2255.286376, 50.983421, 15000);
    	InterpolateCameraLookAt(playerid, 1043.405029, -1958.182128, 225.789596, 1475.610107, -2252.845214, 50.968055, 1000);
		new string[80];
		breaker PI[playerid][pLang] of
			_case 1)
				SendClientMessage(playerid, 0xC0C0C0FF, "[Login - Info]: "COLOR_WHITE"You've 30 seconds to enter the password or be kicked!");
				format(string, sizeof string, "____________________\n\n> Type password bellow !\n____________________");

			_case 2)
				SendClientMessage(playerid, 0xC0C0C0FF, "[Login - Info]: "COLOR_WHITE"Imate 30 sekundi da unesete lozinku ili cete biti kikovani!");
				format(string, sizeof string, "____________________\n\n> Unesite lozinku ispod !\n____________________");
		esac

		ShowPlayerDialog(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, ""COLOR_SERVER"R:DM | Login ", string, "Login", "Abort");
		breaker PI[playerid][pColor] of
			_case 0)
				SetPlayerColor(playerid, COLOR_SERVER2);
			_case 1)
				SetPlayerColor(playerid, 0x15FF00AA);
			_case 2)
				SetPlayerColor(playerid, 0xD900FFAA);
			_case 3)
				SetPlayerColor(playerid, 0x000000AA);
			_case 4)
				SetPlayerColor(playerid, 0xFFF700AA);
			_case 5)
				SetPlayerColor(playerid, 0x02A604AA);
			_case 6)
				SetPlayerColor(playerid, 0xFF00C3AA);
			_case 7)
				SetPlayerColor(playerid, 0xFF8400AA);
			_case 8)
				SetPlayerColor(playerid, 0xFFFFFFAA);
			_case 9)
				SetPlayerColor(playerid, 0x33A398AA);
		esac
		LoginTimer[playerid] = SetTimerEx("KickLogin", 30000, false, "d", playerid);
	fi
	else
	then
		SendClientMessage(playerid, 0xFFFFFFFF, "» Your account is not registered on our server!");
		Kick(playerid);
	fi
	return 1;
fi

function KickLogin(playerid)
	return Kick(playerid);

// Dialogs
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
then
	check[dialogid -eq D_LOGIN]
	then
		check[!response] 
			return Kick(playerid);
		if(response)
		then
			new password[24], string[90];
			if (sscanf(inputtext, "s[24]", password)) return ShowPlayerDialog(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, ""COLOR_SERVER"R:DM | Login ", "____________________\n\n> Type password bellow !\n____________________", "Login", "Abort");

			if(udb_hash(password) -eq PI[playerid][pPass])
			then
				if(PI[playerid][pAdmin] -gt 0)
					ShowPlayerDialog(playerid, D_ACODE, DIALOG_STYLE_PASSWORD, ""COLOR_SERVER"R:DM | Admin Code ", "____________________\n\n> Type admin code bellow !\n____________________", "Login", "Abort");
			
				else
				then
					KillTimer(LoginTimer[playerid]);
					ShowLoginTextDraws(playerid, false);
					TogglePlayerSpectating(playerid, false);
					SetSpawnInfo(playerid, 0, PI[playerid][pSkin], 1727.8054, -1667.5935, 22.5910, 90.00, 24, 500, 0, 0, 0, 0);
					SetPlayerInterior(playerid, 18);
					SpawnPlayer(playerid);
					ClearFPlayer(playerid, 30);
					va_SendClientMessageToAll(-1, ""COLOR_SERVER"Connected: "COLOR_WHITE"%s je usao na server.", GetName(playerid)); //CFBA8CFF
					UlogovanProvera[playerid] = true;
					LoggedIn[playerid] = 1;
					SetPlayerVirtualWorld(playerid, SPAWN_VW);
					SetPlayerScore(playerid, PI[playerid][pKills]); 
					GivePlayerMoney(playerid, PI[playerid][pCash]);
					SetPlayerArmour(playerid, 99.9);
					GivePlayerWeapon(playerid, 24, 500);
					new tmpQuery[124], IP[16];
					GetPlayerIp(playerid, IP, sizeof(IP));
					mysql_format(SQL, tmpQuery, sizeof(tmpQuery), "UPDATE `"users_table"` SET `user_ip` = '%e' WHERE `ID` = '%d'", IP, PI[playerid][pSQLID]);
					mysql_tquery(SQL, tmpQuery);
				fi
			fi
			else
			then
				check[PasswordCheck[playerid] -eq 3] return Kick(playerid);
				breaker PI[playerid][pLang] of
					_case 1)
						format(string, sizeof(string), "____________________\n\n> Wrong password!\n> Type password bellow!\n____________________");
					_case 2)
						format(string, sizeof(string), "____________________\n\n> Pogresna lozinka!\n> Unesite lozinku ispod!\n____________________");
				esac
				PasswordCheck[playerid] ++;
				return ShowPlayerDialog(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, ""COLOR_SERVER"R:DM | Login ", string, "Login", "Abort");
			fi
		fi
	fi
	check[dialogid -eq D_ACODE]
	then
		check[!response]
			return Kick(playerid);

		check[response]
		then
			new password;
			if (sscanf(inputtext, "d", password)) return ShowPlayerDialog(playerid, D_ACODE, DIALOG_STYLE_PASSWORD, ""COLOR_SERVER"R:DM | Admin Code ", "____________________\n\n> Type admin code bellow !\n____________________", "Login", "Abort");

			check[password -eq PI[playerid][pACode]]
			then
				KillTimer(LoginTimer[playerid]);
				ShowLoginTextDraws(playerid, false);
				TogglePlayerSpectating(playerid, false);
				SetSpawnInfo(playerid, 0, PI[playerid][pSkin],  1727.8054, -1667.5935, 22.5910, 90.00, 24, 500, 0, 0, 0, 0);
				SetPlayerInterior(playerid, 18);
				SpawnPlayer(playerid);
				ClearFPlayer(playerid, 30);
				check[PI[playerid][pLang] -eq 1]
				then
					new rank[20];
					if(PI[playerid][pRank] -eq 0) rank = "Unknown";
					else if(PI[playerid][pRank] -eq 1) rank = "Newbie";
					else if(PI[playerid][pRank] -eq 2) rank = "Trainee";
					else if(PI[playerid][pRank] -eq 3) rank = "Average";
					else if(PI[playerid][pRank] -eq 4) rank = "Master";
					else if(PI[playerid][pRank] -eq 5) rank = "Legend";
					else if(PI[playerid][pRank] -eq 6) rank = "God";
					va_SendClientMessage(playerid, 0xd4d1d1FF, "Nice to see you again, "COLOR_WHITE"%s{CFBA8C}.", GetName(playerid));
					va_SendClientMessage(playerid, 0xd4d1d1FF, "Your current stats on Reborn Deathmatch is:");
					va_SendClientMessage(playerid, 0xd4d1d1FF, "Cash: "COLOR_WHITE"%d{d4d1d1}, Kills: "COLOR_WHITE"%d{d4d1d1}, Deaths: "COLOR_WHITE"%d{d4d1d1}, Rank: "COLOR_WHITE"%s{d4d1d1}.", PI[playerid][pCash],PI[playerid][pKills], PI[playerid][pDeaths], rank);
					va_SendClientMessageToAll(-1, ""COLOR_SERVER"Connected: "COLOR_WHITE"%s has joined the server.", GetName(playerid));
				elif[PI[playerid][pLang] -eq 2]
					new rank[20];
					if(PI[playerid][pRank] -eq 0) rank = "Unknown";
					else if(PI[playerid][pRank] -eq 1) rank = "Newbie";
					else if(PI[playerid][pRank] -eq 2) rank = "Trainee";
					else if(PI[playerid][pRank] -eq 3) rank = "Average";
					else if(PI[playerid][pRank] -eq 4) rank = "Master";
					else if(PI[playerid][pRank] -eq 5) rank = "Legend";
					else if(PI[playerid][pRank] -eq 6) rank = "God";
					va_SendClientMessage(playerid, 0xd4d1d1FF, "Lepo te je videti opet, "COLOR_WHITE"%s{CFBA8C}.", GetName(playerid));
					va_SendClientMessage(playerid, 0xd4d1d1FF, "Tvoj trenutni status na Reborn Deathmatch-u je:");
					va_SendClientMessage(playerid, 0xd4d1d1FF, "Cash: "COLOR_WHITE"%d{d4d1d1}, Ubistva: "COLOR_WHITE"%d{d4d1d1}, Smrti: "COLOR_WHITE"%d{d4d1d1}, Rank: "COLOR_WHITE"%s{d4d1d1}.", PI[playerid][pCash],PI[playerid][pKills], PI[playerid][pDeaths], rank);
					va_SendClientMessageToAll(-1, ""COLOR_SERVER"Connected: "COLOR_WHITE"%s je usao na server.", GetName(playerid)); //CFBA8CFF
				fi
				UlogovanProvera[playerid] = true;
				LoggedIn[playerid] = 1;
				SetPlayerVirtualWorld(playerid, SPAWN_VW);
				SetPlayerScore(playerid, PI[playerid][pKills]); 
				GivePlayerMoney(playerid, PI[playerid][pCash]);
				SetPlayerArmour(playerid, 99.9);
				GivePlayerWeapon(playerid, 24, 500);
				new tmpQuery[124], IP[24];
				GetPlayerIp(playerid, IP, sizeof(IP));
				mysql_format(SQL, tmpQuery, sizeof(tmpQuery), "UPDATE `"users_table"` SET `user_ip` = '%e' WHERE `ID` = '%d'", IP, PI[playerid][pSQLID]);
				mysql_tquery(SQL, tmpQuery);
			fi
			else return Kick(playerid);
		fi
	fi

	check[dialogid -eq DIALOG_REGISTER]
	then
		check[!response]
			return Kick(playerid);

		check [response]
		then
			check[strlen(inputtext) -lt 6 or strlen(inputtext) -gt 12 ]
				return ShowRegisterDialog(playerid);

			PI[playerid][pPass] = udb_hash(inputtext);

			new query[200];
			mysql_format(SQL, query, sizeof(query), "\
				INSERT INTO `"users_table"` (`Password`, `Username`, `Cash`) \
				VALUES ('%d', '%e', '0')", PI[playerid][pPass], GetName(playerid)
			);
			mysql_tquery(SQL, query, "sql_OnAccountCreate", "d", playerid);
			ShowEmailDialog(playerid);
		fi
	fi

	check[dialogid -eq DIALOG_EMAIL]
	then
		check [!response]
			return Kick(playerid);

		check [response]
		then
			if(!IsValidEmail(inputtext))
				return ShowEmailDialog(playerid);

			new query[200];
			mysql_format(SQL, query, sizeof(query), "UPDATE `"users_table"` SET `Email` = '%e' WHERE `ID` = '%d'", inputtext, PI[playerid][pSQLID]);
			mysql_tquery(SQL, query);

			ShowLanguageDialog(playerid);
		fi
	fi

	check[dialogid -eq DIALOG_CHOOSELANG]
	then
		check [!response]
		then
			SendClientMessage(playerid, 0x327385FF, "Jezik: "COLOR_WHITE"Odabrali ste srpski jezik.");
			PI[playerid][pLang] = 2;
			PI[playerid][pSkin] = 250;
			SaveAccount(playerid);
			SetSpawnInfo(playerid, 0, PI[playerid][pSkin],  1727.8054, -1667.5935, 22.5910, 90.00, 24, 500, 0, 0, 0, 0);
			SetPlayerInterior(playerid, 18);
    		SpawnPlayer(playerid);
    		SetPlayerArmour(playerid, 99.9);
    		UlogovanProvera[playerid] = true;
    		GivePlayerWeapon(playerid, 24, 500);
    		/*new string[70];
    		format(string, sizeof(string), ""COLOR_SERVER"Connected: "COLOR_WHITE"%s has joined the server.", GetName(playerid));
    		SendClientMessageToAll(-1, string);*/
    		va_SendClientMessageToAll(-1, ""COLOR_SERVER"Connected: "COLOR_WHITE"%s has joined the server.", GetName(playerid));
    		new tmpQuery[124], IP[16];
  			GetPlayerIp(playerid, IP, sizeof(IP));
			/*mysql_format(SQL, tmpQuery, sizeof tmpQuery, "UPDATE users SET user_ip='%e' WHERE username='%e'", IP, GetName(playerid));
			mysql_tquery(SQL, tmpQuery);
			new query[128];*/
			mysql_format(SQL, tmpQuery, sizeof(tmpQuery), "UPDATE `"users_table"` SET `user_ip` = '%e' WHERE `ID` = '%d'", IP, PI[playerid][pSQLID]);
			mysql_tquery(SQL, tmpQuery);
			//////////////////////////////////////////////////////////////
			new pyear, pmonth, pday, phour, pminute, psecond, regdate[80];
			getdate(pyear, pmonth, pday);
			gettime(phour, pminute, psecond);
			format(regdate, 80, "%02d/%02d/%d at %02d:%02d:%02d", pday, pmonth, pyear ,phour, pminute, psecond);
			mysql_format(SQL, tmpQuery, sizeof(tmpQuery), "UPDATE `"users_table"` SET `RegistrationDate` = '%e' WHERE `ID` = '%d'", regdate, PI[playerid][pSQLID]);
			mysql_tquery(SQL, tmpQuery);
		fi

		check [response]
		then
			SendClientMessage(playerid, 0x327385FF, "Language: "COLOR_WHITE"You chosen English language..");
			PI[playerid][pLang] = 1;
			PI[playerid][pSkin] = 250;
			SaveAccount(playerid);
			SetSpawnInfo(playerid, 0, PI[playerid][pSkin],  1727.8054, -1667.5935, 22.5910, 90.00, 24, 500, 0, 0, 0, 0);
			SetPlayerInterior(playerid, 18);
    		SpawnPlayer(playerid);
    		SetPlayerArmour(playerid, 99.9);
    		UlogovanProvera[playerid] = true;
    		GivePlayerWeapon(playerid, 24, 500);
    		/*new string[70];
    		format(string, sizeof(string), ""COLOR_SERVER"Connected: "COLOR_WHITE"%s has joined the server.", GetName(playerid));
    		SendClientMessageToAll(-1, string);*/
    		va_SendClientMessageToAll(-1, ""COLOR_SERVER"Connected: "COLOR_WHITE"%s has joined the server.", GetName(playerid));
    		new tmpQuery[124], IP[16];
  			GetPlayerIp(playerid, IP, sizeof(IP));
			mysql_format(SQL, tmpQuery, sizeof(tmpQuery), "UPDATE `"users_table"` SET `user_ip` = '%e' WHERE `ID` = '%d'", IP, PI[playerid][pSQLID]);
			mysql_tquery(SQL, tmpQuery);

			new pyear, pmonth, pday, phour, pminute, psecond, regdate[80];
			getdate(pyear, pmonth, pday);
			gettime(phour, pminute, psecond);
			format(regdate, 80, "%02d/%02d/%d at %02d:%02d:%02d", pday, pmonth, pyear ,phour, pminute, psecond);
			mysql_format(SQL, tmpQuery, sizeof(tmpQuery), "UPDATE `"users_table"` SET `RegistrationDate` = '%e' WHERE `ID` = '%d'", regdate, PI[playerid][pSQLID]);
			mysql_tquery(SQL, tmpQuery);
		fi
	fi
	return 1;
fi
