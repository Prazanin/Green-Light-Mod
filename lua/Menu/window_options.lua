-----------------------------------------------------------------------------
---  Orig. File : /lua/menu/window_options.lua
---  Version    : 3
---
---  Summary    : Options
---
---  Created    : Stuart 'Stucuk' Carey, OW Support
---               Petr 'Sali' Salak, Freya Group
------------------------------------------------------------------------------
OW_loadgameoptions();

options = {
	type=TYPE_ELEMENT,
	parent=menu,
	anchor={top=false,bottom=false,left=false,right=false},
	visible=false,
	x=menu.side.width+30,
	y=130,
	width=LayoutWidth-menu.side.width-30-30,
	height=LayoutHeight-200,
}

options = getWindowEX(menu,anchorNone,XYWH(menu.side.width+30,130,LayoutWidth-menu.side.width-30-30,LayoutHeight-200),false,loc(561),
          	      WINDOW_BACKGROUND_GL,
                      ({
                	title_colour=BLACK(255),
                        title_border_colour=BLACK(255),
                        colour1=BLACKA(0),
                        border_type=BORDER_TYPE_OUTER,
                        border_colour=GREENA(70),
                        border_size=1,
                        title_font_name=Neuropol
                      }));

soundoptionsy = 50;

solabel = AddElement({
		type=TYPE_LABEL,
		parent=options,
		anchor={top=true,bottom=false,left=true,right=true},
		x=15,
		y=soundoptionsy,
		width=options.width-15,
		text=loc(TID_Main_Menu_Options_Sound_Options),
		font_colour=WHITE(),
		colour1=BLACKA(0),
		text_halign=ALIGN_LEFT,
		text_case=CASE_TITLE,
                font_name=Tahoma_13B,
                shadowtext=true,
	});

function addOptionsSlider(X,Y,MIN,MAX,POS,HINT,CAPTION,CALLBACK)
        local s = {
		type=TYPE_LABEL,
		parent=options,
                anchor=anchorLT,
		x=X,
		y=Y,
		width=150,
		height=16,
		text=CAPTION,
		font_colour=WHITE(),
		colour1=BLACKA(0),
		font_name=Tahoma_13,
	}
	AddElement(s);

        return addAlienSlider(options, anchorLTR, XYWH(X+150,Y,380,16), MIN, MAX, POS, HINT, CALLBACK);
end;

musicvolume   = addOptionsSlider(20,soundoptionsy+20  ,0,5000,OW_settings_getvolume(VOLUME_MUSIC)  ,'',loc(547),'setting_setvolume(VOLUME_MUSIC,musicvolume.POS);');
soundvolume   = addOptionsSlider(20,soundoptionsy+20*2,0,5000,OW_settings_getvolume(VOLUME_SPEECH) ,'',loc(548),'setting_setvolume(VOLUME_SPEECH,soundvolume.POS);');
effectsvolume = addOptionsSlider(20,soundoptionsy+20*3,0,5000,OW_settings_getvolume(VOLUME_EFFECTS),'',loc(549),'setting_setvolume(VOLUME_EFFECTS,effectsvolume.POS);');

ublabel = AddElement({
		type=TYPE_LABEL,
		parent=options,
		anchor={top=true,bottom=false,left=true,right=true},
		x=15,
		y=effectsvolume.y+effectsvolume.height+20,
		width=options.width,
		text=loc(569),--'Unit Behaviour',
		font_colour={red=255,green=255,blue=255,alpha=255},
		colour1={red=0,green=0,blue=0,alpha=0},
		text_halign=ALIGN_LEFT,
		text_case=CASE_TITLE,
		--visible=false,
                font_name=Tahoma_13B,
                shadowtext=true,
	});

AddElement({
		type=TYPE_LABEL,
		parent=options,
		anchor={top=true,bottom=false,left=true,right=true},
		x=20,
		y=ublabel.y+20,
		text=loc(570),
		font_colour={red=255,green=255,blue=255,alpha=255},
		colour1={red=0,green=0,blue=0,alpha=0},
		text_halign=ALIGN_LEFT,
		autosize=true,
		font_name=Tahoma_13,
	});

rawound     = getCheckBoxEX_MENU(options,anchorLT,XYWH(28,ublabel.y+20*2,20,20),loc(574),checkbox_merge,'setting_set(SETTING_RAWOUNDED,%value);',{checked=true,});
ranoncombat = getCheckBoxEX_MENU(options,anchorLT,XYWH(28,rawound.y+22,20,20),loc(571),checkbox_merge,'setting_set(SETTING_RANONCOMBAT,%value);',{checked=true,});
ravehicles  = getCheckBoxEX_MENU(options,anchorLT,XYWH(28,rawound.y+22*2,20,20),loc(577),checkbox_merge,'setting_set(SETTING_RAVEHICLES,%value);',{checked=true,});

