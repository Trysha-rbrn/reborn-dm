/*
 *
 *	tvrdiscu jebem ti majku
 *
 *
 */

/* ** Includes ** */
#include 							< YSI_Coding\y_hooks >

/* ** Definitions ** */
#define COL_DUEL 					"{3BB8D1}"
#define COL_RED                 	"{FF6347}"
#define COL_BLUE		           	"{00C0FF}"
#define COL_GREY                    "{C0C0C0}"
#define COL_WHITE                   "{FFFFFF}"
#define erase(%0)                   (%0[0]='\0')
#define strmatch(%1,%2)             (!strcmp(%1,%2,true))
stock szBigString[ 256 ];
stock szSmallString[ 32 ];


stock number_format( { _, Float, Text3D, Menu, Text, DB, DBResult, bool, File }: variable, prefix = '\0', decimals = -1, thousand_seperator = ',', decimal_point = '.', tag = tagof( variable ) )
{
    static
        s_szReturn[ 32 ],
        s_szThousandSeparator[ 2 ] = { ' ', EOS },
        s_iDecimalPos,
        s_iChar,
        s_iSepPos
    ;

    if ( tag == tagof( bool: ) )
    {
        if ( variable )
            memcpy( s_szReturn, "true", 0, 5 * ( cellbits / 8 ) );
        else
            memcpy( s_szReturn, "false", 0, 6 * ( cellbits / 8 ) );

        return s_szReturn;
    }
    else if ( tag == tagof( Float: ) )
    {
        if ( decimals == -1 )
            decimals = 8;

        format( s_szReturn, sizeof( s_szReturn ), "%.*f", decimals, variable );
    }
    else
    {
        format( s_szReturn, sizeof( s_szReturn ), "%d", variable );

        if ( decimals > 0 )
        {
            strcat( s_szReturn, "." );

            while ( decimals-- )
                strcat( s_szReturn, "0" );
        }
    }

    s_iDecimalPos = strfind( s_szReturn, "." );

    if ( s_iDecimalPos == -1 )
        s_iDecimalPos = strlen( s_szReturn );
    else
        s_szReturn[ s_iDecimalPos ] = decimal_point;

    if ( s_iDecimalPos >= 4 && thousand_seperator )
    {
        s_szThousandSeparator[ 0 ] = thousand_seperator;

        s_iChar = s_iDecimalPos;
        s_iSepPos = 0;

        while ( --s_iChar > 0 )
        {
            if ( ++s_iSepPos == 3 && s_szReturn[ s_iChar - 1 ] != '-' )
            {
                strins( s_szReturn, s_szThousandSeparator, s_iChar );

                s_iSepPos = 0;
            }
        }
    }

    if ( prefix != '\0' )
    {
        static
            prefix_string[ 2 ];

        prefix_string[ 0 ] = prefix;
        strins( s_szReturn, prefix_string, s_szReturn[ 0 ] == '-' ); // no point finding -
    }
    return s_szReturn;
}
#define cash_format(%0) \
    (number_format(%0, .prefix = '$'))

#define DIALOG_DUEL 						1173
#define DIALOG_DUEL_PLAYER					1174
#define DIALOG_DUEL_LOCATION				1175
#define DIALOG_DUEL_WEAPON					1176
#define DIALOG_DUEL_WEAPON_TWO 				1178
#define DIALOG_DUEL_HEALTH 					1179
#define DIALOG_DUEL_ARMOUR					1180

#define function%1(%2)                      forward%1(%2); public%1(%2)

stock Float: GetDistanceBetweenPlayers( iPlayer1, iPlayer2, &Float: fDistance = Float: 0x7F800000, bool: bAllowNpc = false )
{
    static
    	Float: fX, Float: fY, Float: fZ;

    if ( ! bAllowNpc && ( IsPlayerNPC( iPlayer1 ) || IsPlayerNPC( iPlayer2 ) ) ) // since this command is designed for players
        return fDistance;

    if( GetPlayerVirtualWorld( iPlayer1 ) == GetPlayerVirtualWorld( iPlayer2 ) && GetPlayerPos( iPlayer2, fX, fY, fZ ) )
		fDistance = GetPlayerDistanceFromPoint( iPlayer1, fX, fY, fZ );

    return fDistance;
}

