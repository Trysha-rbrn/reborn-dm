#define FILTERSCRIPT

#include <a_samp>
#include <a_http>
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	return 1;
}
public OnFilterScriptExit()
{
	return 1;
}
forward MyHttpResponse(playerid, response_code, data[]);
public OnPlayerConnect(playerid)
{
	new ip[16], string[256];
	GetPlayerIp(playerid, ip, sizeof ip);
	format(string, sizeof string, "http://ip-api.com/json/%s?fields=proxy,hosting", ip);
	HTTP(playerid, HTTP_GET, string, "", "MyHttpResponse");
    return 1;
}
public MyHttpResponse(playerid, response_code, data[])
{
	new name[MAX_PLAYERS],string[256];
	new ip[16];
	GetPlayerName(playerid, name, sizeof(name));
	GetPlayerIp(playerid, ip, sizeof ip);
	if(strcmp(ip, "127.0.0.1", true) == 0)
	{
		format(string, 256, "[LOCALHOST] %s(%d) has joined the server.", name, playerid);
	    SendClientMessageToAll( 0x09F7DFC8, string);
        return 1;
    }
    if(strfind(data, "true", true) != -1)
    {
        format(string, 256, "%s(%d) has been kicked from the server(VPN).", name, playerid);
   	    SendClientMessageToAll( 0xFF0000FF, string);
   	    SendClientMessage(playerid, 0xFF0000FF, "_________Please disable your proxy/VPN and rejoin!_________");
   	    SetTimerEx("DelayedKick", 100, false, "i", playerid);
   	    return 1;
	}
	return 1;
}

forward DelayedKick(playerid);
public DelayedKick(playerid)
{
    Kick(playerid);
    return 1;
}
#endif