otherSettings = 285;

misclabel = AddElement({
		type=TYPE_LABEL,
		parent=options,
		anchor=anchorLT,
		x=15,
		y=otherSettings-20,
		width=options.width-15,
		text=loc(TID_Main_Menu_Options_Misc),--loc(569),--'Unit Behaviour',
		font_colour=WHITE(),
		colour1=BLACKA(0),
		text_halign=ALIGN_LEFT,
		text_case=CASE_TITLE,
                font_name=Tahoma_13B,
                shadowtext=true,
	});

showobjectives = getCheckBoxEX_MENU(options,anchorLT,XYWH(28,otherSettings,20,20),loc(563),checkbox_merge,'setting_set(SETTING_AUTOMISSION,%value);',{checked=true,});
subtitles      = getCheckBoxEX_MENU(options,anchorLT,XYWH(28,showobjectives.y+22,20,20),loc(550),checkbox_merge,'setting_set(SETTING_SUBTITLES,%value);',{checked=true,});

debriefSettings = 350;
debrieflabel = AddElement({
		type=TYPE_LABEL,
		parent=options,
		anchor=anchorLT,
		x=15,
		y=debriefSettings,
		width=options.width-15,
		text=loc(TID_Main_Menu_Options_Debrief),
		font_colour=WHITE(),
		colour1=BLACKA(0),
		text_halign=ALIGN_LEFT,
		text_case=CASE_TITLE,
                font_name=Tahoma_13B,
                shadowtext=true,
	});

transFill = addOptionsSlider(28,debrieflabel.y+20,0,25,0,loc(TID_Main_Menu_Options_Transparency_Fill_Hint),loc(TID_Main_Menu_Options_Transparency_Fill),'setGraph(transFill.POS);');

oldgraph      = getCheckBoxEX_MENU(options,anchorLT,XYWH(28,transFill.y+22,20,20),loc(TID_Main_Menu_Options_Old_Type_Graph),checkbox_merge,"OW_SETTING_WRITE('DEBRIEF', 'OLD_GRAPH_TYPE', %value); loadGraph(OW_SETTING_READ_NUMBER('DEBRIEF', 'TRANS_FILL', 15));",{checked=false,});


testGraph =  AddElement({
				type=TYPE_ELEMENT,
				parent=options,
				anchor=anchorLT,
				visible=true,
				x=transFill.x+transFill.width+20,
				y=transFill.y-5,
				width=100,
				height=100,--transFill.height+10,
				colour1=BLACKA(255),
                                bevel=true,
                                bevel_colour1=GRAY(10),
                                bevel_colour2=GRAY(40),
			});

testGraph[1] =  AddElement({
				type=TYPE_ELEMENT,
				parent=testGraph,
				anchor=anchorLT,
				visible=true,
				x=0,
				y=0,
				width=testGraph.width,
				height=testGraph.height,
				colour1=WHITEA(255),
			});

testGraph[2] =  AddElement({
				type=TYPE_ELEMENT,
				parent=testGraph,
				anchor=anchorLT,
				visible=true,
				x=0,
				y=0,
				width=testGraph.width,
				height=testGraph.height,
				colour1=WHITEA(255),
			});

testGraph[3] =  AddElement({
				type=TYPE_ELEMENT,
				parent=testGraph,
				anchor=anchorLT,
				visible=true,
				x=0,
				y=0,
				width=testGraph.width,
				height=testGraph.height,
				colour1=WHITEA(255),
			});

testGraph.tex = {};
testGraph.tex[1] = CTAPI_newTexture(testGraph[1].width,testGraph[1].height);
testGraph.tex[2] = CTAPI_newTexture(testGraph[2].width,testGraph[2].height);
testGraph.tex[3] = CTAPI_newTexture(testGraph[3].width,testGraph[3].height);
CTAPI_setElementTexture(testGraph.tex[1] ,testGraph[1]);
CTAPI_setElementTexture(testGraph.tex[2] ,testGraph[2]);
CTAPI_setElementTexture(testGraph.tex[3] ,testGraph[3]);



options_loading = false;

