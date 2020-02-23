-----------------------------------------------------------------------------
---  Orig. File : /lua/menu/window_profiles.lua
---  Version    : 5
---
---  Summary    : Profiles
---
---  Created    : Stuart 'Stucuk' Carey, OW Support
---               Petr 'Sali' Salak, Freya Group
------------------------------------------------------------------------------
profile = getElementEX(menu,anchorLTRB,XYWH(0,0,LayoutWidth,LayoutHeight),false,{colour1=BLACKA(50)});
profileWindow = getWindowEX(profile,anchorNone,XYWH(menu.side.width+40, 130, LayoutWidth-(menu.side.width+60),LayoutHeight-200),true,loc(TID_Main_Menu_Player_Selection),
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

profile_list = AddElement({
	type=TYPE_SCROLLBOX,
	parent=profileWindow,
	anchor={top=true,bottom=true,left=true,right=true},
	x=20,
	y=50+4,
	width=profileWindow.width-40-104-50-13,
	height=profileWindow.height-70,
	colour1=ListBox_Colour1,
	text='test',
--	callback_indexset='profile_listindexset();',
});

profile_list_scroll = AddElement({
	type=TYPE_SCROLLBAR,
	parent=profileWindow,
	anchor={top=true,bottom=true,left=false,right=true},
	x=profile_list.x+profile_list.width+1,
	y=profile_list.y,
	width=12,
	height=profile_list.height,
	colour1=Scrollbar_Colour1,
	colour2=Scrollbar_Colour2,
	texture2="scrollbar.png",
});

sgui_set(profile_list.ID,PROP_SCROLLBAR,profile_list_scroll.ID);
ProfileRowData = {};
profileSelected = 0;
CurrentLoadedProfile = 0;

function FROMOW_PROFILES(DATA)
--[[
DATA
	COUNT : Integer;
	PROFILE : Array of
		NAME : String
		SELECTED : Boolean
--]]
	sgui_deletechildren(profile_list.ID);
	ProfileRowData = {};
	if DATA.COUNT > 0 then
		for i = 1, DATA.COUNT do
--			sgui_set(profile_list.ID,SGUI_CustomListBox_AddItem,DATA.PROFILE[i]);
			ProfileRowData[i] = Profile_Add(i,DATA.PROFILE[i])
			if DATA.PROFILE[i].SELECTED == true then
				setText(profile_label, string.sub(DATA.PROFILE[i].NAME, 0, 20));
				ReloadAvatar();
			end;
		end;
	end;
end;


function Profile_Add(index,data)


	local rowcolour1={red=0,green=50,blue=0,alpha=127};
	local rowcolour2={red=110,green=250,blue=150,alpha=200};
        local normalcolour={red=0,green=0,blue=0,alpha=127};

	local colourhover={red=75,green=100,blue=75,alpha=100};

	local fcolourover={red=255,green=255,blue=255,alpha=255};
	local fcolourleave={red=150,green=200,blue=150,alpha=255};


	local Row = getElementEX(
		profile_list,
		anchorLTR,
		XYWH(
			0,
			(index-1)*66,
			getWidth(profile_list),
			65
		),
		true,
		{
			colour1=normalcolour,
			callback_mouseclick='update_profile_select('..index..')',
			callback_mousedblclick='profile_selectclick(0);',
		}
	);

	Row.Avatar = getElementEX(
		Row,
		anchorLT,
		XYWH(
			0,
			0,
			65,
			65
		),
		true,
		{
                   texture='Avatars/baseHead.png',
                   texture_fallback='Avatars/baseHead.png'
		}
	);
	set_Colour(Row.ID,PROP_GRADIENT_COL1,rowcolour1);
	set_Colour(Row.ID,PROP_GRADIENT_COL2,rowcolour2);

	Row.Selected = data.SELECTED;
	if Row.Selected then
		set_Property(Row.ID,PROP_GRADIENT,true);
		profileSelected = index;
		CurrentLoadedProfile = index;
	end;

	Row.Name = data.NAME;

	Row.NameLabel     = getLabelEX(Row,anchorLTRB,XYWH(70,0,30,getHeight(Row)),Neuropol, string.sub(Row.Name, 0, 20),{nomouseevent=true,font_colour=fcolourleave, font_scale=0.4});

	set_Callback(Row.ID,CALLBACK_MOUSEOVER,'setColour1ID('..Row.ID..','..colourToString(colourhover)..');setFontColourID('..Row.NameLabel.ID..','..colourToString(fcolourover)..');');
	set_Callback(Row.ID,CALLBACK_MOUSELEAVE,'setColour1ID('..Row.ID..','..colourToString(normalcolour)..');setFontColourID('..Row.NameLabel.ID..','..colourToString(fcolourleave)..');');



	return Row;
end;

function update_profile_select(index)
	if profileSelected > 0 then
		ProfileRowData[profileSelected].Selected = false;
		set_Property(ProfileRowData[profileSelected].ID,PROP_GRADIENT,false);
	end;
	profileSelected = index;
	ProfileRowData[index].Selected = true;
	set_Property(ProfileRowData[index].ID,PROP_GRADIENT,true);
end;


--profile_select = makeGradButton({
--	parent=profileWindow,
--	anchor={top=false,bottom=true,left=true,right=true},
--	x=20+profileWindow.width-190,
--	y=50,
--	width=150,
--	height=24,
--	text=loc(TID_Main_Menu_User_Select),
--	font_colour_disabled=GRAY(127),
--	callback_mouseclick='profile_selectclick(0);',
--},GradButton_Blue_Light);*/
profile_select = getImageButtonEX(profileWindow,anchorBLR,XYWH(10+profileWindow.width-190,50,170,24), loc(TID_Main_Menu_User_Select), '', 'profile_selectclick(0);', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });


--profile_new = makeGradButton({
--	parent=profileWindow,
--	anchor={top=true,bottom=false,left=false,right=true},
--	x=profile_select.x,
--	y=profile_select.y+30,
--	width=150,
--	height=24,
--	text=loc(TID_Main_Menu_Current_Player_Add),--'New',
--	disabled=true,
--	hint=loc(TID_Main_Menu_Current_Player_Add_Hint),
--	font_colour_disabled=GRAY(127),
--	callback_mouseclick='show_profile_dialog(1);',
--},GradButton_Green);
profile_new    = getImageButtonEX(profileWindow,anchorRT,XYWH(10+profileWindow.width-190,104,170,24), loc(TID_Main_Menu_Current_Player_Add), '', 'show_profile_dialog(1);', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });

--profile_rename = makeGradButton({
--	parent=profileWindow,
--	anchor={top=true,bottom=false,left=false,right=true},
--	x=profile_new.x,
--	y=profile_new.y+30,
--	width=150,
--	height=24,
--	text=loc(TID_Main_Menu_Current_Player_Rename),--'Rename',
--	disabled=true,
--	font_colour_disabled=GRAY(127),
--	callback_mouseclick='show_profile_dialog(2);',--'profile_renameclick();',
--},GradButton_Purple);
profile_rename = getImageButtonEX(profileWindow,anchorRT,XYWH(10+profileWindow.width-190,138,170,24), loc(TID_Main_Menu_Current_Player_Rename), '', 'show_profile_dialog(2);', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png',
                                   disabled=true
                                 });

--profile_delete = makeGradButton({
--	parent=profileWindow,
--	anchor={top=true,bottom=false,left=false,right=true},
--	x=profile_rename.x,
--	y=profile_rename.y+30,
--	width=150,
--	height=24,
--	text=loc(TID_Main_Menu_Current_User_Erase_profile),--'Delete',
--	disabled=true,
--	font_colour_disabled=GRAY(127),
--	callback_mouseclick='profile_deleteclick();',
--},GradButton_Red);
profile_delete = getImageButtonEX(profileWindow,anchorRT,XYWH(10+profileWindow.width-190,172,170,24), loc(TID_Main_Menu_Current_User_Erase_profile), '', 'profile_deleteclick();', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });

--profile_close = makeGradButton({
--	parent=profileWindow,
--	anchor={top=true,bottom=false,left=false,right=true},
--	x=profile_rename.x,
--	y=profile_list.y+profile_list.height-24,
--	width=150,
--	height=24,
--	text=loc(TID_msg_Cancel),--'Cancel',
--	disabled=true,
--	font_colour_disabled=GRAY(127),
--	callback_mouseclick='setVisible(profile,false);inProfileChange=false;',
--},GradButton_Grey_Light);
profile_close  = getImageButtonEX(profileWindow,anchorRT,XYWH(10+profileWindow.width-190,profile_list.y+profile_list.height-34,170,24), loc(TID_msg_Cancel), '', 'setVisible(profile,false);inProfileChange=false;', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });

profile_count = 1;

