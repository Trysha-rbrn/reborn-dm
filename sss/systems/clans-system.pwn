#include <YSI_Coding\y_hooks>

const MAX_CLANS = (10);

enum e_CLAN_ENUM
{
	cSQLID,
	cOwner[24],
	cLeader,
	cMembers,
	cName[24],
	cCreatedClan,
	cInClan
}

new
	e_CLAN_INFO[MAX_PLAYERS][e_CLAN_ENUM],
	Iterator:ClansCreated<MAX_CLANS>,
	Iterator:LoadedClans<MAX_CLANS>,
	AlreadyInvited[MAX_PLAYERS],
	cPlayerWhoInvite,
	cInvitedPlayer[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	// check[PI[playerid][pCreatedClan] -eq 1]
	mysql_tquery(SQL, "SELECT * FROM `clans`", "LoadClans", "d", playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

function LoadClans(playerid)
{
	if (cache_num_rows())
	{
		for (new i; i < cache_num_rows(); i++)
		{
			new id = Iter_Free(LoadedClans);
			cache_get_value_name_int(i, "ClanID", e_CLAN_INFO[playerid][cSQLID]);
			cache_get_value_name(i, "ClanName", e_CLAN_INFO[playerid][cName]);
			cache_get_value_name(i, "CreatedClan", e_CLAN_INFO[playerid][cCreatedClan]);
			cache_get_value_name(i, "ClanOwner", e_CLAN_INFO[playerid][cOwner]);
			cache_get_value_name_int(i, "ClanMembers", e_CLAN_INFO[playerid][cMembers]);
			cache_get_value_name_int(i, "ClanLeader", e_CLAN_INFO[playerid][cLeader]);
			cache_get_value_name_int(i, "cInClan", e_CLAN_INFO[playerid][cInClan]);

			Iter_Add(LoadedClans, id);

			echo loaded clan %d, i
		}

		echo "You're in clan - %s", e_CLAN_INFO[playerid][cName]

		// va_SendClientMessage(playerid, 0x0070D0FF, "(Clan - %s): {FFFFFF}You're member of clan %s!", e_CLAN_INFO[playerid][cName], e_CLAN_INFO[playerid][cName]);	
	}
	return 1;
}

COMMAND:createclan(playerid, const params[])
{
	check[e_CLAN_INFO[playerid][cLeader] -eq 1]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}You've already create clan!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}Vec ste napravili klan!");
		esac
	fi

	check[e_CLAN_INFO[playerid][cInClan] -eq 1]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}You're in clan!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}Vi ste u klanu!");
		esac
	fi

	if (sscanf(params, "s[24]", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/createclan <clan name>");

	e_CLAN_INFO[playerid][cCreatedClan] = 1;
	e_CLAN_INFO[playerid][cLeader] = 1;
	e_CLAN_INFO[playerid][cMembers] = 1;
	PI[playerid][pInClan] = 1;

	format(e_CLAN_INFO[playerid][cOwner], 24, GetName(playerid));
	format(e_CLAN_INFO[playerid][cName], 24, params[0]);
	Iter_Add(ClansCreated, 1);

	new query[200];
	mysql_format(SQL, query, sizeof(query), "\
		INSERT INTO `clans` \
		(`ClanName`, `ClanOwner`, `ClanLeader`, `ClanMembers`, `CreatedClan`) VALUES \
		('%e', '%e', '1', '1', '1')", params[0], GetName(playerid)
	);
	mysql_tquery(SQL, query, "InsertClanID", "d", playerid);
	return 1;
}

COMMAND:inviteclan(playerid, const params[])
{
	check[e_CLAN_INFO[playerid][cLeader] -eq 0]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}You don't have clan!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}Vi nemate klan!");
		esac
	fi

	check[e_CLAN_INFO[playerid][cMembers] -eq 5]
		return 0;

	if (sscanf(params, "r", params[0]))
		return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/inviteclan <playerid>");

	check[AlreadyInvited[params[0]] -eq 1]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}That player already invited!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}Taj igrac je vec pozvan!");
		esac
	fi

	check[PI[params[0]][pInClan] -eq 1]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}That player is already in clan!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}Taj igrac je vec u nekom klanu!");
		esac
	fi

	AlreadyInvited[params[0]] = 1;
	cPlayerWhoInvite = playerid;
	cInvitedPlayer[playerid] = params[0];

	breaker PI[playerid][pLang] of
		_case 1)
			va_SendClientMessage(playerid, 0x0070D0FF, "(Clan - %s): {FFFFFF}Waiting for player %s...", e_CLAN_INFO[playerid][cName], GetName(params[0]));
			va_SendClientMessage(params[0], 0x0070D0FF, "(Clan): {FFFFFF}Player %s invite you in clan - %s!", GetName(playerid), e_CLAN_INFO[playerid][cName]);
			SendClientMessage(params[0], 0x0070D0FF, "(Clan): {FFFFFF}To accept invite type /acceptclaninvite");
		_case 2)
			va_SendClientMessage(playerid, 0x0070D0FF, "(Clan - %s): {FFFFFF}Cekanje igraca %s...", e_CLAN_INFO[playerid][cName], GetName(params[0]));
			va_SendClientMessage(params[0], 0x0070D0FF, "(Clan): {FFFFFF}Igrac %s vas je pozvao u klan - %s!", GetName(playerid), e_CLAN_INFO[playerid][cName]);
			SendClientMessage(params[0], 0x0070D0FF, "(Clan): {FFFFFF}Da prihvatite poziv kucajte /acceptclaninvite");
	esac
	return 1;
}