/* ** Variables ** */
enum E_DUEL_DATA
{
	E_PLAYER,						E_WEAPON[ 2 ],						E_COUNTDOWN,
	Float: E_ARMOUR, 				Float: E_HEALTH, 					E_LOCATION_ID,
	E_TIMER
};

enum E_DUEL_LOCATION_DATA
{
	E_NAME [ 22 ],					Float: E_POS_ONE[ 4 ], 				Float: E_POS_TWO[ 4 ]
};

new
	g_WeaponList					[ ] = 								{ 0, 24, 25, 31, 34 },
	g_duelData 						[ MAX_PLAYERS ][ E_DUEL_DATA ],
	g_duelLocationData 				[ ][ E_DUEL_LOCATION_DATA ] =
	{
		{ "SF Bridge",				{ -1393.5670, 681.3549 ,3.0703, 212.1914 }, { -1378.9456, 660.3615, 3.0703, 33.3649 } },
		{ "Star Power",				{ 1553.6558, -1353.5206, 329.4585, 93.8621  }, { 1531.1318, -1353.1356, 329.4535, 269.8542 } },
		{ "Ghost Town",				{ -403.4645, 2249.0618, 42.4297, 101.5275 }, { -388.7307, 2197.8704, 42.4235, 276.4343 } },
		{ "Tennis Courts",			{ 755.93790, -1280.710, 13.5565, 1.3250 }, { 755.93960, -1238.688, 13.5516, 175.2829 } },
		{ "Underwater World",		{ 520.59600, -2125.663, -28.257, 357.6445 }, { 517.96600, -2093.610, -28.257, 189.6402 } },
		{ "Grove Street",			{ 2476.4580, -1668.631, 13.3249, 271.4538 }, { 2501.1560, -1667.655, 13.3559, 90.0969 } },
		{ "Ocean Docks",			{ 2683.5440, -2485.137, 13.5425, 1.8403 }, { 2683.8470, -2433.726, 13.5553, 178.1029 } },
		{ "Gacia Baseball Ground",	{ -2305.7549, 92.3505, 35.3516, 46.5659 }, { -2322.0908, 108.5021, 35.3984, 224.8133 } }
	},

	bool: p_playerDueling			[ MAX_PLAYERS char ],
	p_duelInvitation           		[ MAX_PLAYERS ][ MAX_PLAYERS ];

hook OnPlayerConnect(playerid)
{
	p_playerDueling{ playerid } 				= false;
	g_duelData[ playerid ][ E_PLAYER ] 			= INVALID_PLAYER_ID;
	g_duelData[ playerid ][ E_WEAPON ][ 0 ] 	= 0;
	g_duelData[ playerid ][ E_WEAPON ][ 1 ] 	= 0;
	g_duelData[ playerid ][ E_HEALTH ] 			= 100.0;
	g_duelData[ playerid ][ E_ARMOUR ] 			= 100.0;
	return 1;
}

hook OnPlayerDisconnect( playerid, reason )
{
	forfeitPlayerDuel( playerid );
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	forfeitPlayerDuel( playerid );
	return 1;
}

SetPlayerSpawnAfterDuel( playerid )
{
	if ( IsPlayerDueling( playerid ))
	{
		// teleport back to lobby
		SetPlayerPos(playerid, 1727.8054, -1667.5935, 22.5910);
		ResetPlayerWeapons(playerid);
		SetPlayerVirtualWorld( playerid, SPAWN_VW );
		SetPlayerInterior( playerid, 18 );
		GivePlayerWeapon(playerid, 24, 500);
		SpawnPlayer(playerid);
		/*SetPlayerFacingAngle(playerid, 269.8542);
		ResetPlayerWeapons(playerid);
		SetPlayerInterior( playerid, 0 );
		SetPlayerVirtualWorld( playerid, SPAWN_VW );
		GivePlayerWeapon(playerid, 24, 500);*/

		// reset duel variables
		p_playerDueling{ playerid } 		= false;
		g_duelData[ playerid ][ E_PLAYER ] 	= INVALID_PLAYER_ID;
		return Y_HOOKS_BREAK_RETURN_1;
	}
	return 1;
}