inProfileChange =false;
function profile_show()
	inProfileChange = true;
	profile_count = OW_profile_init();

	if (profile_count > 0) then
		setEnabled(profile_delete,true);
		setEnabled(profile_rename,true);
	else
		setEnabled(profile_delete,false);
		setEnabled(profile_rename,false);
	end;

	--setText(dialog.Profile.profile_edit,getLine(profile_list));
	profile_name_check();
	setVisible(profile,true);
end;

function profile_selectclick(button)
	local sName = ProfileRowData[profileSelected].Name;
	OW_profile_switch(sName);
	setText(profile_label, string.sub(sName, 0, 20));

	ReloadAvatar();

	if (button == 0) then
		setVisible(profile,false)
		inProfileChange=false;
	end;
end;

function profile_listindexset()
	setText(dialog.Profile.profile_edit,getLine(profile_list));
end;

function profile_deleteclick()
	if OW_profile_delete(ProfileRowData[profileSelected].Name) then
		profile_selectclick(1);
	end;

end;

function profile_newclick()
	if OW_profile_new(getText(dialog.Profile.profile_edit)) then
--		profile_show();
		local sName = getText(dialog.Profile.profile_edit);
		OW_profile_switch(sName);
		setText(profile_label, string.sub(sName, 0, 20));
		setVisible(profile,false);
		ReloadAvatar();
		inProfileChange=false;
		changeProfileAvatar();
	end;
end;

function profile_renameclick()
	if OW_profile_rename(ProfileRowData[profileSelected].Name,getText(dialog.Profile.profile_edit)) then
		if getText(profile_label) == string.sub(ProfileRowData[profileSelected].Name, 0, 20) then
			setText(profile_label, string.sub(getText(dialog.Profile.profile_edit), 0, 20));
		end;
		ProfileRowData[profileSelected].Name = getText(dialog.Profile.profile_edit);
		setText(ProfileRowData[profileSelected].NameLabel,getText(dialog.Profile.profile_edit));
--		profile_show();
	end;
end;

function profile_name_check()
	if (OW_profile_exists(getText(dialog.Profile.profile_edit)) == true) then
		setEnabled(dialog.Profile.profile_new ,false);

		setVisible(dialog.Profile.disabled_hint,true);
		setEnabled(dialog.Profile.profile_rename,false);
	else
		setEnabled(dialog.Profile.profile_new ,true);

		setVisible(dialog.Profile.disabled_hint,false);
		setEnabled(dialog.Profile.profile_rename,true);
	end;
	if (profile_count > 0) then
		setEnabled(profile_rename,true);
		setEnabled(profile_delete,true);
	else
		setEnabled(profile_rename,false);
		setEnabled(profile_delete,false);
	end;
end;


function profile_editkeyup()
	profile_name_check();
end;


function show_profile_dialog(int)
	if int == 1 then
		setVisible(dialog.Profile.profile_new,true);
		setVisible(dialog.Profile.profile_rename, false);
		setText(dialog.Profile.profile_edit,'');
	else
		setVisible(dialog.Profile.profile_new,false);
		setVisible(dialog.Profile.profile_rename, true);
		setText(dialog.Profile.profile_edit,ProfileRowData[profileSelected].Name);
	end;
	ShowDialog2(dialog.Profile,true);
end;
dialog.Profile = getDialogEX(dialog.back,anchorNone,XYWH(LayoutWidth / 2 - 275,0,350,120),SKINTYPE_DIALOG1,
		 {
                 	tile=true,
                        border_type=BORDER_TYPE_OUTER,
                        border_colour=GREENA(70),
                        border_size=1
                 });

dialog.Profile.profile_edit = AddElement({
	type=TYPE_EDIT,
	parent=dialog.Profile,
	anchor={top=true,bottom=false,left=true,right=true},
	x=20,
	y=20,
	width=dialog.Profile.width-40,
	height=24,
	colour1=Edit_Colour1,
	colour2=Edit_Colour2,
	text='',
	--texture2='edit.png',
	callback_keyup='profile_editkeyup();',
});


--dialog.Profile.profile_new = makeGradButton({
--	parent=dialog.Profile,
--	anchor={top=true,bottom=false,left=false,right=true},
--	x=dialog.Profile.profile_edit.x,
--	y=70,
--	width=150,
--	height=24,
--	text=loc(TID_Main_Menu_Current_Player_Add),--'New',
--	disabled=true,
--	font_colour_disabled=GRAY(127),
--	callback_mouseclick='HideDialog(dialog.Profile ); profile_newclick();',
--},GradButton_Green);
dialog.Profile.profile_new    =  getImageButtonEX(dialog.Profile,anchorRT,XYWH(dialog.Profile.profile_edit.x,70,150,24), loc(TID_Main_Menu_Current_Player_Add), '', 'HideDialog(dialog.Profile ); profile_newclick();', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });

