CreatePTextdraws(playerid)
{
	// sporedni GUI
	GUI[playerid][0] = CreatePlayerTextDraw(playerid,553.000000, 101.000000, "_");
	PlayerTextDrawFont(playerid,GUI[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][0], 0.516665, 1.000002);
	PlayerTextDrawTextSize(playerid,GUI[playerid][0], 345.500000, 107.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][0], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][0], 2);
	PlayerTextDrawColor(playerid,GUI[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][0], 111);
	PlayerTextDrawUseBox(playerid,GUI[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][0], 0);

	GUI[playerid][1] = CreatePlayerTextDraw(playerid,584.000000, 296.000000, "_");
	PlayerTextDrawFont(playerid,GUI[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][1], 0.600000, 6.400002);
	PlayerTextDrawTextSize(playerid,GUI[playerid][1], 298.500000, 100.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][1], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][1], 2);
	PlayerTextDrawColor(playerid,GUI[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][1], 105);
	PlayerTextDrawUseBox(playerid,GUI[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][1], 0);

	GUI[playerid][2] = CreatePlayerTextDraw(playerid,603.000000, 301.000000, "_");
	PlayerTextDrawFont(playerid,GUI[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][2], 0.600000, 0.800002);
	PlayerTextDrawTextSize(playerid,GUI[playerid][2], 303.500000, 55.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][2], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][2], 2);
	PlayerTextDrawColor(playerid,GUI[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][2], 135);
	PlayerTextDrawUseBox(playerid,GUI[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][2], 0);

	GUI[playerid][3] = CreatePlayerTextDraw(playerid,603.000000, 314.000000, "_");
	PlayerTextDrawFont(playerid,GUI[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][3], 0.600000, 0.800002);
	PlayerTextDrawTextSize(playerid,GUI[playerid][3], 303.500000, 55.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][3], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][3], 2);
	PlayerTextDrawColor(playerid,GUI[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][3], 135);
	PlayerTextDrawUseBox(playerid,GUI[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][3], 0);

	GUI[playerid][4] = CreatePlayerTextDraw(playerid,603.000000, 328.000000, "_");
	PlayerTextDrawFont(playerid,GUI[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][4], 0.600000, 0.800002);
	PlayerTextDrawTextSize(playerid,GUI[playerid][4], 303.500000, 55.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][4], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][4], 2);
	PlayerTextDrawColor(playerid,GUI[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][4], 135);
	PlayerTextDrawUseBox(playerid,GUI[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][4], 0);

	GUI[playerid][5] = CreatePlayerTextDraw(playerid,603.000000, 342.000000, "_");
	PlayerTextDrawFont(playerid,GUI[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][5], 0.600000, 0.800002);
	PlayerTextDrawTextSize(playerid,GUI[playerid][5], 303.500000, 55.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][5], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][5], 2);
	PlayerTextDrawColor(playerid,GUI[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][5], 135);
	PlayerTextDrawUseBox(playerid,GUI[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][5], 0);

	GUI[playerid][6] = CreatePlayerTextDraw(playerid,542.000000, 343.000000, "Preview_Model");
	PlayerTextDrawFont(playerid,GUI[playerid][6], 5);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid,GUI[playerid][6], 100.000000, 123.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][6], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][6], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][6], 255);
	PlayerTextDrawUseBox(playerid,GUI[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid,GUI[playerid][6], 18863);
	PlayerTextDrawSetPreviewRot(playerid,GUI[playerid][6], -7.000000, 0.000000, -40.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid,GUI[playerid][6], 1, 1);

	GUI[playerid][7] = CreatePlayerTextDraw(playerid,542.000000, 343.000000, "Preview_Model");
	PlayerTextDrawFont(playerid,GUI[playerid][7], 5);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid,GUI[playerid][7], 100.000000, 123.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][7], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][7], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][7], 255);
	PlayerTextDrawUseBox(playerid,GUI[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][7], 0);
	PlayerTextDrawSetPreviewModel(playerid,GUI[playerid][7], 18863);
	PlayerTextDrawSetPreviewRot(playerid,GUI[playerid][7], -7.000000, 0.000000, -40.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid,GUI[playerid][7], 1, 1);

	GUI[playerid][8] = CreatePlayerTextDraw(playerid,552.000000, 326.000000, "Preview_Model");
	PlayerTextDrawFont(playerid,GUI[playerid][8], 5);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid,GUI[playerid][8], 100.000000, 123.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][8], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][8], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][8], 0);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][8], 255);
	PlayerTextDrawUseBox(playerid,GUI[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][8], 0);
	PlayerTextDrawSetPreviewModel(playerid,GUI[playerid][8], 18863);
	PlayerTextDrawSetPreviewRot(playerid,GUI[playerid][8], -7.000000, 0.000000, -40.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid,GUI[playerid][8], 1, 1);

	GUI[playerid][9] = CreatePlayerTextDraw(playerid,552.000000, 326.000000, "Preview_Model");
	PlayerTextDrawFont(playerid,GUI[playerid][9], 5);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid,GUI[playerid][9], 100.000000, 123.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][9], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][9], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][9], 0);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][9], 255);
	PlayerTextDrawUseBox(playerid,GUI[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][9], 0);
	PlayerTextDrawSetPreviewModel(playerid,GUI[playerid][9], 18863);
	PlayerTextDrawSetPreviewRot(playerid,GUI[playerid][9], -7.000000, 0.000000, -40.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid,GUI[playerid][9], 1, 1);

	GUI[playerid][10] = CreatePlayerTextDraw(playerid,568.000000, 341.000000, "Preview_Model");
	PlayerTextDrawFont(playerid,GUI[playerid][10], 5);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid,GUI[playerid][10], 92.500000, 120.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][10], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][10], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][10], 0);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][10], 255);
	PlayerTextDrawUseBox(playerid,GUI[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][10], 0);
	PlayerTextDrawSetPreviewModel(playerid,GUI[playerid][10], 19076);
	PlayerTextDrawSetPreviewRot(playerid,GUI[playerid][10], -5.000000, 0.000000, -26.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid,GUI[playerid][10], 1, 1);

	GUI[playerid][11] = CreatePlayerTextDraw(playerid,593.000000, 426.000000, "Preview_Model");
	PlayerTextDrawFont(playerid,GUI[playerid][11], 5);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid,GUI[playerid][11], 17.500000, 20.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][11], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][11], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][11], 1090519040);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][11], 255);
	PlayerTextDrawUseBox(playerid,GUI[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][11], 0);
	PlayerTextDrawSetPreviewModel(playerid,GUI[playerid][11], 19054);
	PlayerTextDrawSetPreviewRot(playerid,GUI[playerid][11], -10.000000, 0.000000, -44.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid,GUI[playerid][11], 1, 1);

	GUI[playerid][12] = CreatePlayerTextDraw(playerid,531.000000, 356.000000, "LD_spac:white");
	PlayerTextDrawFont(playerid,GUI[playerid][12], 4);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid,GUI[playerid][12], 104.500000, -1.500000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][12], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][12], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][12], 255);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][12], 50);
	PlayerTextDrawUseBox(playerid,GUI[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][12], 0);

	GUI[playerid][13] = CreatePlayerTextDraw(playerid,538.000000, 293.000000, "SESSION");
	PlayerTextDrawFont(playerid,GUI[playerid][13], 2);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][13], 0.129166, 1.099998);
	PlayerTextDrawTextSize(playerid,GUI[playerid][13], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][13], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][13], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][13], 1097458175);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][13], 50);
	PlayerTextDrawUseBox(playerid,GUI[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][13], 0);

	GUI[playerid][14] = CreatePlayerTextDraw(playerid,576.000000, 300.000000, "KILLS");
	PlayerTextDrawFont(playerid,GUI[playerid][14], 2);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][14], 0.125000, 0.899999);
	PlayerTextDrawTextSize(playerid,GUI[playerid][14], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][14], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][14], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][14], 50);
	PlayerTextDrawUseBox(playerid,GUI[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][14], 0);

	GUI[playerid][15] = CreatePlayerTextDraw(playerid,576.000000, 313.000000, "DEATHS");
	PlayerTextDrawFont(playerid,GUI[playerid][15], 2);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][15], 0.125000, 0.899999);
	PlayerTextDrawTextSize(playerid,GUI[playerid][15], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][15], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][15], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][15], 50);
	PlayerTextDrawUseBox(playerid,GUI[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][15], 0);

	GUI[playerid][16] = CreatePlayerTextDraw(playerid,576.000000, 327.000000, "RATIO");
	PlayerTextDrawFont(playerid,GUI[playerid][16], 2);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][16], 0.125000, 0.899999);
	PlayerTextDrawTextSize(playerid,GUI[playerid][16], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][16], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][16], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][16], 50);
	PlayerTextDrawUseBox(playerid,GUI[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][16], 0);

	GUI[playerid][17] = CreatePlayerTextDraw(playerid,576.000000, 341.000000, "STREAK");
	PlayerTextDrawFont(playerid,GUI[playerid][17], 2);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][17], 0.125000, 0.899999);
	PlayerTextDrawTextSize(playerid,GUI[playerid][17], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][17], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][17], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][17], 50);
	PlayerTextDrawUseBox(playerid,GUI[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][17], 0);

	GUI[playerid][18] = CreatePlayerTextDraw(playerid,11.000000, 422.000000, "19:55:26");
	PlayerTextDrawFont(playerid,GUI[playerid][18], 3);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][18], 0.245832, 0.899999);
	PlayerTextDrawTextSize(playerid,GUI[playerid][18], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][18], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][18], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][18], 1097458175);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][18], 50);
	PlayerTextDrawUseBox(playerid,GUI[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][18], 0);

	GUI[playerid][19] = CreatePlayerTextDraw(playerid,16.000000, 431.000000, "20/01/2019");
	PlayerTextDrawFont(playerid,GUI[playerid][19], 3);
	PlayerTextDrawLetterSize(playerid,GUI[playerid][19], 0.254166, 0.949999);
	PlayerTextDrawTextSize(playerid,GUI[playerid][19], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid,GUI[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid,GUI[playerid][19], 0);
	PlayerTextDrawAlignment(playerid,GUI[playerid][19], 1);
	PlayerTextDrawColor(playerid,GUI[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid,GUI[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid,GUI[playerid][19], 50);
	PlayerTextDrawUseBox(playerid,GUI[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid,GUI[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid,GUI[playerid][19], 0);

	GUI[playerid][20] = CreatePlayerTextDraw(playerid, 530.000000, 100.000000, "FPS:~w~ 99");
	PlayerTextDrawFont(playerid, GUI[playerid][20], 2);
	PlayerTextDrawLetterSize(playerid, GUI[playerid][20], 0.166666, 1.100000);
	PlayerTextDrawTextSize(playerid, GUI[playerid][20], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, GUI[playerid][20], 0);
	PlayerTextDrawSetShadow(playerid, GUI[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, GUI[playerid][20], 3);
	PlayerTextDrawColor(playerid, GUI[playerid][20], 1097458175);
	PlayerTextDrawBackgroundColor(playerid, GUI[playerid][20], 255);
	PlayerTextDrawBoxColor(playerid, GUI[playerid][20], 50);
	PlayerTextDrawUseBox(playerid, GUI[playerid][20], 0);
	PlayerTextDrawSetProportional(playerid, GUI[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, GUI[playerid][20], 0);

	GUI[playerid][21] = CreatePlayerTextDraw(playerid, 597.000000, 100.000000, "PING: ~w~53");
	PlayerTextDrawFont(playerid, GUI[playerid][21], 2);
	PlayerTextDrawLetterSize(playerid, GUI[playerid][21], 0.166666, 1.100000);
	PlayerTextDrawTextSize(playerid, GUI[playerid][21], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, GUI[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, GUI[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, GUI[playerid][21], 3);
	PlayerTextDrawColor(playerid, GUI[playerid][21], 1097458175);
	PlayerTextDrawBackgroundColor(playerid, GUI[playerid][21], 255);
	PlayerTextDrawBoxColor(playerid, GUI[playerid][21], 50);
	PlayerTextDrawUseBox(playerid, GUI[playerid][21], 0);
	PlayerTextDrawSetProportional(playerid, GUI[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, GUI[playerid][21], 0);

	GUI[playerid][22] = CreatePlayerTextDraw(playerid, 521.000000, 306.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, GUI[playerid][22], 5);
	PlayerTextDrawLetterSize(playerid, GUI[playerid][22], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GUI[playerid][22], 62.500000, 45.000000);
	PlayerTextDrawSetOutline(playerid, GUI[playerid][22], 0);
	PlayerTextDrawSetShadow(playerid, GUI[playerid][22], 0);
	PlayerTextDrawAlignment(playerid, GUI[playerid][22], 1);
	PlayerTextDrawColor(playerid, GUI[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, GUI[playerid][22], 0);
	PlayerTextDrawBoxColor(playerid, GUI[playerid][22], 255);
	PlayerTextDrawUseBox(playerid, GUI[playerid][22], 0);
	PlayerTextDrawSetProportional(playerid, GUI[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, GUI[playerid][22], 0);
	PlayerTextDrawSetPreviewModel(playerid, GUI[playerid][22], 249);
	PlayerTextDrawSetPreviewRot(playerid, GUI[playerid][22], -10.000000, 0.000000, -3.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, GUI[playerid][22], 1, 1);

	GUI[playerid][23] = CreatePlayerTextDraw(playerid, 625.000000, 299.000000, "0");
	PlayerTextDrawFont(playerid, GUI[playerid][23], 2);
	PlayerTextDrawLetterSize(playerid, GUI[playerid][23], 0.166666, 1.099998);
	PlayerTextDrawTextSize(playerid, GUI[playerid][23], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, GUI[playerid][23], 0);
	PlayerTextDrawSetShadow(playerid, GUI[playerid][23], 0);
	PlayerTextDrawAlignment(playerid, GUI[playerid][23], 1);
	PlayerTextDrawColor(playerid, GUI[playerid][23], 1097458175);
	PlayerTextDrawBackgroundColor(playerid, GUI[playerid][23], 255);
	PlayerTextDrawBoxColor(playerid, GUI[playerid][23], 50);
	PlayerTextDrawUseBox(playerid, GUI[playerid][23], 0);
	PlayerTextDrawSetProportional(playerid, GUI[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, GUI[playerid][23], 0);

	GUI[playerid][24] = CreatePlayerTextDraw(playerid, 625.000000, 312.000000, "0");
	PlayerTextDrawFont(playerid, GUI[playerid][24], 2);
	PlayerTextDrawLetterSize(playerid, GUI[playerid][24], 0.166666, 1.099998);
	PlayerTextDrawTextSize(playerid, GUI[playerid][24], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, GUI[playerid][24], 0);
	PlayerTextDrawSetShadow(playerid, GUI[playerid][24], 0);
	PlayerTextDrawAlignment(playerid, GUI[playerid][24], 1);
	PlayerTextDrawColor(playerid, GUI[playerid][24], 1097458175);
	PlayerTextDrawBackgroundColor(playerid, GUI[playerid][24], 255);
	PlayerTextDrawBoxColor(playerid, GUI[playerid][24], 50);
	PlayerTextDrawUseBox(playerid, GUI[playerid][24], 0);
	PlayerTextDrawSetProportional(playerid, GUI[playerid][24], 1);
	PlayerTextDrawSetSelectable(playerid, GUI[playerid][24], 0);

	GUI[playerid][25] = CreatePlayerTextDraw(playerid, 615.000000, 326.000000, "0.00");
	PlayerTextDrawFont(playerid, GUI[playerid][25], 2);
	PlayerTextDrawLetterSize(playerid, GUI[playerid][25], 0.166666, 1.099998);
	PlayerTextDrawTextSize(playerid, GUI[playerid][25], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, GUI[playerid][25], 0);
	PlayerTextDrawSetShadow(playerid, GUI[playerid][25], 0);
	PlayerTextDrawAlignment(playerid, GUI[playerid][25], 1);
	PlayerTextDrawColor(playerid, GUI[playerid][25], 1097458175);
	PlayerTextDrawBackgroundColor(playerid, GUI[playerid][25], 255);
	PlayerTextDrawBoxColor(playerid, GUI[playerid][25], 50);
	PlayerTextDrawUseBox(playerid, GUI[playerid][25], 0);
	PlayerTextDrawSetProportional(playerid, GUI[playerid][25], 1);
	PlayerTextDrawSetSelectable(playerid, GUI[playerid][25], 0);

	GUI[playerid][26] = CreatePlayerTextDraw(playerid, 625.000000, 340.000000, "0");
	PlayerTextDrawFont(playerid, GUI[playerid][26], 2);
	PlayerTextDrawLetterSize(playerid, GUI[playerid][26], 0.166666, 1.099998);
	PlayerTextDrawTextSize(playerid, GUI[playerid][26], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, GUI[playerid][26], 0);
	PlayerTextDrawSetShadow(playerid, GUI[playerid][26], 0);
	PlayerTextDrawAlignment(playerid, GUI[playerid][26], 1);
	PlayerTextDrawColor(playerid, GUI[playerid][26], 1097458175);
	PlayerTextDrawBackgroundColor(playerid, GUI[playerid][26], 255);
	PlayerTextDrawBoxColor(playerid, GUI[playerid][26], 50);
	PlayerTextDrawUseBox(playerid, GUI[playerid][26], 0);
	PlayerTextDrawSetProportional(playerid, GUI[playerid][26], 1);
	PlayerTextDrawSetSelectable(playerid, GUI[playerid][26], 0);
	//


	DTD[playerid] = CreatePlayerTextDraw(playerid, 326.133361, 192.903564, "respawning_in_4...");
	PlayerTextDrawLetterSize(playerid, DTD[playerid], 0.498999, 2.180740);
	PlayerTextDrawAlignment(playerid, DTD[playerid], 2);
	PlayerTextDrawColor(playerid, DTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, DTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DTD[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, DTD[playerid], 255);
	PlayerTextDrawFont(playerid, DTD[playerid], 3);
	PlayerTextDrawSetProportional(playerid, DTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DTD[playerid], 0);
	
	//
	
	new Float: AltChat_posY = 229.573348;

    for(new i = 0; i < MAX_LINES; i ++)
	{
        AltChatTD_Player[i] = CreatePlayerTextDraw(playerid, 35.599971, AltChat_posY, "RDM");
        PlayerTextDrawLetterSize(playerid, AltChatTD_Player[i], 0.21, 0.9);
        PlayerTextDrawAlignment(playerid, AltChatTD_Player[i], 1);
        PlayerTextDrawColor(playerid, AltChatTD_Player[i], -1);
        PlayerTextDrawSetOutline(playerid, AltChatTD_Player[i], 1);
        PlayerTextDrawBackgroundColor(playerid, AltChatTD_Player[i], 255);
        PlayerTextDrawFont(playerid, AltChatTD_Player[i], 1);
        PlayerTextDrawSetProportional(playerid, AltChatTD_Player[i], 1);

        AltChat_posY += (240.026733 - 229.573348);
    }
}
CreateGTextdraws()
{
	HitMark[0] = TextDrawCreate(339.000000, 172.000000, "x");
	TextDrawLetterSize(HitMark[0], 0.360666, 1.023407);
	TextDrawAlignment(HitMark[0], 1);
	TextDrawColor(HitMark[0], -16776961);
	TextDrawSetShadow(HitMark[0], 1);
	TextDrawSetOutline(HitMark[0], 0);
	TextDrawBackgroundColor(HitMark[0], 255);
	TextDrawFont(HitMark[0], 1);
	TextDrawSetProportional(HitMark[0], 1);
	TextDrawSetShadow(HitMark[0], 1); 
}

// Setup textdraws
stock TextdrawSetup(playerid)
{
	new string[50], year,month,day,Float:ratio=floatdiv(PI[playerid][pUbistva], PI[playerid][pSmrti]);
	getdate( year, month, day );

	format(string, sizeof string, "FPS:~w~_%d", pFPS[playerid]);
	PlayerTextDrawSetString(playerid, GUI[playerid][20], string);
	format(string, sizeof string, "PING:~w~_%d", GetPlayerPing(playerid));
	PlayerTextDrawSetString(playerid, GUI[playerid][21], string);
	format(string, sizeof string, "%d", PI[playerid][pUbistva]);
	PlayerTextDrawSetString(playerid, GUI[playerid][23], string);
	format(string, sizeof string, "%d", PI[playerid][pSmrti]);
	PlayerTextDrawSetString(playerid, GUI[playerid][24], string);
	format(string, sizeof string, "%.2f", ratio);
	PlayerTextDrawSetString(playerid, GUI[playerid][25], string);
	format(string, sizeof string, "%d", Killstreak[playerid]);
	PlayerTextDrawSetString(playerid, GUI[playerid][26], string);
	format(string, sizeof string, "%02d/%02d/%d", day,month,year);
	PlayerTextDrawSetString(playerid, GUI[playerid][19], string);

	loop i in {0 .. 27} 
	do
		PlayerTextDrawShow(playerid, GUI[playerid][i]);
	done
	return (true);
}