function options_show()
	options_loading = true;
    --set_Property(gamespeed.ID,PROP_PROGRESS,OW_get(SETTING_SPEED));
	set_Property(subtitles.ID,PROP_CHECKED,OW_get(SETTING_SUBTITLES));
	set_Property(showobjectives.ID,PROP_CHECKED,OW_get(SETTING_AUTOMISSION));
	set_Property(rawound.ID,PROP_CHECKED,OW_get(SETTING_RAWOUNDED));
	set_Property(ranoncombat.ID,PROP_CHECKED,OW_get(SETTING_RANONCOMBAT));
	set_Property(ravehicles.ID,PROP_CHECKED,OW_get(SETTING_RAVEHICLES));
	loadGraph(OW_SETTING_READ_NUMBER('DEBRIEF', 'TRANS_FILL', 15));
	set_Property(oldgraph.ID,PROP_CHECKED,OW_SETTING_READ_BOOLEAN('DEBRIEF', 'OLD_GRAPH_TYPE', false));
	setVisible(options,true);

--	set_Property(musicvolume.ID,PROP_PROGRESS,OW_settings_getvolume(VOLUME_MUSIC));

        slider_SETPOS(musicvolume,OW_settings_getvolume(VOLUME_MUSIC));
        slider_SETPOS(soundvolume,OW_settings_getvolume(VOLUME_SPEECH));
        slider_SETPOS(effectsvolume,OW_settings_getvolume(VOLUME_EFFECTS));

	--set_Property(effectsvolume.ID,PROP_PROGRESS,OW_settings_getvolume(VOLUME_EFFECTS));
	--set_Property(soundvolume.ID,PROP_PROGRESS,OW_settings_getvolume(VOLUME_SPEECH));

	options_loading = false;
end;

SETTING_TIMER_ID = 0;

function setting_set(setting,value)
	if (options_loading == false) then
		OW_set(setting,value);
		SETTING_TIMER_ID = AddRepeatableTimer(2,'OW_settings_save();',SETTING_TIMER_ID);
	end;
end;

function setting_setvolume(setting,value)
	if (options_loading == false) then
		OW_settings_setvolume(setting,value);
                SETTING_TIMER_ID = AddRepeatableTimer(2,'OW_settings_save();',SETTING_TIMER_ID);
	end;
end;

function loadGraph(trans)
--	set_Property(transFill.ID,PROP_PROGRESS,trans);
	slider_SETPOS(transFill,trans);

	local h = testGraph.height-10;
	CTAPI_drawBox(testGraph.tex[1],0,0,testGraph.width,testGraph.height,WHITEA(0));
	CTAPI_drawBox(testGraph.tex[2],0,0,testGraph.width,testGraph.height,WHITEA(0));
	CTAPI_drawBox(testGraph.tex[3],0,0,testGraph.width,testGraph.height,WHITEA(0));
	if OW_SETTING_READ_BOOLEAN('DEBRIEF', 'OLD_GRAPH_TYPE', false) then
		local c = SIDE_COLOURS[2];


		CTAPI_drawBox(testGraph.tex[1],0,0,testGraph.width,h/2+3,RGBA(c.red, c.green, c.blue, trans));
		CTAPI_drawBox(testGraph.tex[1],0,h/2+3-1,testGraph.width,1,c);


		local c = SIDE_COLOURS[3];

		CTAPI_drawBox(testGraph.tex[2],0,0,testGraph.width/2,h,RGBA(c.red, c.green, c.blue, trans));
		CTAPI_drawBox(testGraph.tex[2],0,h-1,testGraph.width/2,1,c);
		CTAPI_drawBox(testGraph.tex[2],testGraph.width/2,0,testGraph.width/2,h/3,RGBA(c.red, c.green, c.blue, trans));
		CTAPI_drawBox(testGraph.tex[2],testGraph.width/2,h/3-1,1,h-h/3,c);
		CTAPI_drawBox(testGraph.tex[2],testGraph.width/2,h/3-1,testGraph.width/2,1,c);

		local c = SIDE_COLOURS[4];
			h=h-10;
		CTAPI_drawBox(testGraph.tex[3],0,0,testGraph.width,h,RGBA(c.red, c.green, c.blue, trans));
		CTAPI_drawBox(testGraph.tex[3],0,h-1,testGraph.width,1,c);
			h=h+10;

	else
		local c = SIDE_COLOURS[2];


		CTAPI_drawBox(testGraph.tex[1],0,0,testGraph.width,h/2+3,RGBA(c.red, c.green, c.blue, trans));
		CTAPI_drawBox(testGraph.tex[1],0,h/2+3-2,testGraph.width,2,c);

		local c = SIDE_COLOURS[3];

			CTAPI_drawBox(testGraph.tex[2],0,0,testGraph.width/2,h,RGBA(c.red, c.green, c.blue, trans));
			CTAPI_drawBox(testGraph.tex[2],0,h-2,testGraph.width/2,2,c);

			local Y1 = h-2;
			local Y2 = h/3;
			if not (Y1 <= 0 and Y2 <= 0) then
				repeat
					CTAPI_drawLine(testGraph.tex[2], testGraph.width/2,Y1,testGraph.width,Y2,RGBA(c.red, c.green, c.blue, trans));
						if Y1 > 0 then
							Y1 = Y1-1;
						end;
						if Y2 > 0 then
							Y2 = Y2-1;
						end;
					until( Y1 <= 0 and Y2 <= 0 )
				end;
			CTAPI_drawLine(testGraph.tex[2], testGraph.width/2,h-2,testGraph.width,h/3,c);
			CTAPI_drawLine(testGraph.tex[2], testGraph.width/2,h-3,testGraph.width,h/3-1,c);

		local c = SIDE_COLOURS[4];
			h=h-10;
		CTAPI_drawBox(testGraph.tex[3],0,0,testGraph.width,h,RGBA(c.red, c.green, c.blue, trans));
		CTAPI_drawBox(testGraph.tex[3],0,h-2,testGraph.width,2,c);
	end;
	CTAPI_updateTexture(testGraph.tex[1]);
	CTAPI_updateTexture(testGraph.tex[2]);
	CTAPI_updateTexture(testGraph.tex[3]);

	CTAPI_setElementTexture(testGraph.tex[1] ,testGraph[1]);
	CTAPI_setElementTexture(testGraph.tex[2] ,testGraph[2]);
	CTAPI_setElementTexture(testGraph.tex[3] ,testGraph[3]);
