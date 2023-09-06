#include <YSI_Coding\y_hooks>

new
    bool:InTDM[MAX_PLAYERS char],
    TDM_Members[4],
    TDM_GangID[MAX_PLAYERS char],
    // Gang skins
    GrooveSkins[] = {105, 106, 107};

#define dialog_ENTERINTDM 18

// Commands
COMMAND:tdm(playerid, const params[])
{
    // if (InTDM[playerid])
    // {
    //     breaker PI[playerid][pLang] of
    //         _case 1)
    //             return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You're already in TDM, (/lobby)!");
    //         _case 2)
    //             return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Vec ste u TDM-u, (/lobby)!");
    //     esac
    // }

    new
        string[244];

    format(string, sizeof(string), "\
        {4ceb34}Groove\t\t{f7e30a}%d Members\n\
        {4ceb34}Ballas\t\t{f7e30a}%d Members\n\
        {4ceb34}Hobos\t\t{f7e30a}%d Members\n\
        {4ceb34}Locotes\t{f7e30a}%d Members",
        TDM_Members[0], TDM_Members[1], TDM_Members[2], TDM_Members[3]
    );
    ShowPlayerDialog(playerid, dialog_ENTERINTDM, DIALOG_STYLE_LIST,
        "Select A Team",
        string,
        "Select", "Cancel"
    );
    return 1;
}

// Dialog
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    check[dialogid -eq dialog_ENTERINTDM]
    then
        check[!response]
            return 1;

        check[response]
        then
            breaker listitem of
                _case 0)
                    check[TDM_GangID[playerid] -eq 1]
                    then
                        breaker PI[playerid][pLang] of
                            _case 1)
                                return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You're already in Groove Street!");
                            _case 2)
                                return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Vec ste u Groove Street-u!");
                        esac
                    fi
                    new
                        rand = random(sizeof(GrooveSkins));

                    SetPlayerPos(playerid, 2304.4272,-1649.5432,14.5653);
                    SetPlayerFacingAngle(playerid, 178.6283);
                    SetPlayerSkin(playerid, GrooveSkins[rand]);
                    InTDM[playerid] = true;
                    TDM_Members[0] ++;
                    TDM_GangID[playerid] = 1;
            esac
        fi
    fi
    return Y_HOOKS_CONTINUE_RETURN_1;
}