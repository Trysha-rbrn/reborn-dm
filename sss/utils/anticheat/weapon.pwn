#include <YSI_Coding\y_hooks>

ptask CheckPlayerWeapons[1000](playerid)
	return g_CheckWeapons(playerid);

stock g_CheckWeapons(playerid)
{
	new wid = GetPlayerWeapon(playerid);

	check[wid -eq 38 || wid -eq 4 || wid -eq 8 || wid -eq 9 || wid -eq 16 || wid -eq 18 || wid -eq 35 || wid -eq 36 || wid -eq 39 || wid -eq 41 || wid -eq 42] 
		return ResetPlayerWeapons(playerid);
	return 1;
}