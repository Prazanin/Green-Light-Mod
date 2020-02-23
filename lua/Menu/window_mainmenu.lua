-----------------------------------------------------------------------------
---  Orig. File : /lua/window_mainmenulua
---  Version    : 23
---
---  Summary    : Main Menu
---
---  Created    : Stuart 'Stucuk' Carey, OW Support
---               Petr 'Sali' Salak, Freya Group
------------------------------------------------------------------------------

setColour1({ID=desktop},BLACKA(0));
CampOverride = -1;

menu = getElementEX(nil,anchorLTRB,XYWH(0,0,LayoutWidth,LayoutHeight),true,{texture='mainbackground1.png'});
logo = getElementEX(menu,anchorT,XYWH(75+(LayoutWidth-75)/2 - 630/2,50,630,180),true,{texture='logo.png'});--'OWlogowt.png'});
logotext = getLabelEX(menu,anchorT,XYWH(75,50+180-10,LayoutWidth-75,30),Eurostile_70_1,loc(TID_Main_Menu_Title)
                      ,{visible=false, shadowtext=true, text_case=CASE_UPPER, text_halign=ALIGN_MIDDLE, font_colour=WHITE(), font_style_outline=true}); --'WHO CONTROLS THE PAST CONTROLS THE FUTURE'

function logoVisible(value)
	setVisible(logo,value);
end;

version = getLabelEX(menu,anchorLRB,XYWH(0,LayoutHeight-24,LayoutWidth-5,24),Tahoma_12B,'?.?.?.?',
		     {nomouseevent=true, text_halign=ALIGN_RIGHT});

if getvalue(OWV_ISMOD) then
	mod_version= getLabelEX(menu,anchorLRB,XYWH(0,LayoutHeight-24*2,LayoutWidth-5,24),Tahoma_12B,'?.?.?.?',
				{nomouseevent=true, text_halign=ALIGN_RIGHT});
end;

menu.side = getElementEX(menu,anchorLTB,XYWH(0,0,270,LayoutHeight),true,{colour1=BLACKA(153)});

menu.side.mainlabels = getElementEX(menu.side,anchorL,XYWH(0,menu.side.height/2 - 125,menu.side.width, 250),true,{colour1=BLACKA(0)}); --border_type=BORDER_TYPE_OUTER, border_colour=GREENA(50), border_size=1});


--menu.side.mainlabels.tutorials    = menu.side.mainlabels.add(0,loc(TID_Main_Menu_Tutorial),7);
--menu.side.mainlabels.achievs      = menu.side.mainlabels.add(1,loc(TID_ACHIEVEMENTS),8);
menu.side.mainlabels.play         = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 10, menu.side.mainlabels.width-20, 30), 'Play', '', 'mainmenuclick(%b,0);', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png'
                                    });

menu.side.mainlabels.campaign     = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 10, menu.side.mainlabels.width-20, 30), loc(TID_Main_Menu_Campaign), '', 'mainmenuclick(%b,10);', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png',
                                      visible=false
                                    });


menu.side.mainlabels.multiplayer  = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 50, menu.side.mainlabels.width-20, 30), loc(TID_Main_Menu_Multiplayer), '', 'mainmenuclick(%b,1);', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png',
                                      disabled=true
                                    });

menu.side.mainlabels.skirmish     = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 50, menu.side.mainlabels.width-20, 30), 'Skirmish', '', 'ShowCampWindow(5)', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png',
                                      visible=false,
                                      enabled=OW_skirmishcount() > 0
                                    });

menu.side.mainlabels.mods         = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 90, menu.side.mainlabels.width-20, 30), loc(TID_MODS), '', 'mainmenuclick(%b,2);', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png'
                                    });

menu.side.mainlabels.load         = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 90, menu.side.mainlabels.width-20, 30), loc(TID_Main_Menu_Campaign_Load), '', 'ShowCampWindow(3)', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png',
                                      visible=false
                                    });

menu.side.mainlabels.options      = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 130, menu.side.mainlabels.width-20, 30), loc(TID_Main_Menu_Options), '', 'mainmenuclick(%b,3);', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png'
                                    });

menu.side.mainlabels.back         = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 130, menu.side.mainlabels.width-20, 30), loc(TID_Main_Menu_Campaign_Back), '', 'mainmenuclick(%b,11);', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png',
                                      visible=false
                                    });

menu.side.mainlabels.credits      = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 170, menu.side.mainlabels.width-20, 30), loc(TID_Main_Menu_Extras_Credits), '', 'mainmenuclick(%b,4);', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png'
                                    });

