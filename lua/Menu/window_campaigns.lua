---[CAMPAIGN MENU]--------------------------------------------------------------------------------------------------------------

campaign = getElementEX(menu,anchorLT,XYWH(LayoutWidth/2,250,746,312),false,
		       {texture='SGUI/Alien/menu/menu-background.png'});

campaign.us = getImageButtonEX(campaign, anchorLT, XYWH(25, 20, 200, 200), '', '', 'ShowCampWindow(0)', SKINTYPE_NONE,
              			{
                         		texture='SGUI/Alien/menu/menu-us.png',
                                        callback_mouseover='changeCampDescription(1)',
		                        callback_mouseleave='changeCampDescription(0)'
                                });

campaign.ru = getImageButtonEX(campaign, anchorLT, XYWH(25 + 245, 20, 200, 200), '', '', 'ShowCampWindow(2)', SKINTYPE_NONE,
              			{
                         		texture='SGUI/Alien/menu/menu-ru.png',
                                        callback_mouseover='changeCampDescription(2)',
		                        callback_mouseleave='changeCampDescription(0)'
                                });

campaign.ex = getImageButtonEX(campaign, anchorLT, XYWH(25 + 245 * 2, 20, 200, 200), '', '', 'ShowCampWindow(1)', SKINTYPE_NONE,
              			{
                         		texture='SGUI/Alien/menu/menu-ex.png',
                                        callback_mouseover='changeCampDescription(3)',
		                        callback_mouseleave='changeCampDescription(0)',
                                        disabled=true
                                });

campaign.description = getLabelEX(campaign, anchorLT, XYWH(18, 200, 700, 100), '', '',
                                  {
                                  	font_scale = 0.4,
                                        font_name = Neuropol,
                                        font_colour = WHITE(),
                                        wordwrap=true
                                  });

function changeCampDescription(ID)
	if (ID == 0) then
            setText(campaign.description, '');
        end;

        if (ID == 1) then
            setText(campaign.description, loc(504)); -- opis kampanii amerykañskiej w LangX.wri
        end;

        if (ID == 2) then
            setText(campaign.description, loc(520)); -- opis kampanii ru w LangX.wri
        end;

        if (ID == 3) then
            setText(campaign.description, ''); -- TODO
        end;
end;

---[CAMPAIGN WINDOW]------------------------------------------------------------------------------------------------------------

campaignwindow = getElementEX(menu,anchorLTRB,XYWH(0,0,LayoutWidth,LayoutHeight), false,{colour1=BLACKA(100), alpha=0});
campwindow     = getElementEX(campaignwindow,anchorLTRB,XYWH(0,0,campaignwindow.width,campaignwindow.height), false,
			{
                        });

campscrollbox  = getScrollboxEX(campwindow,anchorLTRB,XYWH(10,40,campwindow.width-20-200-14,campwindow.height-80-14),{colour1=BLACKA(0)});

campscrollbox_scrollV = getScrollBarEX(campwindow,anchorTRB,XYWH(campscrollbox.x+campscrollbox.width+1,campscrollbox.y,12,campscrollbox.height),
                                       'scrollbar.png',campscrollbox,{colour1=Scrollbar_Colour1,colour2=Scrollbar_Colour2,},{});
campscrollbox_scrollH = getScrollBarEX(campwindow,anchorLRB,XYWH(campscrollbox.x,campscrollbox.y+1+campscrollbox.height,campscrollbox.width,12),
                                       'scrollbar.png',campscrollbox,{colour1=Scrollbar_Colour1,colour2=Scrollbar_Colour2,},{vertical=false,});

---[CAMPAIGN WINDOW SIDEBAR]----------------------------------------------------------------------------------------------------
campdiffside = getElementEX(campwindow,anchorTRB,XYWH(campwindow.width-200,0,200,campwindow.height),true,{colour1=BLACKA(200)});