end;

function setGraph(trans)
	loadGraph(trans);

	OW_SETTING_WRITE('DEBRIEF', 'TRANS_FILL', trans);
end;


changeShortcuts = getImageButtonEX(
	options,
	anchorLT,
	XYWH(
		20,
		subtitles.y+28, --transFill.y+35,
		300,
		35
	),
	loc(TID_Options_Button_ChangeKeybinds),
	'',
	'OpenShortcutsWindow();',
	SKINTYPE_BUTTON,
	{
		--text='Change Shortcuts',
		font_colour_disabled=GRAY(127),
		visible=false,
	}
);



--addOptionsSlider(20,subtitles.y+28,0,25,0,loc(TID_Main_Menu_Options_Transparency_Fill_Hint),loc(TID_Main_Menu_Options_Transparency_Fill),'setGraph(transFill.POS);');

function OpenShortcutsWindow()

	createListOfShortcuts();
	setVisible(shortcutsClone,true);
end;

shortcutsClone = getElementEX(
	menu,
	anchorLTRB,
	XYWH(
		0,
		0,
		ScrWidth,
		ScrHeight
	),
	false,
	{
		colour1=BLACKA(150),
	}
);


shortcutsWindow = getWindowEX(
	shortcutsClone,
	anchorNone,
	XYWH(
		menu.side.width,
		100,
		LayoutWidth-menu.side.width,
		LayoutHeight-150
	),
	true,
	loc(TID_Options_Window_ChangeKeybinds),
	WINDOW_BACKGROUND,
	{
	}
);

shortcutsWindow.Save = makeGradButton({
	parent=shortcutsWindow,
	anchor=anchorLT,
	x=shortcutsWindow.width-200,
	y=shortcutsWindow.height-40,
	width=180,
	height=30,
	text=loc(TID_InGame_File_menu_Save_And_Exit),
	font_name=Tahoma_12B ,
	text_case=CASE_UPPER,
	--disabled=true,
	callback_mouseclick='saveShortcuts();',
},GradButton_Green);

shortcutsWindow.Cancel = makeGradButton({
	parent=shortcutsWindow,
	anchor=anchorLT,
	x=shortcutsWindow.width-2*200,
	y=shortcutsWindow.height-40,
	width=180,
	height=30,
	text=loc(TID_InGame_Chat_Cancel),
	font_name=Tahoma_12B ,
	text_case=CASE_UPPER,
	--disabled=true,
	callback_mouseclick='setVisible(shortcutsClone,false);',
},GradButton_Red);

shortcutsWindow.GridZ = makeGradButton({
	parent=shortcutsWindow,
	anchor=anchorLT,
	x=shortcutsWindow.width-200,
	y=35,
	width=175,--Multi_Room.GameParameters.width-10,
	height=30,
	text=loc(TID_Options_Keybinds_GridZ),
	font_name=Tahoma_12B ,
	text_case=CASE_UPPER,
	--disabled=true,
	callback_mouseclick='changeKeysByDatabase(1);',
	font_colour=RGB(220,220,220),
},GradButton_BlueStu);