/*
/hook OnPlayerEnterDynamicCP( playerid, checkpointid )
DEFINE_HOOK_REPLACEMENT(OnPlayer, OP_); 
hook OP_PickUpDynamicPickup(playerid, pickupid)
{
	if ( GetPlayerState( playerid ) == PLAYER_STATE_SPECTATING ) {
		return 1;
	}
	if ( pickupid == g_DuelCheckpoint && lastSendDuel[playerid] <= gettime())
	{
		ShowPlayerDuelMenu( playerid );
		lastSendDuel[playerid] = gettime() + 5;
		return 1;
	}
	return 1;
}*/

hook OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	if ( ( dialogid == DIALOG_DUEL ) && response )
	{
		erase ( szBigString );

		switch ( listitem )
		{
			case 0: ShowPlayerDialog( playerid, DIALOG_DUEL_PLAYER, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Select a Player", ""COL_BLUE"Please type the name of the player you wish to duel:\n\n"COL_GREY"Note: You can enter partially their names.", "Select", "Back");
			case 1: ShowPlayerDialog( playerid, DIALOG_DUEL_HEALTH, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Health", ""COL_BLUE"Enter the amount of health you will begin with:\n\n"COL_GREY"Note: The default health is 100.0.", "Select", "Back");
			case 2: ShowPlayerDialog( playerid, DIALOG_DUEL_ARMOUR, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Armour", ""COL_BLUE"Enter the amount of armour you will begin with:\n\n"COL_GREY"Note: The default armour is 100.0.", "Select", "Back");

			case 3:
			{
				new
					iWeapon = g_duelData [ playerid ] [ E_WEAPON ] [ 0 ];

				for ( new i = 0; i < sizeof( g_WeaponList ); i ++) {
					format( szBigString, sizeof( szBigString ), "%s%s%s\n", szBigString, iWeapon == g_WeaponList [ i ] ? ( COL_WHITE ) : ( COL_WHITE ), ReturnWeaponName( g_WeaponList[ i ] ) );
				}

				ShowPlayerDialog( playerid, DIALOG_DUEL_WEAPON, DIALOG_STYLE_LIST, ""COL_BLUE"Duel Settings - Change Primary Weapon", szBigString, "Select", "Back");
			}

			case 4:
			{
				new
					iWeapon = g_duelData [ playerid ] [ E_WEAPON ] [ 1 ];

				for ( new i = 0; i < sizeof( g_WeaponList ); i ++ ) {
					format( szBigString, sizeof( szBigString ), "%s%s%s\n", szBigString, iWeapon == g_WeaponList [ i ] ? ( COL_WHITE ) : ( COL_WHITE ), ReturnWeaponName( g_WeaponList [ i ]) );
				}

				ShowPlayerDialog( playerid, DIALOG_DUEL_WEAPON_TWO, DIALOG_STYLE_LIST, ""COL_BLUE"Duel Settings - Change Secondary Weapon", szBigString, "Select", "Back");
			}

			case 5:
			{
				new
					iLocationID = g_duelData [ playerid ][ E_LOCATION_ID ];

				for ( new i = 0; i < sizeof( g_duelLocationData ); i ++ ) {
					format( szBigString, sizeof( szBigString ), "%s%s%s\n", szBigString, iLocationID == i ? ( COL_WHITE ) : ( COL_WHITE ), g_duelLocationData[ i ][ E_NAME ] );
				}

				ShowPlayerDialog(playerid, DIALOG_DUEL_LOCATION, DIALOG_STYLE_LIST, ""COL_DUEL"Duel Settings - Change Location", szBigString, "Select", "Back");
			}
			case 6: 
			{
				g_duelData[ playerid ][ E_WEAPON ][ 0 ] 	= 0;
				g_duelData[ playerid ][ E_WEAPON ][ 1 ] 	= 0;
				g_duelData[ playerid ][ E_HEALTH ] 			= 100.0;
				g_duelData[ playerid ][ E_ARMOUR ] 			= 100.0;
				g_duelData[ playerid ][ E_PLAYER ] 			= -1;
				ShowPlayerDuelMenu(playerid);
			}

			case 7:
			{
				new pID = g_duelData [ playerid ][ E_PLAYER ];

				if ( !IsPlayerConnected( pID ) )
				{
					va_SendClientMessage(playerid, 0xFF6347AA, "» You haven't slected anyone to duel.");
					return ShowPlayerDuelMenu( playerid );
				}

				p_duelInvitation[ playerid ][ pID ] = gettime( ) + 30;

				new duelmap[24];
				if(g_duelData[ playerid ][ E_LOCATION_ID ] == 0)
				duelmap = "SF Bridge";
				else if(g_duelData[ playerid ][ E_LOCATION_ID ] == 1)
				duelmap = "Star Power";
				else if(g_duelData[ playerid ][ E_LOCATION_ID ] == 2)
				duelmap = "Ghost Town";
				else if(g_duelData[ playerid ][ E_LOCATION_ID ] == 3)
				duelmap = "Tennis Courts";
				else if(g_duelData[ playerid ][ E_LOCATION_ID ] == 4)
				duelmap = "Underwater World";
				else if(g_duelData[ playerid ][ E_LOCATION_ID ] == 5)
				duelmap = "Grove Street";
				else if(g_duelData[ playerid ][ E_LOCATION_ID ] == 6)
				duelmap = "Ocean Docks";
				else if(g_duelData[ playerid ][ E_LOCATION_ID ] == 7)
				duelmap = "Gacia Baseball Ground";

				new gunname[32], gunname2[32], string[360];
				GetWeaponName(g_duelData[ playerid ][ E_WEAPON ][ 0 ], gunname, sizeof(gunname));
				GetWeaponName(g_duelData[ playerid ][ E_WEAPON ][ 1 ], gunname2, sizeof(gunname2));

				va_SendClientMessage(playerid, 0x42F598FF, "» Duel: {FFFFFF}You have sent a duel invitation to %s.", GetName(pID));
				va_SendClientMessage(pID, 0x42F598FF, "» Duel: %s {FFFFFF}has invited you to duel ( {42F598}/duel accept %d {FFFFFF}).", GetName(playerid), playerid);
				format(string, sizeof(string), "» HP/Armour: {FFFFFF}%.2f{42F598}/{FFFFFF}%.2f\n\
				{42F598} Map: {FFFFFF}%s\n\
				{42F598}Weapons: {FFFFFF}%s{42F598}/{FFFFFF}%s{42F598}.", g_duelData[ playerid ][ E_HEALTH ], g_duelData[ playerid ][ E_ARMOUR ], duelmap, gunname, gunname2);
				va_SendClientMessage(pID, 0x42F598FF, string);
				//va_SendClientMessage(pID, 0x42F598FF, "» Health: {FFFFFF}%.2f{42F598}, Armour: {FFFFFF}%.2f{42F598}, Map: {FFFFFF}%s{42F598}, Primary Weapon: {FFFFFF}%s{42F598}, Secondary: {FFFFFF}%s{42F598}.", g_duelData[ playerid ][ E_HEALTH ], g_duelData[ playerid ][ E_ARMOUR ], duelmap, gunname, gunname2);

			}
		}
		return 1;
	}

	else if ( dialogid == DIALOG_DUEL_PLAYER )
	{
		if ( !response )
			return ShowPlayerDuelMenu( playerid );

		new
			pID
		;

		if ( sscanf( inputtext, "u", pID) )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_PLAYER, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Select a Player", ""COL_DUEL"Please type the name of the player you wish to duel:\n\n"COL_GREY"Note: You can enter partially their names.", "Select", "Back" );

		if (InFreeroam[pID])
		{
			breaker PI[playerid][pLang] of
				_case 1)
					return SendClientMessage(playerid, 0xFF6347AA, "» That player is in  freeroam");
				_case 2)
					return SendClientMessage(playerid, 0xFF6347AA, "» Taj igrac je u freeroam-u.");
			esac
		}

		if ( pID == playerid )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_PLAYER, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Select a Player", ""COL_DUEL"Please type the name of the player you wish to duel:\n\n"COL_RED"You can't invite yourself to duel!", "Select", "Back" );

		if ( pID == INVALID_PLAYER_ID || !IsPlayerConnected( pID ) )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_PLAYER, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Select a Player", ""COL_DUEL"Please type the name of the player you wish to duel:\n\n"COL_RED"Player is not connected!", "Select", "Back" );

		if ( IsPlayerDueling( playerid ) )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_PLAYER, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Select a Player", ""COL_DUEL"Please type the name of the player you wish to duel:\n\n"COL_RED"You are already in a duel!", "Select", "Back" );

		if ( IsPlayerDueling( pID ) )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_PLAYER, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Select a Player", ""COL_DUEL"Please type the name of the player you wish to duel:\n\n"COL_RED"This player is already in a duel!", "Select", "Back" );

		if ( GetDistanceBetweenPlayers( playerid, pID ) > 25.0 )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_PLAYER, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Select a Player", ""COL_DUEL"Please type the name of the player you wish to duel:\n\n"COL_RED"The player you wish to duel is not near you.", "Select", "Back" );

		//if ( IsPlayerJailed( pID ) )
			//return ShowPlayerDialog( playerid, DIALOG_DUEL_PLAYER, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Select a Player", ""COL_DUEL"Please type the name of the player you wish to duel:\n\n"COL_RED"You can't duel this person right now, they are currently in jail.", "Select", "Back" );

		va_SendClientMessage(playerid, 0x42F598FF, "» Duel: {FFFFFF}You have selected {42F598}%s {FFFFFF}as your opponent.", GetName(pID));

		g_duelData[ playerid ][ E_PLAYER ] = pID;
		return ShowPlayerDuelMenu( playerid ), 1;
	}

	else if ( dialogid == DIALOG_DUEL_LOCATION )
	{
		if ( !response )
			return ShowPlayerDuelMenu( playerid );

		if ( g_duelData[ playerid ][ E_LOCATION_ID ] == listitem )
		{
			va_SendClientMessage(playerid, 0xFF6347AA, "» You have already selected this location.");
			return ShowPlayerDuelMenu( playerid );
		}

		va_SendClientMessage(playerid, 0x42F598FF, "» Duel: {FFFFFF}You have changed the duel location to {42F598}'%s'{FFFFFF}.", g_duelLocationData [ listitem ][ E_NAME ]);

		g_duelData[ playerid ][ E_LOCATION_ID ] = listitem;
		ShowPlayerDuelMenu( playerid );
		return 1;
	}

	else if ( dialogid == DIALOG_DUEL_WEAPON )
	{
		if ( !response )
			return ShowPlayerDuelMenu( playerid );

		if ( g_duelData[ playerid ][ E_WEAPON ][ 0 ] == g_WeaponList[ listitem ] )
		{
			va_SendClientMessage(playerid, 0xFF6347AA, "» You have already selected this weapon.");
			return ShowPlayerDuelMenu(playerid);
		}

		va_SendClientMessage(playerid, 0x42F598FF, "» Duel: You have changed Pripary Weapon to {42F598}'%s'{FFFFFF}", ReturnWeaponName( g_WeaponList[ listitem ]) );
		g_duelData[ playerid ][ E_WEAPON ][ 0 ] = g_WeaponList[ listitem ];
		ShowPlayerDuelMenu( playerid );
		return 1;
	}

	else if ( dialogid == DIALOG_DUEL_WEAPON_TWO )
	{
		if ( !response )
			return ShowPlayerDuelMenu( playerid );

		if ( g_duelData[ playerid ][ E_WEAPON ][ 1 ] == g_WeaponList[ listitem ] )
		{
			va_SendClientMessage(playerid, 0xFF6347AA, "» You have already selected this weapon.");
			return ShowPlayerDuelMenu( playerid );
		}

		va_SendClientMessage(playerid, 0x42F598FF, "» Duel: You have changed Secondary Weapon to {42F598}'%s'.", ReturnWeaponName( g_WeaponList[ listitem ]) );
		g_duelData[ playerid ][ E_WEAPON ][ 1 ] = g_WeaponList[ listitem ];
		ShowPlayerDuelMenu( playerid );
		return 1;
	}

	else if ( dialogid == DIALOG_DUEL_HEALTH )
	{
		if ( !response )
			return ShowPlayerDuelMenu( playerid );

		new
			Float: fHealth;

		if ( sscanf( inputtext, "f", fHealth ) )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_HEALTH, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Health", ""COL_DUEL"Enter the amount of health you will begin with:\n\n"COL_GREY"Note: The default health is 100.0.", "Select", "Back" );

		if ( !( 1.0 <= fHealth <= 100.0 ) )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_HEALTH, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Health", ""COL_DUEL"Enter the amount of health you will begin with:\n\n"COL_RED"The amount you have entered is a invalid amount, 1 to 100 only!", "Select", "Back" );

		va_SendClientMessage(playerid, 0x42F598FF, "» Duel: {FFFFFF} You have changed Health to {42F598}'%0.2f%%'{FFFFFF}", fHealth);
		g_duelData[ playerid ][ E_HEALTH ] = fHealth;
		ShowPlayerDuelMenu( playerid );
		return 1;
	}

	else if (dialogid == DIALOG_DUEL_ARMOUR)
	{
		if ( !response )
			return ShowPlayerDuelMenu( playerid );

		new
			Float: fArmour;

		if ( sscanf( inputtext, "f", fArmour ) )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_ARMOUR, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Armour", ""COL_DUEL"Enter the amount of armour you will begin with:\n\n"COL_GREY"Note: The default armour is 100.0.", "Select", "Back" );

		if ( !( 0.0 <= fArmour <= 100.0 ) )
			return ShowPlayerDialog( playerid, DIALOG_DUEL_ARMOUR, DIALOG_STYLE_INPUT, ""COL_DUEL"Duel Settings - Armour", ""COL_DUEL"Enter the amount of armour you will begin with:\n\n"COL_RED"The amount you have entered is a invalid amount, 0 to 100 only!", "Select", "Back" );

		va_SendClientMessage(playerid, 0x42F598FF, "» Duel: {FFFFFF} You have changed Armour to {42F598}'%0.2f%%'{FFFFFF}.", fArmour);
		g_duelData[ playerid ][ E_ARMOUR ] = fArmour;
		ShowPlayerDuelMenu( playerid );
		return 1;
	}
	return 1;
}

