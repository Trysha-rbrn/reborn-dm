const MAX_LINES = (10);
new PlayerText: AltChatTD_Player[MAX_LINES],
    	AltChatTD_Text[MAX_PLAYERS][MAX_LINES][128];


stock resetAltChat(playerid)
{
    for(new i = 0; i < MAX_LINES; i ++) {
        strmid(AltChatTD_Text[playerid][i], "_", 0, 2, 2);
        if (_: AltChatTD_Player[i] != INVALID_TEXT_DRAW) PlayerTextDrawSetString(playerid, AltChatTD_Player[i], "RDM");
    }

    return 1;
}

stock toggleAltChat(playerid, bool: toggle = true) {
    if (toggle) for(new i = 0; i < MAX_LINES; i ++) PlayerTextDrawShow(playerid, AltChatTD_Player[i]);
    else for(new i = 0; i < MAX_LINES; i ++) PlayerTextDrawHide(playerid, AltChatTD_Player[i]);

    altchatToggled[playerid] = toggle;
    return 1;
}

stock isAltChatToggled(playerid) {
    if (altchatToggled[playerid]) return 1;
    return 0;
}

stock sendAltChatMessage( message[] ) {
	for( new f = 0; f < MAX_PLAYERS; f++) {
        if( IsPlayerConnected( f ) ) {
            if( PI[ f ][ pAdmin ] >= 1) {
			    for(new i = 0; i < MAX_LINES; i ++) {
			        if (i == MAX_LINES - 1) {
			            strmid(AltChatTD_Text[f][i], message, 0, 128);
			            break;
			        }
			        strmid(AltChatTD_Text[f][i], AltChatTD_Text[f][i + 1], 0, 128);
			    }

			    for(new i = 0; i < MAX_LINES; i ++) {
			        PlayerTextDrawSetString(f, AltChatTD_Player[i], AltChatTD_Text[f][i]);
			    }
			}
		}
	}
    return true;
}