--dialog.Profile.profile_rename = makeGradButton({
--	parent=dialog.Profile,
--	anchor=dialog.Profile.profile_new.anchor,
--	x=dialog.Profile.profile_new.x,
--	y=dialog.Profile.profile_new.y,
--	width=dialog.Profile.profile_new.width,
--	height=dialog.Profile.profile_new.height,
--	text=loc(TID_Main_Menu_Current_Player_Rename),--'Rename',
--	disabled=true,
--	font_colour_disabled=GRAY(127),
--	callback_mouseclick='profile_renameclick(); HideDialog(dialog.Profile );',
--,GradButton_Purple);
dialog.Profile.profile_rename =  getImageButtonEX(dialog.Profile,anchorRT,XYWH(dialog.Profile.profile_new.x,dialog.Profile.profile_new.y,150,24), loc(TID_Main_Menu_Current_Player_Rename), '', 'profile_renameclick(); HideDialog(dialog.Profile );', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });

dialog.Profile.disabled_hint = AddElement ({
	type=TYPE_ELEMENT,
	parent=dialog.Profile,
	anchor=dialog.Profile.profile_new.anchor,
	x=dialog.Profile.profile_new.x,
	y=dialog.Profile.profile_new.y,
	width=dialog.Profile.profile_new.width,
	height=dialog.Profile.profile_new.height,
	colour1 = WHITEA(0),
	hint=loc(TID_Main_Menu_Current_Player_Add_Hint),
});

--dialog.Profile.profile_close = makeGradButton({
--	parent=dialog.Profile,
--	anchor={top=true,bottom=false,left=false,right=true},
--	x=dialog.Profile.profile_new.x+160,
--	y=70,
--	width=150,
--	height=24,
--	text=loc(TID_msg_Cancel),--'Cancel',
--	disabled=true,
--	font_colour_disabled=GRAY(127),
--	callback_mouseclick='HideDialog(dialog.Profile );',
--},GradButton_Grey_Light);

dialog.Profile.profile_close  =  getImageButtonEX(dialog.Profile,anchorRT,XYWH(dialog.Profile.profile_new.x+160, 70,150,24), loc(TID_msg_Cancel), '', 'HideDialog(dialog.Profile );', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });



-------------------------------  Profile Avatar --------------------------
profileAvatar = getElementEX(
						menu,
						anchorRT,
						XYWH(
							0,
							0,
							ScrWidth,
							ScrHeight
						),
						false,
						{
							colour1=BLACKA(50),
							callback_mouseclick='close_SteamAvatar();',
						}
				);

profileAvatar.tabPAvatar = getElementEX(
						profileAvatar,
						anchorRT,
						XYWH(
							LayoutWidth - (LayoutWidth-menu.side.width-2*55)/2,
							LayoutHeight/2- 130-30,
							(LayoutWidth-menu.side.width-2*55)/2-1,
							30
						),
						true,
						{
							colour1=RGBA(70,70,70,255),
						--	callback_mouseclick='',
							bevel=true,
						}
				);

profileAvatar.tabPAvatar.Label = getLabelEX(
							profileAvatar.tabPAvatar,
							anchorRT,
							XYWH(
								0,
								0,
								profileAvatar.tabPAvatar.width,
								profileAvatar.tabPAvatar.height
							),
							true,
							loc(TID_Main_Menu_Avatar_Selection),
							{
								font_name = Tahoma_12B,
								font_style_outline=true,
								text_halign=ALIGN_MIDDLE,
								callback_mouseclick='changeProfileAvatar();',
								highlight=true,
							}
					);

profileAvatar.window = getWindowEX(
							profileAvatar,
							anchorNone,
							XYWH(
								LayoutWidth - (LayoutWidth-menu.side.width-2*55)/2,
								LayoutHeight/2- 130,
								LayoutWidth-menu.side.width-2*55,
								LayoutHeight-220
							),
							false,
							loc(TID_Main_Menu_Avatar_Selection),
							WINDOW_BACKGROUND,
							{

							} );


profileAvatar.list = AddElement({
	type=TYPE_LISTBOX,
	parent=profileAvatar.window,
	anchor={top=true,bottom=true,left=true,right=true},
	x=20,
	y=40,
	width=profileAvatar.window.width-40,
	height=profileAvatar.window.height-130,
	colour1=ListBox_Colour1,
	--callback_indexset='',
});