/* ** Commands ** */
CMD:duel( playerid, params[ ] )
{
	if (!UlogovanProvera[playerid]) return 0;
	if (InFreeroam[playerid])
	{
		breaker PI[playerid][pLang] of
			_case 1)
				return va_SendClientMessage(playerid, 0xFF6347AA, "» You cannot use this command in freeroam.");
			_case 2)
				return va_SendClientMessage(playerid, 0xFF6347AA, "» Ovu komandu ne mozete korisiti u freeroam-u.");
		esac
	}
	if ( !strcmp(params, "accept", false, 6))
	{
		new
			targetid;

		if ( sscanf( params[ 7 ], "u", targetid ) )
			return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF} /duel menu.");

		if ( !IsPlayerConnected( targetid ) )
			return va_SendClientMessage(playerid, 0xFF6347AA, "Â» You do not have any duel invitations to accept.");

		if ( gettime( ) > p_duelInvitation[ targetid ][ playerid ] )
			return va_SendClientMessage(playerid, 0xFF6347AA, "Â» You are not invited to duel or duel has expired, so you cant accept it.");

		if ( IsPlayerDueling( playerid ) )
			return va_SendClientMessage(playerid, 0xFF6347AA, "Â» You cannot accept this invite as you are currently dueling.");

		va_SendClientMessage(targetid, 0x42F598FF, "Â» Duel: %s {FFFFFF}has accepted your duel invitation.", GetName(playerid));
		va_SendClientMessage(playerid, 0x42F598FF, "Â» Duel: {FFFFFF}You have accepted {42F598}%s's {FFFFFF}duel invitation.", GetName(targetid));

		p_playerDueling{ targetid } = true;
		p_playerDueling{ playerid } = true;

		g_duelData[ targetid ][ E_PLAYER ] = playerid;
		g_duelData[ playerid ][ E_PLAYER ] = targetid;

		new
			iLocation = g_duelData[ targetid ][ E_LOCATION_ID ];

		ResetPlayerWeapons( targetid );
		RemovePlayerFromVehicle( targetid );
		SetPlayerArmour( targetid, g_duelData[ targetid ][ E_ARMOUR ]);
		SetPlayerHealth( targetid, g_duelData[ targetid ][ E_HEALTH ]);
		SetPlayerVirtualWorld( targetid, targetid + 1 );
		SetPlayerPos( targetid, g_duelLocationData[ iLocation ][ E_POS_TWO ][0], g_duelLocationData[ iLocation ][ E_POS_TWO ][1], g_duelLocationData[ iLocation ][ E_POS_TWO ][2] );
		SetPlayerFacingAngle(targetid, g_duelLocationData[ iLocation ][ E_POS_TWO ][3]);
		SetCameraBehindPlayer(targetid);

		ResetPlayerWeapons( playerid );
		RemovePlayerFromVehicle( playerid );
		SetPlayerArmour( playerid, g_duelData[ targetid ][ E_ARMOUR ]);
		SetPlayerHealth( playerid, g_duelData[ targetid ][ E_HEALTH ]);
		SetPlayerVirtualWorld( playerid, targetid + 1 );
		SetPlayerPos( playerid, g_duelLocationData[ iLocation ][ E_POS_ONE ][0], g_duelLocationData[ iLocation ][ E_POS_ONE ][1], g_duelLocationData[ iLocation ][ E_POS_ONE ][2] );
		SetPlayerFacingAngle(playerid, g_duelLocationData[ iLocation ][ E_POS_ONE ][3]);
		SetCameraBehindPlayer(playerid);
		// freeze
		TogglePlayerControllable( playerid, 0 );
		TogglePlayerControllable( targetid, 0 );

		// start countdown
		g_duelData[ targetid ][ E_COUNTDOWN ] = 4;
		g_duelData[ targetid ][ E_TIMER ] = SetTimerEx( "OnDuelTimer", 960, true, "d", targetid );

		// give weapon
		GivePlayerWeapon( playerid, g_duelData[ targetid ][ E_WEAPON ][0], 5000);
		GivePlayerWeapon( targetid, g_duelData[ targetid ][ E_WEAPON ][0], 5000);
		GivePlayerWeapon( playerid, g_duelData[ targetid ][ E_WEAPON ][1], 5000);
		GivePlayerWeapon( targetid, g_duelData[ targetid ][ E_WEAPON ][1], 5000);
		va_SendClientMessageToAll(0x42F598FF, "[Duel] A Duel has started between {FFFFFF}%s{42F598} and{FFFFFF} %s{42F598}.", GetName(playerid), GetName(targetid));
		// clear invites for safety
		for (new i = 0; i < MAX_PLAYERS; i ++) {
			p_duelInvitation[ playerid ][ i ] = 0;
			p_duelInvitation[ targetid ][ i ] = 0;
		}
		return 1;
	}
	else if ( strmatch( params, "cancel" ) )
	{
		if ( ClearDuelInvites( playerid ) )
		{
			return va_SendClientMessage(playerid, 0x42F598FF, "Â» Duel: {FFFFFF}You have cancelled every duel offer that you have made.");
		}
		else
		{
			return va_SendClientMessage(playerid, 0xFF6347AA, "Â» You have not made any duel offers recently.");
		}
	}
	else if ( strmatch( params, "menu" ) ) {
		return ShowPlayerDuelMenu(playerid);
	}
	return SendClientMessage(playerid, 0x797979AA, "Usage: {FFFFFF} /duel [accept/cancel/menu].");
}

