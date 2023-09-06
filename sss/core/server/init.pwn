public OnGameModeInit()
{
	SQL = mysql_connect(MYSQL_HOST, MYSQL_USER,  MYSQL_PASS, MYSQL_DBNAME);
	mysql_log(ALL);
	new err = mysql_errno(SQL);
	if(!err) 
	{
		printf("Success: MySQL connection (%s,%s,%s)!",MYSQL_HOST, MYSQL_USER, MYSQL_DBNAME);
	} 
	else 
	{
        print("Error: Invalid MySQL connection!");
		SendRconCommand("exit");
		return true;
	}	
	/* SERVER SETUP */
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
 	SendRconCommand("rcon_password 1312");
	//SendRconCommand("password rdm20240101");
	SetGameModeText("reborndm: Version "GAMEMODE_VERSION"");
	SendRconCommand("weburl www.reborn-dm.eu");
	SendRconCommand("language Ex-Yu / English");
	CreateGTextdraws();
	skinList = LoadModelSelectionMenu("skins.txt");
	//
	//CreateDynamic3DTextLabel("Press `N` to open skin list", 0x0070D0FF, 2063.1174,1302.6636,-18.2761, SPAWN_VW);
	//
    //DMActor = CreateDynamicActor(80, 2067.0098, 1308.2684, -17.3161, 56.5586, 0, 100.0, SPAWN_VW, 0);
    //CreateDynamic3DTextLabel("Shoot me for the list of Arenas", 0x0070D0FF, 2067.0098,1308.2684,-17.3161, SPAWN_VW);
    //
    //HelpActor = CreateDynamicActor(80, 2059.7908, 1308.2472, -17.3161, 320.1138, 0, 100.0, SPAWN_VW, 0);

    //CreateDynamic3DTextLabel("Shoot me for help", 0x0070D0FF, 2059.7908,1308.2472,-17.3161, SPAWN_VW);

	//CreateDynamic3DTextLabel("Press 'F/Enter' to enter the jail", 0x0070D0FF, 786.4310,2566.1306,1388.3312, SPAWN_VW);
	//CreateDynamic3DTextLabel("Press 'F/Enter' to exit the jail", 0x0070D0FF, 195.2212,1388.9219,551.2960, JAILED_VW);

    OwnerActor[0] =CreateDynamicActor(177, 792.2017, 2569.0315, 1389.4153, 48.1358, 0, 100.0, SPAWN_VW, 0); // trifun
    SetDynamicActorInvulnerable(OwnerActor[0], true);
    OwnerActor[1] = CreateDynamicActor(271, 792.3008, 2585.5193, 1389.4153, 131.2794, 0, 100.0, SPAWN_VW, 0); // emrahone
    SetDynamicActorInvulnerable(OwnerActor[1], true);
    OwnerActor[2] = CreateDynamicActor(299, 778.8434,2585.3340,1389.4153,224.2320, 0, 100.0, SPAWN_VW, 0); // celic
    SetDynamicActorInvulnerable(OwnerActor[2], true);
    OwnerActor[3] = CreateDynamicActor(132, 778.7200,2569.1646,1389.4153,318.4522, 0, 100.0, SPAWN_VW, 0); // zile42O
    SetDynamicActorInvulnerable(OwnerActor[3], true);
	CreateDynamic3DTextLabel("{1C77DE}Server developer\n{FFFFFF}Trifun", -1, 792.2017, 2569.0315, 1389.4153, 150.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
	CreateDynamic3DTextLabel("{1C77DE}Server founder\n{FFFFFF}Emrahone", -1, 792.3008, 2585.5193, 1389.4153, 150.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
	CreateDynamic3DTextLabel("{1C77DE}Server owner\n{FFFFFF}Celic", -1,778.8434,2585.3340,1389.4153, 150.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
	CreateDynamic3DTextLabel("{1C77DE}Web Developer\n{FFFFFF}.3fun", -1, 778.7200,2569.1646,1389.4153, 150.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
    SetVehiclePassengerDamage(true);
    SetDisableSyncBugs(true);
   	return true;
}