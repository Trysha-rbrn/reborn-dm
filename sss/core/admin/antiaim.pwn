#include <BustAim>                                                              // novo - trifun

#define BUSTAIM_IS_PAUSED_FUNCTION IsPlayerPaused


public OnPlayerSuspectedForAimbot(playerid,hitid,weaponid,warnings)
{
	new str[199];

	if(warnings && WARNING_OUT_OF_RANGE_SHOT)
	{
	    format(str,sizeof str,"~r~%s(%d) ~w~mozda koristi neku vrstu ~r~AIM-a.",GetPlayerName(playerid),playerid);
		sendAltChatMessage(str);
	}
	if(warnings && WARNING_PROAIM_TELEPORT)
	{
	    format(str,sizeof str,"~r~%s(%d) ~w~mozda koristi neku vrstu ~r~SILENT AIM-a.",GetPlayerName(playerid),playerid);
		sendAltChatMessage(str);
	}
	if(warnings && WARNING_RANDOM_AIM)
	{
	    format(str,sizeof str,"~r~%s(%d) ~w~mozda koristi neku vrstu ~r~AIM-a.",GetPlayerName(playerid),playerid);
		sendAltChatMessage(str);
	}
	if(warnings && WARNING_CONTINOUS_SHOTS)
	{
	    format(str,sizeof str,"~r~%s(%d) ~w~mozda koristi neku vrstu ~r~AIM-a.",GetPlayerName(playerid),playerid);
		sendAltChatMessage(str);
	}
	return 0;
}