profileAvatar.list_scroll = AddElement({
	type=TYPE_SCROLLBAR,
	parent=profileAvatar.window,
	anchor={top=true,bottom=true,left=false,right=true},
	x=profileAvatar.list.x+profileAvatar.list.width+1,
	y=profileAvatar.list.y,
	width=12,
	height=profileAvatar.list.height,
	colour1=Scrollbar_Colour1,
	colour2=Scrollbar_Colour2,
	texture2="scrollbar.png",
});

sgui_set(profileAvatar.list.ID,PROP_SCROLLBAR,profileAvatar.list_scroll.ID);

profileAvatar.select = makeGradButton({
	parent=profileAvatar.window,
	anchor={top=false,bottom=true,left=true,right=true},
	x=profileAvatar.list.x,
	y=profileAvatar.list.y+profileAvatar.list.height+5+5+20,
	width=profileAvatar.list.width,
	height=30,
	text=loc(TID_Main_Menu_Avatar_Select),
	font_colour_disabled=GRAY(127),
	callback_mouseclick='close_SteamAvatar();',
},GradButton_Grey_Light);


listOfAvatars = {
	'BASEHEAD','BASEHEAD2','CAR','EON','EON2','SIBERIT','SIBERIT2','LOGO_AM','LOGO_AM2','LOGO_AR','LOGO_AR2','LOGO_RU','LOGO_RU2','LOGO_ALLY','LOGO_LEG' , 'LOGO_REB', 'SIBERIA3','SIBERIA', 'SIBERIA2',   'LAKE', 'PACIFIST', 'MAD', 'AMER_W', 'MCMILLAN', 'POWELL', 'EMMERSON','HEIKE','ARAB','SHEIK','PLATONOV','BURLAK','APE','APE2','MIKE','MASTODON','MASTODON2','TIGER','SKULL', 'LABORATORY', 'SHIPTMENT','CRATES', 'VEHICLE_AM_GUN','VEHICLE_AR_HEAVY', 'VEHICLE_ROCKET', 'VEHICLE_AR_DMG', 'VEHICLE_RU_GG',
};

picLockedByAchiev = {
	['BURLAK'] = 'ACH_FRWL',
	['MCMILLAN'] = 'ACH_ADV',
	['EMMERSON'] = 'ACH_EON',
	['LOGO_AM2'] = 'ACH_APAT',
	['LOGO_RU2'] = 'ACH_RPAT',
	['CRATES'] = 'ACH_CAP',
	['LOGO_AR2'] = 'ACH_EMP',
	['SKULL'] = 'ACH_RAD',
	['PACIFIST'] = 'ACH_PAC',
	['MAD'] = 'ACH_MAD',
	['MIKE'] = 'ACH_POTA',
	['SIBERIT'] = 'ACH_FBF',
	['POWELL'] = 'ACH_GBA',
	['PLATONOV'] = 'ACH_FMR',

};

selectAv = nil;
profileXichtAvatar = nil;

