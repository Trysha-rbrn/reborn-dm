#include <YSI_Coding\y_hooks>


hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
        case DIALOG_DM:
        {
            check[!response] return true;
            check[response]
            {
                switch(listitem)
                {
                    case 0:
                    {
                        check[InDM1 -eq 10 and PI[playerid][pPremium] -ne 1]
                        then
                            check[PI[playerid][pLang] -eq 1] 
                                return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You can't join that arena because it's already full.");

                            else if(PI[playerid][pLang] -eq 2) 
                                SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}Ne mozete uci u arenu jer je puna.");   
                        fi
                        SetPlayerVirtualWorld(playerid, LVPD_VW);
                        SetPlayerInterior(playerid, 3);
                        SetPlayerPos(playerid, 288.745971,169.350997,1007.171875);
                        GivePlayerWeapon(playerid, 24, 200);
                        SetPlayerHealth(playerid, 99.0);
                        SetPlayerArmour(playerid, 99.0);
                        InDM[playerid] = 1;
                        check [PI[playerid][pLang] -eq 1]
                            InfoMessage(playerid, "You have entered DM arena. (LVPD)");
                        else if (PI[playerid][pLang] -eq 2)
                            InfoMessage(playerid, "Usli ste u DM arenu. (LVPD)");
                        SetCbugAllowed(false);
                        InDM1 ++;
                        foreach(new i : Player)
                        {
                            if(InDM[i] -eq 1)
                            {
                                va_SendClientMessage(i, 0x0070D0FF, "[DM]:{FFFFFF} %s has joined LVPD.", GetName(playerid));
                            }
                        }   
                    }
                    case 1:
                    {
                        check[InDM2 -eq 10 and PI[playerid][pPremium] -ne 1] 
                        then
                            if(PI[playerid][pLang] -eq 1) 
                                return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You can't join that arena because it's already full.");

                            else if(PI[playerid][pLang] -eq 2) 
                                SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}Ne mozete uci u arenu jer je puna.");   
                        fi
                        new rand = random(sizeof(GTOWN));
                        SetPlayerVirtualWorld(playerid, GTOWN_VW);
                        SetPlayerInterior(playerid, 0);
                        SetPlayerPos(playerid, GTOWN[rand][0], GTOWN[rand][1], GTOWN[rand][2]);
                        GivePlayerWeapon(playerid, 24, 200);
                        GivePlayerWeapon(playerid, 25, 150);
                        GivePlayerWeapon(playerid, 33,50);
                        SetPlayerHealth(playerid, 99.0);
                        SetPlayerArmour(playerid, 99.0);
                        InDM[playerid] = 2;
                        check [PI[playerid][pLang] -eq 1]
                            InfoMessage(playerid, "You have entered DM arena. (Ghost Town)");
                        else if (PI[playerid][pLang] -eq 2)
                            InfoMessage(playerid, "Usli ste u DM arenu. (Ghost Town)");
                        SetCbugAllowed(false);
                        InDM2 ++;
                        foreach(new i : Player)
                        {
                            if(InDM[i] -eq 2)
                            {
                                va_SendClientMessage(i, 0x0070D0FF, "[DM]:{FFFFFF} %s has joined Ghost Town.", GetName(playerid));
                            }
                        }   
                    }
                    case 2:
                    {
                        check[InDM3 -eq 10 and PI[playerid][pPremium] -ne 1] 
                        then
                            if(PI[playerid][pLang] -eq 1) 
                                return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You can't join that arena because it's already full.");

                            else if(PI[playerid][pLang] -eq 2) 
                                SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}Ne mozete uci u arenu jer je puna.");   
                        fi
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
                        InDM[playerid] = 3;
                        check [PI[playerid][pLang] -eq 1]
                            InfoMessage(playerid, "You have entered DM arena. (RC Battlefield)");
                        else if (PI[playerid][pLang] -eq 2)
                            InfoMessage(playerid, "Usli ste u DM arenu. (RC Battlefield)");
                        SetCbugAllowed(false);
                        InDM3 ++;
                        foreach(new i : Player)
                        {
                            if(InDM[i] -eq 3)
                            {
                                va_SendClientMessage(i, 0x0070D0FF, "[DM]:{FFFFFF} %s has joined RC Battlefield.", GetName(playerid));
                            }
                        }   
                    }
                    case 3:
                    {
                        if(InDM4 -eq 10 and PI[playerid][pPremium] -ne 1) 
                        {
                            if(PI[playerid][pLang] -eq 1) 
                                return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You can't join that arena because it's already full.");

                            else if(PI[playerid][pLang] -eq 2) 
                                SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}Ne mozete uci u arenu jer je puna.");   
                        }
                        new rand = random(sizeof(LVPD2));
                        SetPlayerVirtualWorld(playerid, LVPD2_VW);
                        SetPlayerInterior(playerid, 3);
                        SetPlayerPos(playerid, LVPD2[rand][0], LVPD2[rand][1], LVPD2[rand][2]);
                        GivePlayerWeapon(playerid, 24, 200);
                        GivePlayerWeapon(playerid, 25, 150);
                        SetPlayerHealth(playerid, 99.0);
                        SetPlayerArmour(playerid, 99.0);
                        InDM[playerid] = 4;
                        check [PI[playerid][pLang] -eq 1]
                            InfoMessage(playerid, "You have entered DM arena. (LVPD 2)");
                        else if (PI[playerid][pLang] -eq 2)
                            InfoMessage(playerid, "Usli ste u DM arenu. (LVPD 2)");
                        SetCbugAllowed(false);
                        InDM4 ++;
                        foreach(new i : Player)
                        {
                            if(InDM[i] -eq 4)
                            {
                                va_SendClientMessage(i, 0x0070D0FF, "[DM]:{FFFFFF} %s has joined LVPD 2.", GetName(playerid));
                            }
                        }   
                    }
                    case 4:
                    {
                        if(InDM5 -eq 10 and PI[playerid][pPremium] -ne 1) 
                        {
                            if(PI[playerid][pLang] -eq 1) 
                                return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You can't join that arena because it's already full.");

                            else if(PI[playerid][pLang] -eq 2) 
                                SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}Ne mozete uci u arenu jer je puna.");   
                        }
                        new rand = random(sizeof(GHOST2));
                        SetPlayerVirtualWorld(playerid, GHOST2_VW);
                        SetPlayerInterior(playerid, 0);
                        SetPlayerPos(playerid, GHOST2[rand][0], GHOST2[rand][1], GHOST2[rand][2]);
                        GivePlayerWeapon(playerid, 24, 200);
                        GivePlayerWeapon(playerid, 25, 150);
                        SetPlayerHealth(playerid, 99.0);
                        SetPlayerArmour(playerid, 99.0);
                        InDM[playerid] = 5;
                        check [PI[playerid][pLang] -eq 1]
                            InfoMessage(playerid, "You have entered DM arena. (Ghost Town 2)");
                        else if (PI[playerid][pLang] -eq 2)
                            InfoMessage(playerid, "Usli ste u DM arenu. (Ghost Town 2)");
                        SetCbugAllowed(false);
                        InDM5 ++;
                        foreach(new i : Player)
                        {
                            if(InDM[i] -eq 5)
                            {
                                va_SendClientMessage(i, 0x0070D0FF, "[DM]:{FFFFFF} %s has joined Ghost Town 2.", GetName(playerid));
                            }
                        }  
                    }
                    case 5:
                    {
                        if(InDM6 -eq 10 and PI[playerid][pPremium] -ne 1) 
                        {
                            if(PI[playerid][pLang] -eq 1) 
                                return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You can't join that arena because it's already full.");

                            else if(PI[playerid][pLang] -eq 2) 
                                SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}Ne mozete uci u arenu jer je puna.");   
                        }
                        new rand = random(sizeof(WHOUSE));
                        SetPlayerVirtualWorld(playerid, WHOUSE_VW);
                        SetPlayerInterior(playerid, 1);
                        SetPlayerPos(playerid, WHOUSE[rand][0], WHOUSE[rand][1], WHOUSE[rand][2]);
                        GivePlayerWeapon(playerid, 24, 200);
                        SetPlayerHealth(playerid, 99.0);
                        SetPlayerArmour(playerid, 99.0);
                        InDM[playerid] = 6;
                        check [PI[playerid][pLang] -eq 1]
                            InfoMessage(playerid, "You have entered DM arena. (Warehouse 1)");
                        else if (PI[playerid][pLang] -eq 2)
                            InfoMessage(playerid, "Usli ste u DM arenu. (Warehouse 1)");
                        SetCbugAllowed(true);
                        InDM6 ++;
                        foreach(new i : Player)
                        {
                            if(InDM[i] -eq 6)
                            {
                                va_SendClientMessage(i, 0x0070D0FF, "[DM]:{FFFFFF} %s has joined Warehouse 1.", GetName(playerid));
                            }
                        }  
                    }
                    case 6:
                    {
                        if(InDM7 -eq 10 and PI[playerid][pPremium] -ne 1) 
                        {
                            if(PI[playerid][pLang] -eq 1) 
                                return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You can't join that arena because it's already full.");

                            else if(PI[playerid][pLang] -eq 2) 
                                SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}Ne mozete uci u arenu jer je puna.");   
                        }
                        new rand = random(sizeof(SoarArena));
                        SetPlayerVirtualWorld(playerid, WHOUSE_VW);
                        SetPlayerInterior(playerid, 1);
                        SetPlayerPos(playerid, SoarArena[rand][0], SoarArena[rand][1], SoarArena[rand][2]);
                        GivePlayerWeapon(playerid, 24, 200);
                        SetPlayerHealth(playerid, 99.0);
                        SetPlayerArmour(playerid, 99.0);
                        InDM[playerid] = 7;
                        check [PI[playerid][pLang] -eq 1]
                            InfoMessage(playerid, "You have entered  DM arena. (Soar Arena)");
                        else if (PI[playerid][pLang] -eq 2)
                            InfoMessage(playerid, "Usli ste u DM arenu. (Soar Arena)");
                        SetCbugAllowed(false);
                        InDM7 ++;
                        foreach(new i : Player)
                        {
                            if(InDM[i] -eq 7)
                            {
                                va_SendClientMessage(i, 0x0070D0FF, "[DM]:{FFFFFF} %s has joined Soar Arena.", GetName(playerid));
                            }
                        }  
                    }
                }
            }
        }
		case dialog_CHOOSELANG:
		{
			if (!response)
				return 1;

			switch(listitem)
			{
				case 0:
				{
					check [PI[playerid][pLang] -eq 1]
						return SendClientMessage(playerid, COLOR_RED2, "ERROR » {FFFFFF}You already chosen English language!");
					
					SendClientMessage(playerid, 0x0070D0FF, "Language: {FFFFFF}You chosen English language..");
					PI[playerid][pLang] = 1;
				}
				case 1:
				{
					if (PI[playerid][pLang] -eq 2)
						return SendClientMessage(playerid, COLOR_RED2, "ERROR » {FFFFFF}Vec ste odabrali srpski jezik!");

					SendClientMessage(playerid, 0x0070D0FF, "Jezik: {FFFFFF}Odabrali ste srpski jezik..");
					PI[playerid][pLang] = 2;
				}
			}
            sql_user_update_integer(playerid, "Lang", PI[playerid][pLang]);
		}
		case DIALOG_HELP:
		{
		    check[!response] return true;
		    check[response]
			{
				switch(listitem)
				{
				    case 0:
					{
				        new pcmd[350];
				        strcat(pcmd, ""COLOR_RED"Arena CMDS: "COLOR_WHITE"/dm (Command to enter arena) /lobby (Command to exit the arena)\n", sizeof(pcmd));
				        strcat(pcmd, ""COLOR_RED"Duel CMDS: "COLOR_WHITE"/duel (Command to send duel to other players) /ad /dd (Command for accepting or rejecting duels)\n", sizeof(pcmd));
				        strcat(pcmd, ""COLOR_RED"Other CMDS: "COLOR_WHITE"/pm /r /id /fps /skin /changepassword /report /stats /toghud /lang /pl /color", sizeof(pcmd));
				        ShowPlayerDialog(playerid, 19999, DIALOG_STYLE_MSGBOX, ""COLOR_RED"Information - Commands", pcmd, "Close", "");
                    }
                    case 1:
                    {
                        new rules[270];
                        
                        check [PI[playerid][pLang] -eq 1]
                        {
                            strcat(rules, ""COLOR_RED"Rule 1 - "COLOR_WHITE"No cheating, use of modifications that affects gameplay of other players.\n", sizeof(rules));
                            strcat(rules, ""COLOR_RED"Rule 2 - "COLOR_WHITE"No teaming.\n", sizeof(rules));
                            strcat(rules, ""COLOR_RED"Rule 3 - "COLOR_WHITE"No swearing.\n\n", sizeof(rules));
                            strcat(rules, ""COLOR_RED"NOTE: "COLOR_WHITE"If you break any of the server rules, you will be punished.", sizeof(rules));
                        }
                        else if (PI[playerid][pLang] -eq 2)
                        {
                            strcat(rules, ""COLOR_RED"Pravilo 1 - "COLOR_WHITE"Nema citovanja, upotreba modova koji uticu na igranje ostalih igrača.\n", sizeof(rules));
                            strcat(rules, ""COLOR_RED"Pravilo 2 - "COLOR_WHITE"Nema timovanja.\n", sizeof(rules));
                            strcat(rules, ""COLOR_RED"Pravilo 3 - "COLOR_WHITE"Nema psovanja.\n\n", sizeof(rules));
                            strcat(rules, ""COLOR_RED"OPOMENA: "COLOR_WHITE"Ako prekršite neko od ovih pravila, bićete kažnjeni.", sizeof(rules));
                        }
                        ShowPlayerDialog(playerid, 19999, DIALOG_STYLE_MSGBOX, ""COLOR_RED"Information - Rules", rules, "Close", "");
                    }
                    case 2:
                    {
                        if(PI[playerid][pAdmin] -eq 0) return SendClientMessage(playerid, 0xFF6347AA, "ERROR » {FFFFFF}You are not authorised.");

                        new acmd[399];

                        strcat(acmd, ""COLOR_RED"Admin Commands\n\n");
                        strcat(acmd, ""COLOR_WHITE"A-Chat: /a <text> | /admins /screenshare /spec /specoff /unfreeze /spawn /cc\n\n");
                        strcat(acmd, ""COLOR_WHITE"/mute /unmute /jail /unjail /kick /alias /ban /altchat\n\n");

                        if(PI[playerid][pAdmin] >= 2)
                        {
                            strcat(acmd, ""COLOR_RED"General Admin Commands\n\n");
                            strcat(acmd, ""COLOR_WHITE"/checkip /baninfo /offban\n\n");
                        }
                        if(PI[playerid][pAdmin] >= 3)
                        {
							strcat(acmd, ""COLOR_RED"Senior Admin Commands\n\n");
                            strcat(acmd, ""COLOR_WHITE"/unban /unbanip\n\n");
                        }
                        if(PI[playerid][pAdmin] -eq 4)
                        {
                            strcat(acmd, ""COLOR_RED"Owner Commands\n\n");
                            strcat(acmd, ""COLOR_WHITE"/makeadmin /makepremium /hostname /premiums /resetaltchat\n\n");
                        }
                        ShowPlayerDialog(playerid, 19999, DIALOG_STYLE_MSGBOX, ""COLOR_RED"Admin - Commands", acmd, "Close", "");
                    }
                }
            }
        }
        case DIALOG_NCOLOR: 
        {
        	check[!response] return 1;
        	switch(listitem) 
        	{
        		case 0:
        		{
        			SetPlayerColor(playerid, COLOR_SERVER2);
        		}
        		case 1:
        		{
        			SetPlayerColor(playerid, 0x15FF00AA);
        		}
        		case 2:
        		{
        			SetPlayerColor(playerid, 0xD900FFAA);
        		}
        		case 3:
        		{
        			SetPlayerColor(playerid, 0x000000AA);
        		}
        		case 4:
        		{
        			SetPlayerColor(playerid, 0xFFF700AA);
        		}
        		case 5:
        		{
        			SetPlayerColor(playerid, 0x02A604AA);
        		}
        		case 6:
        		{
        			SetPlayerColor(playerid, 0xFF00C3AA);
        		} 
        		case 7:
        		{
        			SetPlayerColor(playerid, 0xFF8400AA);
        		}  
        		case 8:
        		{
        			SetPlayerColor(playerid, 0xFFFFFFAA);
        		}  
        		case 9:
        		{
        			SetPlayerColor(playerid, 0x33A398AA);
        		}          		        		        		       		        		        		        		        		
        	}
            PI[playerid][pColor] = listitem;
            sql_user_update_integer(playerid, "Color", PI[playerid][pColor]);
            check [PI[playerid][pLang] -eq 1]
                InfoMessage(playerid, "You have successfully changed color of your name.");
            else if (PI[playerid][pLang] -eq 2)
                InfoMessage(playerid, "Uspesno ste promenili boju vaseg imena.");
        }
		case DIALOG_REPORT: {
		    check[!response] return 1;
		    switch(listitem) {
		    	case 0: {
		            new string[ 200+MAX_PLAYER_NAME ];
		            ReportReason[ playerid ] = 1;
					format(string, sizeof(string), ""COLOR_RED"[REPORT] %s "COLOR_WHITE"has submited a report at "COLOR_RED"%s"COLOR_WHITE"[%d] with a reason of: "COLOR_RED"Hacking", GetName(playerid), GetName(ReportedID[ playerid ]), ReportedID[ playerid ]);
					AMessage(-1, string);
					check [PI[playerid][pLang] -eq 1]
                       InfoMessage(playerid, "Your report has been successfully submited.");
                    else if (PI[playerid][pLang] -eq 2)
                       InfoMessage(playerid, "Vasa prijava je uspesno poslata.");
					ReportedID[ playerid ] = -1;
				}
				case 1: {
				    new string[ 200+MAX_PLAYER_NAME ];
				    ReportReason[ playerid ] = 2;
					format(string, sizeof(string), ""COLOR_RED"[REPORT] %s "COLOR_WHITE"has submited a report at "COLOR_RED"%s"COLOR_WHITE"[%d] with a reason of: "COLOR_RED"Breaking The Rules", GetName(playerid), GetName(ReportedID[ playerid ]), ReportedID[ playerid ]);
					AMessage(-1, string);
					check [PI[playerid][pLang] -eq 1]
                       InfoMessage(playerid, "Your report has been successfully submited.");
                    else if (PI[playerid][pLang] -eq 2)
                       InfoMessage(playerid, "Vasa prijava je uspesno poslata.");
					ReportedID[ playerid ] = -1;
				}
				case 2: {
    				new string[ 200+MAX_PLAYER_NAME ];
    				ReportReason[ playerid ] = 3;
					format(string, sizeof(string), ""COLOR_RED"[REPORT] %s "COLOR_WHITE"has submited a report at "COLOR_RED"%s"COLOR_WHITE"[%d] with a reason of: "COLOR_RED"Spam", GetName(playerid), GetName(ReportedID[ playerid ]), ReportedID[ playerid ]);
					AMessage(-1, string);
                    check [PI[playerid][pLang] -eq 1]
                       InfoMessage(playerid, "Your report has been successfully submited.");
                    else if (PI[playerid][pLang] -eq 2)
                       InfoMessage(playerid, "Vasa prijava je uspesno poslata.");
					ReportedID[ playerid ] = -1;
		        }
		    }
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}