/* ** Functions ** */
static stock ClearDuelInvites( playerid )
{
	new current_time = gettime( );
	new count = 0;

	for ( new i = 0; i < MAX_PLAYERS; i ++ )
	{
		if ( p_duelInvitation[ playerid ][ i ] != 0 && current_time > p_duelInvitation[ playerid ][ i ])
		{
			p_duelInvitation[ playerid ][ i ] = 0;
			count ++;
		}
	}
	return count;
}

stock IsPlayerDueling( playerid ) {
	return p_playerDueling{ playerid };
}

stock ShowPlayerDuelMenu( playerid )
{

	format( szBigString, sizeof(szBigString),
		"Opponent\t"COL_GREY"%s\nHealth\t"COL_RED"%.2f%%\nArmour\t"COL_RED"%.2f%%\nPrimary Weapon\t"COL_RED"%s\nSecondary Weapon\t"COL_RED"%s\nLocation\t"COL_RED"%s\n"COL_DUEL"Reset duel settings\n"COL_DUEL"Send duel\t"COL_DUEL">>>",
		( ! IsPlayerConnected( g_duelData[ playerid ][ E_PLAYER ] ) ? ( ""COL_RED"None" ) : ( GetName( g_duelData[ playerid ][ E_PLAYER ] ) ) ),
		g_duelData[ playerid ][ E_HEALTH ],
		g_duelData[ playerid ][ E_ARMOUR ],
		ReturnWeaponName( g_duelData[ playerid ][ E_WEAPON ][ 0 ] ),
		ReturnWeaponName( g_duelData[ playerid ][ E_WEAPON ][ 1 ] ),
		g_duelLocationData[ g_duelData[ playerid ][ E_LOCATION_ID ] ][ E_NAME ]
	);

	ShowPlayerDialog( playerid, DIALOG_DUEL, DIALOG_STYLE_TABLIST, ""COL_DUEL"Duel Settings", szBigString, "Select", "Cancel" );
	return 1;
}
stock forfeitPlayerDuel(playerid)
{
	if ( !IsPlayerDueling( playerid ) )
		return 0;

	ClearDuelInvites( playerid );

	new
		winnerid = g_duelData[ playerid ][ E_PLAYER ];

	if ( ! IsPlayerConnected( winnerid ) || ! IsPlayerDueling( winnerid ) )
		return 0;

	//SpawnPlayer( winnerid );
	SetPlayerSpawnAfterDuel(winnerid);
	SetPlayerSpawnAfterDuel(playerid);
	ClearDuelInvites( winnerid );

	va_SendClientMessageToAll(0x42F598FF, "[Duel] %s {FFFFFF}has won the duel against {42F598}%s.", GetName(winnerid), GetName(playerid));
	return 1;
}