function createList()
	sgui_deletechildren(profileAvatar.list.ID);

	selectAv = getElementEX(
		profileAvatar.list,
		anchorTL,
		XYWH(
			4,
			4,
			64,
			64
		),
		true,
		{
			colour1=RGBA(0,0,255,50),
			callback_mousedblclick = 'close_SteamAvatar();'
		}
	);

	for i=0, table.getn(listOfAvatars)+1 do

		local w = getWidth(profileAvatar.list)-8;
		local countW = div(w,65);

		local x = mod(i,countW);
		local y = div(i,countW);
		local name = listOfAvatars[i-1] ;
		local tex;
		if i ~= 0 and i ~= 1 then
			tex = 'Avatars/'.. name..'.png';
		end;
		local col = WHITEA(255);
		local col2 = RGBA(200,250,200,255);
		local hint = '';
		local callback = 'setAvatar('.. x .. ',' .. y .. ',' .. i  .. ');'
											.. 'setColour1ID(%id,'..colourToString(WHITEA(255))..');'
		if picLockedByAchiev[name] then
			local achieved = checkAchieved(picLockedByAchiev[name]);
			if not achieved == true and achievements[picLockedByAchiev[name]] then
				col = GRAY(100);
				callback = '';
				hint = loc_format(TID_LockedByAchiev, {achievements[picLockedByAchiev[name]][1]});
				col2 = RGBA(100,50,50,255);
			end;
		end;


		local avatar = getElementEX(
					profileAvatar.list,
					anchorTL,
					XYWH(
						x*65+4,
						y*65+4,
						64,
						64
					),
					true,
					{
						colour1=col,
						texture = tex,
						texture_fallback='Avatars/unknow.png',
						hint = hint,
						--texture2 = 'Avatars/frame.png',
						callback_mouseclick = callback,
					}
				);

		set_Callback(avatar.ID,CALLBACK_MOUSEOVER,'setColour1ID('..avatar.ID..','..colourToString(col2)..');');
		set_Callback(avatar.ID,CALLBACK_MOUSELEAVE,'setColour1ID('..avatar.ID..','..colourToString(col)..');');

		if i == 0 then

			local asigned = OW_steam_assign_avatar(avatar.ID);
			if asigned == false then
				--setVisible(avatar,false);
				setEnabled(avatar,false);
				setTexture(avatar, 'Avatars/unknow.png');
			end;
		elseif i == 1 then
			profileXichtAvatar = avatar;

			setTexture(profileXichtAvatar,'Avatars/unknow.png');
	------------ -- here set OW xihct avatar to select like profile picture  - profileXichtAvatar ---------------------------------------------------------------------
			setXYWHV(profileXichtAvatar,profileXichtAvatar.x+6,profileXichtAvatar.y,profileXichtAvatar.width-12,profileXichtAvatar.height);
		end;

	end;

	bringToFront(selectAv);
end;

function changeProfileAvatar()
	if inProfileChange == false then

		if  SteamInitialized then
			selectedAvatar = OW_SETTING_READ_NUMBER('OPTIONS', 'AVATAR', 0);
		else
			selectedAvatar = OW_SETTING_READ_NUMBER('OPTIONS', 'AVATAR', 2);
		end;

		createList();

		for i=0, table.getn(listOfAvatars)+1 do
			if i == selectedAvatar then
				local w = getWidth(profileAvatar.list)-2;
				local countW = div(w,65);

				local x = mod(i,countW);
				local y = div(i,countW);

				setXYV(selectAv,x*65+4,y*65+4);
			end;
		end;



		setVisible(profileAvatar,true);
		setVisible(profileAvatar.window,true);
		setEnabled(profileAvatar.tabPAvatar.Label , false);
		setVisible(changeHero.window,false);
		setEnabled(changeHero.tabHAvatar.Label, true);

	end;


end;
--[[
function set_steamAvatar(val)

	OW_SETTING_WRITE('OPTIONS', 'STEAM_AVATAR', val);


end;
]]--
function setAvatar(x,y,name)

	selectedAvatar = name;
	OW_SETTING_WRITE('OPTIONS','AVATAR',name);
	setXYV(selectAv,x*65+4,y*65+4);

	ReloadAvatar();
end;

function close_SteamAvatar()
	setVisible(profileAvatar,false);

	--ReloadAvatar();

end;

function ReloadAvatar()
	if  SteamInitialized then
		selectedAvatar = OW_SETTING_READ_NUMBER('OPTIONS', 'AVATAR', 0);
	else
		selectedAvatar = OW_SETTING_READ_NUMBER('OPTIONS', 'AVATAR', 2);
	end;

	if selectedAvatar == 0 then
			local asigned = OW_steam_assign_avatar(profile_avatar.ID);
			if asigned == false then
				setTexture(profile_avatar, 'Avatars/unknow.png');
			end;
			setXYWHV(profile_avatar,profile_avatar.x,profile_avatar.y,64,profile_avatar.height);
	elseif selectedAvatar == 1 then

------------ -- here set OW xihct avatar to BAR  - profile_avatar --------------------------------------------------------------------
		setXYWHV(profile_avatar,profile_avatar.x,profile_avatar.y,51,profile_avatar.height);
	else
			setTexture(profile_avatar, 'Avatars/'.. listOfAvatars[selectedAvatar-1] .. '.png');
			setXYWHV(profile_avatar,profile_avatar.x,profile_avatar.y,64,profile_avatar.height);
	end;

	if inMultiplayer == true then
		reloadMyAvatarInMP();
	end;
end;

function profileXichtAvatar_setAvatar()
------------ -- here set OW xihct avatar to select like profile picture  - profileXichtAvatar ---------------------------------------------------------------------
	if selectedAvatar == 1 then
------------ -- here set OW xihct avatar to BAR  - profile_avatar ---------------------------------------------------------------------
	end;
end;