shortcutsWindow.GridY = makeGradButton({
	parent=shortcutsWindow,
	anchor=anchorLT,
	x=shortcutsWindow.width-2*200,
	y=35,
	width=175,--Multi_Room.GameParameters.width-10,
	height=30,
	text=loc(TID_Options_Keybinds_GridY),
	font_name=Tahoma_12B ,
	text_case=CASE_UPPER,
	--disabled=true,
	callback_mouseclick='changeKeysByDatabase(2);',
	font_colour=RGB(220,220,220),
},GradButton_BlueStu);

shortcutsWindow.Restore = makeGradButton({
	parent=shortcutsWindow,
	anchor=anchorLT,
	x=shortcutsWindow.width-3*200,
	y=35,
	width=175,--Multi_Room.GameParameters.width-10,
	height=30,
	text=loc(TID_Options_Keybinds_Restore),
	font_name=Tahoma_12B ,
	text_case=CASE_UPPER,
	--disabled=true,
	callback_mouseclick='restoreKeys();',
	font_colour=RGB(220,220,220),
},GradButton_BlueStu);

shortcutsWindow.ListBoxCommands = AddElement({
	type=TYPE_SCROLLBOX,
	parent=shortcutsWindow,
	anchor=anchorLT,
	x=10,
	y=100,
	width=shortcutsWindow.width-20-15,
	height=shortcutsWindow.height-70-70,
	colour1 = GRAY(20),
});

setBorder(shortcutsWindow.ListBoxCommands,BORDER_TYPE_INNER,1,RGBA(0,0,0,255) );

shortcutsWindow.ListBoxCommands_scrollV = AddElement({
	type=TYPE_SCROLLBAR,
	parent=shortcutsWindow,
	anchor={top=true,bottom=true,left=false,right=true},
	x=shortcutsWindow.ListBoxCommands.x+shortcutsWindow.ListBoxCommands.width+3,
	y=shortcutsWindow.ListBoxCommands.y,
	width=15,
	height=shortcutsWindow.ListBoxCommands.height,
	colour1=Scrollbar_Colour1,
	colour2=Scrollbar_Colour2,
	texture2="scrollbar.png",
});


sgui_set(shortcutsWindow.ListBoxCommands.ID,PROP_SCROLLBAR,shortcutsWindow.ListBoxCommands_scrollV.ID);

shortcutsWindow.ListBoxBuild = AddElement({
	type=TYPE_SCROLLBOX,
	parent=shortcutsWindow,
	anchor=anchorLT,
	x=10,
	y=100,
	width=shortcutsWindow.width-20-15,
	height=shortcutsWindow.height-70-70,
	colour1 = GRAY(20),
});

setBorder(shortcutsWindow.ListBoxBuild,BORDER_TYPE_INNER,1,RGBA(0,0,0,255) );

shortcutsWindow.ListBoxBuild_scrollV = AddElement({
	type=TYPE_SCROLLBAR,
	parent=shortcutsWindow,
	anchor={top=true,bottom=true,left=false,right=true},
	x=shortcutsWindow.ListBoxBuild.x+shortcutsWindow.ListBoxBuild.width+3,
	y=shortcutsWindow.ListBoxBuild.y,
	width=15,
	height=shortcutsWindow.ListBoxBuild.height,
	colour1=Scrollbar_Colour1,
	colour2=Scrollbar_Colour2,
	texture2="scrollbar.png",
});


sgui_set(shortcutsWindow.ListBoxBuild.ID,PROP_SCROLLBAR,shortcutsWindow.ListBoxBuild_scrollV.ID);

shortcutsWindow.ListBoxResearch = AddElement({
	type=TYPE_SCROLLBOX,
	parent=shortcutsWindow,
	anchor=anchorLT,
	x=10,
	y=100,
	width=shortcutsWindow.width-20-15,
	height=shortcutsWindow.height-70-70,
	colour1 = GRAY(20),
});

setBorder(shortcutsWindow.ListBoxResearch,BORDER_TYPE_INNER,1,RGBA(0,0,0,255) );

shortcutsWindow.ListBoxResearch_scrollV = AddElement({
	type=TYPE_SCROLLBAR,
	parent=shortcutsWindow,
	anchor={top=true,bottom=true,left=false,right=true},
	x=shortcutsWindow.ListBoxResearch.x+shortcutsWindow.ListBoxResearch.width+3,
	y=shortcutsWindow.ListBoxResearch.y,
	width=15,
	height=shortcutsWindow.ListBoxResearch.height,
	colour1=Scrollbar_Colour1,
	colour2=Scrollbar_Colour2,
	texture2="scrollbar.png",
});