menu.side.mainlabels.quit         = getImageButtonEX(menu.side.mainlabels, anchorLT, XYWH(10, 210, menu.side.mainlabels.width-20, 30), loc(TID_Main_Menu_Quit), '', 'mainmenuclick(%b,5);', SKINTYPE_NONE,
                                    {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png'
                                    });

--menu.side.mainlabels.add(0,loc(TID_Main_Menu_Campaign),0);
--menu.side.mainlabels.multiplayer  = menu.side.mainlabels.add(1,loc(TID_Main_Menu_Multiplayer),1);
--menu.side.mainlabels.mods         = menu.side.mainlabels.add(2,loc(TID_MODS),2);
--menu.side.mainlabels.options      = menu.side.mainlabels.add(3,loc(TID_Main_Menu_Options),3);
--menu.side.mainlabels.credits      = menu.side.mainlabels.add(4,loc(TID_Main_Menu_Extras_Credits),4);
--menu.side.mainlabels.quit         = menu.side.mainlabels.add(5,loc(TID_Main_Menu_Quit),5);

-- Init Steam window in mainmenu
function steam_init()
	steam_username = getLabelEX(profilebar,anchorLT,XYWH(10,0,profilebar.width-64-5,32),nil, string.sub(getvalue(OWV_STEAMUSERNAME), 0, 20),{nomouseevent=true});
        setFontName(steam_username, Neuropol);
        setFontScale(steam_username, 0.32);
        setFontColour(steam_username, GREEN());


        SteamInitialized = true;
end;

-- Steam Window
profilebar = getElementEX(menu,anchorLB,XYWH(0,LayoutHeight-110,270,110),true,
			  {--border_type=BORDER_TYPE_OUTER, border_colour=GREENA(50), border_size=1,
                           colour1=BLACKA(0)});

profile_avatar = getElementEX(profilebar,anchorL,XYWH(profilebar.width - 64, 0, 64, 64), true,
			      {texture='profile_select.png', callback_mouseclick='changeProfileAvatar()', bevel=true});

profile_label = getLabelEX(profilebar,anchorLT,XYWH(10,32,profilebar.width-64-5,32),nil,'default',{nomouseevent=true});
setFontName(profile_label, Neuropol);
setFontScale(profile_label, 0.32);
setFontColour(profile_label, GREEN())


profile_button = getImageButtonEX(profilebar,anchorLT,XYWH(10,64+10,menu.side.mainlabels.width-20,30), loc(TID_Main_Menu_Change_Player), '', 'mainmenuclick(%b,6);', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });
--

function showSteam(mode)
        setVisible(profilebar, mode);
end;

function showVersion(mode)
        setVisible(mod_version, mode);
        setVisible(version, mode);
end;

function show_menu(mode)
 	setVisible(menu.side.mainlabels.play, not mode);
        setVisible(menu.side.mainlabels.multiplayer, not mode);
        setVisible(menu.side.mainlabels.mods, not mode);
        setVisible(menu.side.mainlabels.options, not mode);
        setVisible(menu.side.mainlabels.credits, not mode);
        setVisible(menu.side.mainlabels.quit, not mode);

        setVisible(menu.side.mainlabels.campaign, mode);
        setVisible(menu.side.mainlabels.skirmish, mode);
        setVisible(menu.side.mainlabels.load, mode);
        setVisible(menu.side.mainlabels.back, mode);
end;


function mainmenuclick(button,id)
	if (button == 0) then
		--if id ~= 6 then

			setVisible(campaign,false);
			setVisible(modswindow,false);
			setVisible(options,false);
			setVisible(profile,false);
			--setVisible(profileAvatar,false);
			close_SteamAvatar();
			multiplayer_close();
			HideCredits();
			logoVisible(false);
			inProfileChange = false;
            tutorial_show(false);
			showAchievs(false);
		--else

			if CampOverride ~= -1 then
				--CampaignClick(0,4);
			end;
		--end;


		switch(id) : caseof {
			[0]   = function (x) show_menu(true); logoVisible(true); end,
			[1]   = function (x) multiplayer_show(); end,
			[2]   = function (x) mods_show(); end,
			[3]   = function (x) options_show(); logoVisible(true); end,
			[4]   = function (x) ShowCredits(); end,
			[5]   = function (x) exit(); end,
			[6]   = function (x) profile_show(); logoVisible(true); end,
			[7]   = function (x) tutorial_show(true);end,
			[8]   = function (x) showAchievs(true); end;
                        [10]  = function (x) campaign_show(); logoVisible(true); end;
                        [11]  = function (x) show_menu(false); logoVisible(true); end;
		}
	end;
end;
