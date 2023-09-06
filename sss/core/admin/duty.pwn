#include <YSI_Coding\y_hooks>

// Variables
new
	bool:AdminDuty[MAX_PLAYERS];

// Commands
CMD:aduty(playerid, const params[])
{
	if (!UlogovanProvera[playerid]) return 0;
	check[PI[playerid][pAdmin] -lt 1]
		return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You are not authorised.");
	
	check[!AdminDuty[playerid]]
	then
		new String:dString = str_format("\
			» Administrator %s is on duty.",
			GetName(playerid));
		
		foreach (new i: Player)
		{
			check[PI[i][pAdmin] -ge 1]
				SendFormatMessage(i, 0x42F590FF, dString);
		}

		AdminDuty[playerid] = true;

	elif[AdminDuty[playerid]]
		new String:dString = str_format("\
			Administrator %s is no longer on duty.",
			GetName(playerid));
		
		foreach (new i: Player)
		{
			check[PI[i][pAdmin] -ge 1]
				SendFormatMessage(i, 0xC95D5DFF, dString);
		}

		AdminDuty[playerid] = false;
	fi
	return 1;
}

CMD:adminstats(playerid, const params[])
{
	if (!UlogovanProvera[playerid]) return 0;
	check[PI[playerid][pAdmin] -lt 1]
		return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You are not authorised.");

	breaker PI[playerid][pLang] of
		_case 1)
			new String:str = str_format("\
				{0070D0}Reborn {FFFFFF}Admin Stats\n\
				{0070D0}[1]. {FFFFFF}Hours in staff: {0070D0}%.2f\n\
				{0070D0}[1]. {FFFFFF}Kicks: {0070D0}%d\n\
				{0070D0}[1]. {FFFFFF}Bans: {0070D0}%d\n\
				{0070D0}[1]. {FFFFFF}Jails: {0070D0}%d\n\
				{0070D0}[1]. {FFFFFF}Mutes: {0070D0}%d",
				PI[playerid][pDutyTime], PI[playerid][pKicks],
				PI[playerid][pBans], PI[playerid][pJails],
				PI[playerid][pMutes]
			);

			SPD(playerid, dialog_ADMINSTATS, DIALOG_STYLE_MSGBOX,
				""COLOR_SERVER"R:DM - {FFFFFF}Admin Stats",
				str,
				""COLOR_SERVER"X", ""
			);
		_case 2)
			new String:str = str_format("\
				{0070D0}Reborn {FFFFFF}Admin Stats\n\
				{0070D0}[1]. {FFFFFF}Sati u staffu: {0070D0}%.2f\n\
				{0070D0}[1]. {FFFFFF}Kikovanih: {0070D0}%d\n\
				{0070D0}[1]. {FFFFFF}Banovanih: {0070D0}%d\n\
				{0070D0}[1]. {FFFFFF}Zatvorenih: {0070D0}%d\n\
				{0070D0}[1]. {FFFFFF}Mutiranih: {0070D0}%d",
				PI[playerid][pDutyTime], PI[playerid][pKicks],
				PI[playerid][pBans], PI[playerid][pJails],
				PI[playerid][pMutes]
			);

			SPD(playerid, dialog_ADMINSTATS, DIALOG_STYLE_MSGBOX,
				""COLOR_SERVER"R:DM - {FFFFFF}Admin Stats",
				str,
				""COLOR_SERVER"X", ""
			);
	esac
	return 1;
}

// Updating hours
const SIX_MIN_MSEC = (360000);

ptask UpdateAdminHours[SIX_MIN_MSEC](playerid)
{
	check[AdminDuty[playerid]]
		PI[playerid][pDutyTime] += 0.1;

	PI[playerid][pHours] += 0.1;
	return 1;
}