campdifftext = getLabelEX(campdiffside,anchorLTR,XYWH(10,10+60,campdiffside.width-20,300),Tahoma_14,
                          loc(TID_Main_Menu_Campaign_Hint1)..'\n\n'..loc(TID_Main_Menu_Campaign_Hint2)..'\n\n'..loc(TID_Main_Menu_Campaign_Hint3),
                          {wordwrap=true,font_colour=WHITE(),text_valign=ALIGN_TOP,});

camp_run_button = getImageButtonEX(campdiffside, anchorLRB, XYWH(20,campdiffside.height-120,campdiffside.width-40,20), '', '', 'OW_camprun();', SKINTYPE_NONE,
                                  {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png',
                                      visible=false
                                  });

--getButtonEX_Basic(campdiffside,anchorLRB,XYWH(20,campdiffside.height-50-25,campdiffside.width-40,20),SKINTYPE_NONE,'camp_delete_button.onClick()',
--               Button_Colour,Bevel_Highlight,Bevel_Shadow,{visible=false,text=loc(TID_Main_Menu_Campaign_American_Delete)});
camp_delete_button = getImageButtonEX(campdiffside, anchorLRB, XYWH(20,campdiffside.height-80,campdiffside.width-40,20), loc(TID_Main_Menu_Campaign_American_Delete), '', 'camp_delete_button.onClick()', SKINTYPE_NONE,
                                  {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png',
                                      enabled=false
                                  });

camp_back_button= getImageButtonEX(campdiffside, anchorLRB, XYWH(20,campdiffside.height-40,campdiffside.width-40,20), loc(TID_Main_Menu_Campaign_Back), '', 'BackToMenu();', SKINTYPE_NONE,
                                  {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png'
                                  });


campdiff_radio_container = getElementEX(campdiffside,anchorLR,
					XYWH(0,((campdiffside.height-50-20)-(campdifftext.y+campdifftext.height+10))/2+campdifftext.y+campdifftext.height+10-33,campdiffside.width,66)
					,true,{colour1=BLACKA(0)});

RG_diff = NewRadioGroup();

function camp_delete_button.onClick()
    if (campdiffside.currentCamp ~= '') and OW_CAMPDELETE() then
        OW_loadcampaign(campscrollbox.ID,campdiffside.currentCamp);
    end;
end;

function campdiff_addRadio(POS,CAPTION,TEXTURE,CHECKED,GROUP)
	return getRadioEX(campdiff_radio_container,anchorTR,XYWH(campdifftext.x,22*POS,20,20),CHECKED,GROUP,CAPTION,
                          {colour1=BLACKA(127),colour2=GRAY(150)},{texture2=TEXTURE,callback_checked='campdiff_radio_callback('..(POS+1)..',%value)'});
end;

campdiff_radio1 = campdiff_addRadio(0,loc(TID_Main_Menu_Campaign_American_Adventurer),'camp/am/tree/rectgreen.png',false,RG_diff);
campdiff_radio2 = campdiff_addRadio(1,loc(TID_Main_Menu_Campaign_American_Commander),'camp/am/tree/rectyellow.png',true,RG_diff);
campdiff_radio3 = campdiff_addRadio(2,loc(TID_Main_Menu_Campaign_American_Master_Strategist),'camp/am/tree/rectred.png',false,RG_diff);

---[CAMPAIGN LOAD SAVE WINDOW]--------------------------------------------------------------------------------------------------

loadwindow = getElementEX(campaignwindow,anchorLTRB,XYWH(0,0,campaignwindow.width,campaignwindow.height),false,{colour1=BLACKA(0)});


