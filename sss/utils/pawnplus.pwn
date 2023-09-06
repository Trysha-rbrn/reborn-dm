native SendFormatMessage(playerid, color, ConstAmxString:message) = \
	SendClientMessage;

native SendFormatMessageToAll(color, ConstAmxString:message) = \
	SendClientMessageToAll;

native SPD(playerid, dialogid, style, caption[], ConstAmxString:info, button1[], button2[]) = \
	ShowPlayerDialog;

native sql_tquery(MySQL:handle, ConstAmxString:query, const callback[] = "", const format[] = "", {Float,_}:...) = \
	mysql_tquery;