sgui_set(shortcutsWindow.ListBoxResearch.ID,PROP_SCROLLBAR,shortcutsWindow.ListBoxResearch_scrollV.ID);



shortcutsWindow.Commands = getElementEX(
						shortcutsWindow,
						anchorRT,
						XYWH(
							2,
							68,
							(shortcutsWindow.width-8)/3,
							30
						),
						true,
						{
							colour1=RGBA(70,70,70,255),
						--	callback_mouseclick='',
							bevel=true,
						}
				);

shortcutsWindow.Commands.Label = getLabelEX(
							shortcutsWindow.Commands,
							anchorRT,
							XYWH(
								0,
								0,
								shortcutsWindow.Commands.width,
								shortcutsWindow.Commands.height
							),
							true,
							loc(TID_Options_Keybinds_Comm),
							{
								font_name = Tahoma_12B,
								font_style_outline=true,
								text_halign=ALIGN_MIDDLE,
								callback_mouseclick='changeShortcutList(1);',
								highlight=true,
							}
					);

shortcutsWindow.Build = getElementEX(
						shortcutsWindow,
						anchorRT,
						XYWH(
							4+(shortcutsWindow.width-8)/3,
							68,
							(shortcutsWindow.width-8)/3,
							30
						),
						true,
						{
							colour1=RGBA(70,70,70,255),
						--	callback_mouseclick='',
							bevel=true,
						}
				);

shortcutsWindow.Build.Label = getLabelEX(
							shortcutsWindow.Build,
							anchorRT,
							XYWH(
								0,
								0,
								shortcutsWindow.Build.width,
								shortcutsWindow.Build.height
							),
							true,
							loc(TID_Options_Keybinds_Build),
							{
								font_name = Tahoma_12B,
								font_style_outline=true,
								text_halign=ALIGN_MIDDLE,
								callback_mouseclick='changeShortcutList(2);',
								highlight=true,
							}
					);

shortcutsWindow.Research = getElementEX(
						shortcutsWindow,
						anchorRT,
						XYWH(
							6+(shortcutsWindow.width-8)/3*2,
							68,
							(shortcutsWindow.width-8)/3,
							30
						),
						true,
						{
							colour1=RGBA(70,70,70,255),
						--	callback_mouseclick='',
							bevel=true,
						}
				);

shortcutsWindow.Research.Label = getLabelEX(
							shortcutsWindow.Research,
							anchorRT,
							XYWH(
								0,
								0,
								shortcutsWindow.Research.width,
								shortcutsWindow.Research.height
							),
							true,
							loc(TID_Options_Keybinds_Research),
							{
								font_name = Tahoma_12B,
								font_style_outline=true,
								text_halign=ALIGN_MIDDLE,
								callback_mouseclick='changeShortcutList(3);',
								highlight=true,
							}
					);

	setVisible(shortcutsWindow.ListBoxBuild,false);
	setVisible(shortcutsWindow.ListBoxResearch,false);
	setVisible(shortcutsWindow.ListBoxBuild_scrollV,false);
	setVisible(shortcutsWindow.ListBoxResearch_scrollV,false);
	setEnabled(shortcutsWindow.Commands.Label , false);


function changeShortcutList(index)
	setVisible(shortcutsWindow.ListBoxCommands,false);
	setVisible(shortcutsWindow.ListBoxBuild,false);
	setVisible(shortcutsWindow.ListBoxResearch,false);
	setVisible(shortcutsWindow.ListBoxCommands_scrollV,false);
	setVisible(shortcutsWindow.ListBoxBuild_scrollV,false);
	setVisible(shortcutsWindow.ListBoxResearch_scrollV,false);
	setEnabled(shortcutsWindow.Commands.Label , false);
	setEnabled(shortcutsWindow.Build.Label , false);
	setEnabled(shortcutsWindow.Research.Label , false);

	if index == 1 then
		setVisible(shortcutsWindow.ListBoxCommands,true);
		setVisible(shortcutsWindow.ListBoxCommands_scrollV,true);
		setEnabled(shortcutsWindow.Build.Label , true);
		setEnabled(shortcutsWindow.Research.Label , true);
	elseif index == 2 then
		setVisible(shortcutsWindow.ListBoxBuild,true);
		setVisible(shortcutsWindow.ListBoxBuild_scrollV,true);
		setEnabled(shortcutsWindow.Commands.Label , true);
		setEnabled(shortcutsWindow.Research.Label , true);
	else
		setVisible(shortcutsWindow.ListBoxResearch,true);
		setVisible(shortcutsWindow.ListBoxResearch_scrollV,true);
		setEnabled(shortcutsWindow.Commands.Label , true);
		setEnabled(shortcutsWindow.Build.Label , true);
	end;