function OnDuelTimer( targetid )
{
	new
		playerid = g_duelData[ targetid ][ E_PLAYER ];

	g_duelData[ targetid ][ E_COUNTDOWN ] --;

	if ( g_duelData[ targetid ][ E_COUNTDOWN ] <= 0)
	{
		GameTextForPlayer( targetid, "~g~~h~FIGHT!", 1500, 4 );
		GameTextForPlayer( playerid, "~g~~h~FIGHT!", 1500, 4 );

		PlayerPlaySound( targetid, 1057, 0.0, 0.0, 0.0 );
		PlayerPlaySound( playerid, 1057, 0.0, 0.0, 0.0 );

		TogglePlayerControllable( playerid, 1 );
		TogglePlayerControllable( targetid, 1 );

		KillTimer( g_duelData[ targetid ][ E_TIMER ] );
	}
	else
	{
		format( szSmallString, sizeof( szSmallString ), "~w~%d", g_duelData[ targetid ][ E_COUNTDOWN ] );
		GameTextForPlayer( targetid, szSmallString, 1500, 4 );
		GameTextForPlayer( playerid, szSmallString, 1500, 4 );

		PlayerPlaySound( targetid, 1056, 0.0, 0.0, 0.0 );
		PlayerPlaySound( playerid, 1056, 0.0, 0.0, 0.0 );
	}
	return 1;
}