loadwindow.savelist               = loadsave.makeSaveList(loadwindow,XYWH(50,120,loadwindow.width-100-25,loadwindow.height-240-17),'loadwindow.savelist',false);
loadwindow.savelist.onDoubleClick = 'loadwindow.savelist.loadbutton.onClick()';
--loadwindow.savelist.loadbutton    = getButtonEX_Basic(loadwindow,anchorRB,XYWH(getX(loadwindow.savelist)+getWidth(loadwindow.savelist)-200,getY(loadwindow.savelist)+getHeight(loadwindow.savelist)+10,200,0),
--				    SKINTYPE_NONE,'loadwindow.savelist.loadbutton.onClick();',Button_Colour,Bevel_Highlight,Bevel_Shadow,
--                                    {text=loc(TID_InGame_LoadSave_Load),disabled=true,font_colour_disabled=GRAY(127),});--'Load',
loadwindow.savelist.loadbutton  = getImageButtonEX(loadwindow, anchorRB,XYWH(getX(loadwindow.savelist)+getWidth(loadwindow.savelist)-200,getY(loadwindow.savelist)+getHeight(loadwindow.savelist)+10,200,30), loc(TID_InGame_LoadSave_Load), '', 'loadwindow.savelist.loadbutton.onClick();',
					SKINTYPE_NONE,
                                  {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png'
                                  });

--loadwindow.savelist.deletebutton    = getButtonEX_Basic(loadwindow,anchorRB,XYWH(getX(loadwindow.savelist)+getWidth(loadwindow.savelist)-200-210,getY(loadwindow.savelist)+getHeight(loadwindow.savelist)+10,200,0),
--				    SKINTYPE_NONE,'loadwindow.savelist.deletebutton.onClick();',Button_Colour,Bevel_Highlight,Bevel_Shadow,
--                                    {text=loc(TID_InGame_LoadSave_Delete),disabled=true,font_colour_disabled=GRAY(127),});--'Load',
loadwindow.savelist.deletebutton= getImageButtonEX(loadwindow, anchorRB,XYWH(getX(loadwindow.savelist)+getWidth(loadwindow.savelist)-200-210,getY(loadwindow.savelist)+getHeight(loadwindow.savelist)+10,200,30), loc(TID_InGame_LoadSave_Delete), '', 'loadwindow.savelist.deletebutton.onClick();', SKINTYPE_NONE,
                                  {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png'
                                  });

loadwindow.savelist.back        = getImageButtonEX(loadwindow, anchorRB,XYWH(getX(loadwindow.savelist)+getWidth(loadwindow.savelist)-200-(210*2),getY(loadwindow.savelist)+getHeight(loadwindow.savelist)+10,200,30), loc(TID_Main_Menu_Campaign_Back), '', 'BackToMenu();', SKINTYPE_NONE,
                                  {
                                      font_colour=RGB(255,255,255),
                                      font_name=Neuropol,
                                      font_scale=0.4,
                                      texture='SGUI/Alien/button/button_round_left_big.png',
                                      texture2='SGUI/Alien/button/button_round_middle_big.png',
                                      texture3='SGUI/Alien/button/button_round_right_big.png'
                                  });

function HideCampWindows()
	setVisible(campwindow,false);
        setVisible(loadwindow,false);
        setVisible(skirmishwindow,false);
end;

LastCampWind = -1;

function ShowCampAndLoad(SID,SCROLLID,Camp)
	setVisible({ID=SID},true);
	sgui_scrollbox_xyreset(SCROLLID);
	OW_loadcampaign(SCROLLID,Camp);
end;

function BackToMenu()
	--AddEventFade(menu.side.ID,255,1,'setNoMouseEvent({ID=desktop},true);');
        AddEventFade(campaign.ID,0,0.1,'setVisible(campaignwindow,false);');
        AddEventFade(campaign.ID,255,0.1, 'setVisible(campaign, false); setVisible(menu.side, true); showVersion(true); showSteam(true);');
end;

function FROMOW_SET_CAMP_RUN_BUTTON_VIS(VALUE) -- Called by OW!
    setVisible(camp_run_button,VALUE);
    setEnabled(camp_delete_button,VALUE);
end;