end;






shortcutsList = {};
function createListOfShortcuts()
	shortcutsList = {};
	createListSC(listOfShorcutsText.Commands,shortcutsWindow.ListBoxCommands);
	createListSC(listOfShorcutsText.Buildings,shortcutsWindow.ListBoxBuild);
	createListSC(listOfShorcutsText.Research,shortcutsWindow.ListBoxResearch);
end;

function createListSC(list,target)

	local rowcolour1={red=0,green=0,blue=0,alpha=127};
	local rowcolour2={red=50,green=50,blue=50,alpha=27};
	local colourhover={red=150,green=200,blue=150,alpha=200};

	local fcolourover={red=255,green=255,blue=255,alpha=255};
	local fcolourleave={red=150,green=200,blue=150,alpha=255};

	sgui_deletechildren(target.ID);

	getElementEX(
		target,
		anchorLT,
		XYWH(
			0,
			0,
			1,
			1
		),
		true,
		{
			colour1=WHITEA(0);
		}
	);

	for k,v in pairs(list) do

		shortcutsList[v] = {};
		local SC = shortcutsList[v];
		SC.value = v;
		SC.string = loc(v);
		local hi, hj = string.find(SC.string, "|") ;

		if hi ~= nil then
			SC.key = string.sub(SC.string, hi+1, hi+1); --SC.string [SC.key];
			SC.string = string.gsub(SC.string , "%[|" ..SC.key.."%]",'');
		end;

		SC.dKey = SC.key;

		local hk = OW_SETTING_READ_STRING('SHORTCUTS', v, "•");
		if hk ~= "•" then
			SC.key = hk;
		elseif SC.key == nil then
			SC.key = "???";
		end;
		local colour=rowcolour2;
		if odd(k) then
			colour=rowcolour1;
		end;

		SC.Row = getElementEX(
			target,
			anchorLT,
			XYWH(
				1,
				1*(k-1)*50,
				target.width-2,
				48

			),
			true,
			{
				colour1 = colour,
				callback_mouseclick = "showDialogBindkey(" .. SC.value ..");" ,
			}
		);

		SC.KeyRow = getElementEX(
			SC.Row,
			anchorLT,
			XYWH(
				0,
				0,
				30,
				49

			),
			true,
			{
				colour1 = BLACKA(0),
				nomouseevent=true,
			}
		);

		SC.LabelKey = getLabelEX(
			SC.KeyRow,
			anchorLT,
			XYWH(
				0,
				2,
				30,
				47
			),
			Tahoma_16B,
			SC.key,
			{
				text_halign=ALIGN_MIDDLE,
				font_colour = colourhover,
			}
		);

		setBorder(SC.KeyRow,BORDER_TYPE_INNER,1,RGBA(255,255,255,255) );

		SC.TextRow = getElementEX(
			SC.Row,
			anchorLT,
			XYWH(
				30,
				0,
				SC.Row.width-30,
				49

			),
			true,
			{
				colour1 = BLACKA(0),
				nomouseevent=true,
			}
		);

		SC.Label = getLabelEX(
			SC.TextRow,
			anchorLT,
			XYWH(
				2,
				2,
				SC.TextRow.width-28,
				47
			),
			Tahoma_16,
			SC.string,
			{
				text_halign=ALIGN_LEFT,
				scissor = true,
				font_colour = colourhover,
			}
		);

		setBorder(SC.TextRow,BORDER_TYPE_INNER,1,RGBA(255,255,255,255) );

		set_Callback(SC.Row.ID,CALLBACK_MOUSEOVER,'setColour1ID('..SC.Row.ID..','..colourToString(colourhover)..');setFontColourID('..SC.Label.ID..','..colourToString(fcolourover)..');setFontColourID('..SC.LabelKey.ID..','..colourToString(fcolourover)..');');
		set_Callback(SC.Row.ID,CALLBACK_MOUSELEAVE,'setColour1ID('..SC.Row.ID..','..colourToString(colour)..');setFontColourID('..SC.Label.ID..','..colourToString(fcolourleave)..');setFontColourID('..SC.LabelKey.ID..','..colourToString(fcolourleave)..');');
	end;

end;

function restoreKeys()
	for k,v in pairs(shortcutsList) do
		if v.key ~= v.dKey then
			v.key = v.dKey;
			setText(v.LabelKey,v.dKey);

		end;
	end;

end;


function changeKeysByDatabase(type)
	if type == 1 or type == 2 then
		for k,v in pairs(shortcutsList) do

			local commandKey = GridOfShortcuts[k];

			if type == 2 then
				if commandKey == "Z" then
					commandKey = "Y";
				elseif commandKey == "Y" then
					commandKey = "Z";
				end;
			end;

			v.key = commandKey;
			setText(v.LabelKey,v.key);

		end;

	end;
