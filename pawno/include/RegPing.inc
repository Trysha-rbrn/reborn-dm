/*=======================================================
            
        @include: Regular Ping
        @author: Dejan "Faydee" Jovanovic
        @date: 12th December 2019
        @version: 0.1
        @git: github.com/ElFaydee

        @info:
            This include detects the player's ping .. 
            And if the player's ping is larger than the ping you set, player will be kicked from the server.

=======================================================*/

#if defined _inc_RegPing
    #undef _inc_RegPing
#endif

#if defined _RegPing_included
    #endinput
#endif

#define _RegPing_included

#include <a_samp>
#tryinclude <YSI_Coding\y_timers>

#if !defined MAX_PLAYERS
    #define MAX_PLAYERS (50)
#endif

const MAX_PING 		=	(150); // Maximum = 1000
const PING_CHECKS 	=	(5);

new 
	avgcount[MAX_PLAYERS],
	pping[MAX_PLAYERS];

ptask CheckPing[1000](playerid)
{
	for (new i; i < MAX_PLAYERS; i++)
    {
        avgcount[i]++;

        new 
        	ping = pping[i];

        pping[i] = GetPlayerPing(i);
        pping[i] = ping + pping[i];

        if((avgcount[i] % PING_CHECKS) == 0)
        {
            pping[i] = (pping[i]/avgcount[i]);
            if(pping[i] > MAX_PING)
            {
                new 
                	string[128],
                    name[MAX_PLAYER_NAME];

                GetPlayerName(i, name, sizeof(name));
                
                format(string, sizeof(string), "[AntiCheat]: {FFFFFF}%s has been kicked for high ping ({FF6347}%d{FFFFFF}/{FF6347}%d{FFFFFF})", name, pping[i], MAX_PING);
                SendClientMessageToAll(0xFF6347FF, string);

                va_SendClientMessage(i, 0xFF6347AA, "[AntiCheat]: {FFFFFF}You have been kicked from the server for the high ping ({FF6347}%d{FFFFFF}/{FF6347}%d{FFFFFF})", pping[i], MAX_PING);
                
                Kick(i);
            } 
            else pping[i] = 0;
        }
    }
    return 1;
}