COMMAND:acceptclaninvite(playerid, const params[])
{
	check[AlreadyInvited[playerid] -eq 0]
	then
		breaker PI[playerid][pLang] of
			_case 1)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}Nobody invites you in clan!");
			_case 2)
				return SendClientMessage(playerid, 0xFF6347AA, "(Error): {FFFFFF}Niko vas nije pozvao u klan!");
		esac
	fi

	breaker PI[cPlayerWhoInvite][pLang] of
		_case 1)
			va_SendClientMessage(cPlayerWhoInvite, 0x0070D0FF, "(Clan - %s): {FFFFFF}Player %s accept your invite to clan!", e_CLAN_INFO[cPlayerWhoInvite][cName], GetName(playerid));
		_case 2)
			va_SendClientMessage(cPlayerWhoInvite, 0x0070D0FF, "(Clan - %s): {FFFFFF}Igrac %s je prihvatio vas poziv u klan!", e_CLAN_INFO[cPlayerWhoInvite][cName], GetName(playerid));
	esac

	breaker PI[playerid][pLang] of
		_case 1)
			va_SendClientMessage(playerid, 0x0070D0FF, "(Clan - %s): {FFFFFF}Welcome to clan! (Leader: %s)", e_CLAN_INFO[cPlayerWhoInvite][cName], e_CLAN_INFO[cPlayerWhoInvite][cOwner]);
		_case 2)
			va_SendClientMessage(playerid, 0x0070D0FF, "(Clan - %s): {FFFFFF}Dobrodosli u klan! (Lider: %s)", e_CLAN_INFO[cPlayerWhoInvite][cName], e_CLAN_INFO[cPlayerWhoInvite][cOwner]);
	esac

	e_CLAN_INFO[cPlayerWhoInvite][cMembers] ++;
	PI[playerid][pInClan] = 1;
	AlreadyInvited[playerid] = 0;

	new query[200];
	mysql_format(SQL, query, sizeof(query), "\
		UPDATE `clans` SET `ClanMembers` = '%d' WHERE `ClanID` = '%d'",
		e_CLAN_INFO[cPlayerWhoInvite][cMembers], e_CLAN_INFO[cPlayerWhoInvite][cSQLID]
	);
	mysql_tquery(SQL, query);
	return 1;
}

COMMAND:myclan(playerid, const params[])
{
	// check[e_CLAN_INFO[playerid][cCreatedClan] -eq 0]
	// 	return 0;

	va_SendClientMessage(playerid, -1, "Clan ID: %d | Name: %s | Members: %d | Leader: %d | Owner: %s", e_CLAN_INFO[playerid][cSQLID], e_CLAN_INFO[playerid][cName], e_CLAN_INFO[playerid][cMembers], e_CLAN_INFO[playerid][cLeader], e_CLAN_INFO[playerid][cOwner]);
	return 1;
}

// Clan Chat
#define CLAN_CHAT_ENABLED

#if defined CLAN_CHAT_ENABLED
COMMAND:cchat(playerid, const params[])
{
	check[PI[playerid][pInClan] -eq 1 or e_CLAN_INFO[playerid][cLeader] -eq 1]
	then
		if (sscanf(params, "s[124]", params[0]))
			return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF}/cchat <text>");

		new string[128];
		format(string, sizeof(string), "*** %s | (%s) says: %s",
			e_CLAN_INFO[playerid][cName], GetName(playerid), params[0]
		);

		// SendClanMessage(0x0070D0FF, string);
	
		new query[200];
		mysql_format(SQL, query, sizeof(query), "SELECT * FROM `clans` WHERE `ClanID` = '%d'",
			e_CLAN_INFO[playerid][cSQLID]
		);
		mysql_tquery(SQL, query, "SendClanMessage", "ds", playerid, string);
	fi
	return 1;
}

function SendClanMessage(const playerid, const message[])
{
	for (new i = 0; i < e_CLAN_INFO[playerid][cMembers]; i++)
		SendClientMessage(i, 0x0070D0FF, message);
	return 1;
}
#endif

COMMAND:turnleaderoff(playerid, const params[])
	return e_CLAN_INFO[playerid][cLeader] = 0;

COMMAND:inclan(playerid, const params[])
	return PI[playerid][pInClan] = 1;

// MySQL DB Clan Insert ID
function InsertClanID(playerid)
	return e_CLAN_INFO[playerid][cSQLID] = cache_insert_id();