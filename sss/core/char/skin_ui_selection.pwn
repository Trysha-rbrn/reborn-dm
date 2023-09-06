public OnPlayerModelSelection(playerid, response, listid, modelid) {
	check[listid -eq skinList]
	then
		if(response) 
		{
			PI[playerid][pSkin] = modelid;
			SetPlayerSkin(playerid, PI[playerid][pSkin]);
			
			breaker PI[playerid][pLang] of		
				_case 1)
				va_SendClientMessage(playerid, 0x0070D0FF, "R:DM - {FFFFFF} You successfully bought skin ID: %d.", modelid);
			_case 2)
				va_SendClientMessage(playerid, 0x0070D0FF, "R:DM - {FFFFFF} Uspesno ste kupili skin ID: %d.", modelid);
			esac

			SaveAccount(playerid);
		}
	fi
	return 1;
}