function ShowCampWindow(ID)

        HideCampWindows();

        --AddEventFade(menu.side.ID,255,1,'setNoMouseEvent({ID=desktop},false);');
        AddEventFade(campaign.ID,0,0.1, 'setVisible(campaign, false); setVisible(menu.side, false); showVersion(false); showSteam(false);');
        AddEventFade(campaign.ID,255,0.1,'setVisible(campaignwindow,true); AddEventFade(campaignwindow.ID,255,0.25,"setNoMouseEvent({ID=desktop},false);");');

	if (ID == 0) then
		ShowCampAndLoad(campwindow.ID,campscrollbox.ID,'Am');
                setTexture(campwindow, 'SGUI/Alien/menu/camp-us-background.png');
	elseif (ID == 1) then
		ShowCampAndLoad(campwindow.ID,campscrollbox.ID,'Ar');
	elseif (ID == 2) then
		ShowCampAndLoad(campwindow.ID,campscrollbox.ID,'Ru');
	elseif (ID == 3) then
                setVisible(loadwindow,true);

                OW_SAVEGAME_GET();
	elseif (ID == 5) then
        	setVisible(skirmishwindow,true);
		SkirmishInit();
	end;

	LastCampWind = ID;
end;

function ShowHideCamp(ID,VISIBLE)
	if (ID == 0) then
        	setVisible(amgradient,VISIBLE);
	end;
	if (ID == 1) then
        	setVisible(argradient,VISIBLE);
	end;
	if (ID == 2) then
        	setVisible(rugradient,VISIBLE);
	end;
end;

function ShowCamp(ID) -- DEPRECATED
	ShowHideCamp(ID,true);
end;

function HideCamp(ID) -- DEPRECATED
	ShowHideCamp(ID,false);
end;

function CampaignOver(ID)
	if (CampOverride > -1) then
			ShowHideCamp(CampOverride,false);
	end;
	ShowHideCamp(ID,true);
end;

function CampaignLeave(ID)
	ShowHideCamp(ID,false);
	if (CampOverride > -1) then
			ShowHideCamp(CampOverride,true);
	end;
end;

function campdiff_radio_callback(DIFF,VALUE)
	if (VALUE) then
		OW_campdiff(DIFF);
	end;
end;

function FROMOW_SET_CAMP_DIFF(DIFF) -- Called by OW!
	setChecked(campdiff_radio1,false);
        setChecked(campdiff_radio2,false);
        setChecked(campdiff_radio3,false);

	if (DIFF == 1) then
        	setChecked(campdiff_radio1,true);
	end;
	if (DIFF == 2) then
		setChecked(campdiff_radio2,true);
	end;
	if (DIFF == 3) then
		setChecked(campdiff_radio3,true);
	end;
end;

function FROMOW_SET_CAMP_RUN_BUTTON(ID) -- Called by OW!
	setText(camp_run_button,loc(ID));
end;

function FROMOW_SET_CAMP_RUN_BUTTON_VIS(VALUE) -- Called by OW!
	setVisible(camp_run_button,VALUE);
end;

function FROMOW_CAMP_TREE_MAKE_TEXT(X,Y,TEXT) -- Called by OW!
	getLabelEX(campscrollbox,anchorLT,XYWH(X,Y,150,25),Neuropol,TEXT,
        	   {font_scale = 0.3, font_colour=RGB(163,230,170), colour1=BLACKA(0), nomouseevent=true, wordwrap=true,});
end;

function campaign_show()
	setVisible(campaign,true);
end;

function loadwindow.savelist.loadbutton.onClick()
	if loadwindow.savelist.SAVENAME ~= nil then
        	OW_SAVEGAME_LOAD(loadwindow.savelist.SAVENAME);
        end;
end;

function loadwindow.savelist.deletebutton.onClick()
	if loadwindow.savelist.DELETENAME ~= nil then
        	if OW_SAVEGAME_DELETE(loadwindow.savelist.DELETENAME) then
                	OW_SAVEGAME_GET();
                end;
        end;
end;

function backToMenu_Campaign()
	if (not isVisible(campaign)) then
		return;
	end;

	campaign_show();

	if isVisible(loadwindow) then
        	OW_SAVEGAME_GET();
	end;
	if isVisible(campwindow) then
		ShowCampWindow(LastCampWind);
	end;

	if isVisible(skirmishwindow) then
		SkirmishInit();
	end;
end;
