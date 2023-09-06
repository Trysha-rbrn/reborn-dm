//#include <YSI_Coding\y_hooks>

cmd:admins(playerid) 
{
    check[PI[playerid][pAdmin] -lt 1] return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}You are not authorised.");
    mysql_tquery(SQL, "SELECT `Username`, `Admin`, `DutyTime` FROM `users` WHERE `Admin` > 0 ORDER BY `Admin` DESC", "Admini", "d", playerid);
    return true;
}

public Admini(playerid)
{
    if(playerid != INVALID_PLAYER_ID)
    {
        new aname[MAX_PLAYER_NAME + 1], alevel = 0, Float:aduty = 0.0, s_Staff[3500], s_String[256];
        if(cache_num_rows() > 0)
        {
            format(s_String, sizeof(s_String), "RANK\tNICK\tDUTY\tDUTY TIME\n");
            strcat(s_Staff, s_String);
            for(new i = 0, r = cache_num_rows(); i < r; i ++)
            {
                cache_get_value_name(i, "Username", aname, MAX_PLAYER_NAME + 1);
                cache_get_value_int(i, "Admin", alevel);
                cache_get_value_float(i, "DutyTime", aduty);

                if(!IsPlayerConnected(GetPlayerIdFromName(aname)))
                {
                    format(s_String, sizeof(s_String), "%s\t%s\tOff\t%.1f h\n", GetAdminRank(alevel), aname, aduty);
                    strcat(s_Staff, s_String);
                }
                else
                {
                    if(AdminDuty[GetPlayerIdFromName(aname)] == true)
                    {
                        format(s_String, sizeof(s_String), "%s\t%s\tOn\t%.1f h\n", GetAdminRank(alevel), aname, aduty);
                        strcat(s_Staff, s_String);
                    }
                    else
                    {
                        format(s_String, sizeof(s_String), "%s\t%s\tOff\t%.1f h\n", GetAdminRank(alevel), aname, aduty);
                        strcat(s_Staff, s_String);
                    }
                }
            }
            ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_TABLIST_HEADERS, "Admin List", s_Staff, "X", "");
        }
        else return SendClientMessage(playerid, 0xFF6347AA, "Error: {FFFFFF}Admin list is empty.");
    }
    return 1;
}