end;

function saveShortcuts()
	for k, v in pairs(shortcutsList) do
		if v.key == v.dKey then
			OW_SETTING_WRITE('SHORTCUTS',k,"•");
		else
			OW_SETTING_WRITE('SHORTCUTS',k,v.key);
		end;
	end;
	setVisible(shortcutsClone,false);
end;

dialog.bindkey = getDialogEX(dialog.back,anchorNone,XYWH(LayoutWidth / 2 - 200,0,400,200),SKINTYPE_DIALOG1,{tile=true});

dialog.bindkey.title = getLabelEX(dialog.bindkey,
	anchorLT,
	XYWH(
		0,
		20,
		400,
		20
	),
	Tahoma_20B,
	loc(TID_Options_Dialog_ChangeKeybind),
	{
		text_halign=ALIGN_MIDDLE,
		font_colour=RGB(120,35,35),
});

	dialog.bindkey.bind = AddElement({
		type=TYPE_EDIT,
		parent=dialog.bindkey,
		anchor={top=true,bottom=true,left=false,right=false},
		x=5,
		y=70,
		width=dialog.bindkey.width-10,
		height=60,
		colour1=BLACKA(200),
		font_name=Tahoma_20B ,
		wordwrap=false,
		visible=true,
		bevel=true;
		bevel_colour1=GRAYA(14,200),
		bevel_colour2=GRAYA(14,200),
		text=getvalue(OWV_USERNAME),
		text_halign=ALIGN_MIDDLE,
		callback_keyup='dialog.bindkey.bind_keyup(%k);',
		--edges=true,
	});

function showDialogBindkey(ID)
	ShowDialog(dialog.bindkey);
	CurrentSCSelected = ID;
	setText(dialog.bindkey.bind,shortcutsList[ID].key);
end;
AllowedKeysBind = "ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÃÂÄĂĄÆČÇĆĎĐÉÈĚÊËĘÍÌÎÏŁĹĽŇÑŃÓÕÔŐÖŒŘŔŠŞŚŤŢÙÚÛŮÜŰÝŽŻŹÀÁÃÂÄĂĄÆČÇĆĎĐÉÈĚÊËĘÍÌÎÏŁĹĽŇÑŃÓÕÔŐÖŒŘŔŠŞŚŤŢÙÚÛŮÜŰÝŽŻŹ";
CurrentSCSelected= 0;
function dialog.bindkey.bind_keyup(key)

	if key == 13 then
		applyKeyBind();
	elseif key == 8 then
		setText(dialog.bindkey.bind, "???");
	elseif key == 27 then
		HideDialog(dialog.bindkey);
	else
		local char = string.upper(string.char(key));
		local hi,hj = string.find(AllowedKeysBind, char);

		if hi ~= nil then
			setText(dialog.bindkey.bind, char);
		end;
	end;
end;

function applyKeyBind()
	HideDialog(dialog.bindkey);
	shortcutsList[CurrentSCSelected].key = getText(dialog.bindkey.bind);
	setText(shortcutsList[CurrentSCSelected].LabelKey,shortcutsList[CurrentSCSelected].key);

end;

dialog.bindkey.Cancel    = getImageButtonEX(dialog.bindkey,
	anchorRB,
	XYWH(
		10+130+130,
		dialog.bindkey.height-50,
		120,
		30
	),
	loc(TID_Main_Menu_Options_Cancel),
	'',
	'HideDialog(dialog.bindkey);',
	SKINTYPE_BUTTON,
	{
		font_colour_disabled=GRAY(127)
});

dialog.bindkey.Default    = getImageButtonEX(dialog.bindkey,
	anchorRB,
	XYWH(
		10+130,
		dialog.bindkey.height-50,
		120,
		30
	),
	loc(TID_Main_Menu_Options_Default),
	'',
	'ChangeOnDefailt();',
	SKINTYPE_BUTTON,
	{
		font_colour_disabled=GRAY(127)
});

function ChangeOnDefailt()
		setText(dialog.bindkey.bind,shortcutsList[CurrentSCSelected].dKey);
end;

dialog.bindkey.OK    = getImageButtonEX(dialog.bindkey,
	anchorRB,
	XYWH(
		10,
		dialog.bindkey.height-50,
		120,
		30
	),
	loc(TID_Main_Menu_Options_OK),'',
	'applyKeyBind();',
	SKINTYPE_BUTTON,
	{
		font_colour_disabled=GRAY(127)
});

function insertCostumKey()


end;

