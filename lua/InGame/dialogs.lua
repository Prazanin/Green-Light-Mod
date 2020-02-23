dialog                  = {}
dialog.activeDialogs    = 0;
dialog.objectives       = {}

dialog.back             = getElementEX(nil,anchorLTRB,XYWH(0,0,LayoutWidth,LayoutHeight),false,{colour1=BLACKA(150),});

function OF_HideDialog(FORMID,ELEMENTSTR)
	OPENFORMLIST.add(FORMID,'HideDialog('..ELEMENTSTR..');');
end;


---[OBJECTIVES]-----------------------------------------------------------------------------------------------------------------

dialog.objectives       = getDialogEX(dialog.back,anchorNone,XYWH(LayoutWidth / 2 - 200,125,400,380),SKINTYPE_DIALOG1,{tile=true});
dialog.objectives.panel = getElementEX(dialog.objectives,anchorLTRB,XYWH(20,25,dialog.objectives.width-40,dialog.objectives.height-50-30-15),true,{colour1=BLACKA(0),});

dialog.objectives.ok    = getImageButtonEX(dialog.objectives,anchorB,XYWH(dialog.objectives.width/2-75,dialog.objectives.height-30-15,150,24),
                                           loc(TID_InGame_Mission_objectives_Continue),'',
                                           'HideDialog(dialog.objectives);OW_FORM_CLOSE(dialog.objectives.FORMID,TID_InGame_Mission_objectives_Continue);',SKINTYPE_BUTTON,{
                                           font_colour_disabled=GRAY(127),
                                           font_name=Tahoma_13B
                          });

dialog.objectives.exit  = getImageButtonEX(dialog.objectives,anchorB,XYWH(dialog.objectives.width/2+2,dialog.objectives.height-30-15,150,24),
                                           loc(TID_InGame_Mission_objectives_End_mission),'',
                                           'HideDialog(dialog.objectives);OW_FORM_CLOSE(dialog.objectives.FORMID,TID_InGame_Mission_objectives_End_mission);',SKINTYPE_BUTTON,{
                                           visible=false,
                                           font_colour_disabled=GRAY(127),
                                           font_name=Tahoma_13B
                          });

---[MENU]-----------------------------------------------------------------------------------------------------------------------

dialog.menu              = getDialogEX(dialog.back,anchorNone,XYWH(LayoutWidth / 2 - 150,125,300,380),SKINTYPE_DIALOG1,{tile=true});
dialog.menu.panel        = getElementEX(dialog.menu,anchorLTRB,XYWH(20,25,dialog.menu.width-40,dialog.menu.height-50),true,{colour1=BLACKA(0),});

---[GAME]-----------------------------------------------------------------------------------------------------------------------

dialog.game              = getDialogEX(dialog.back,anchorNone,XYWH(LayoutWidth / 2 - 200,125,400,380),SKINTYPE_DIALOG1,{tile=true});
dialog.game.panel        = getElementEX(dialog.game,anchorLTRB,XYWH(20,20,getWidth(dialog.game)-40,getHeight(dialog.game)-40),true,
                                        {colour1=BLACKA(0),});

---[LOAD/SAVE]------------------------------------------------------------------------------------------------------------------
dialog.load                        = getDialogEX(dialog.back,anchorNone,XYWH(LayoutWidth / 2 - 450,125,760,380),SKINTYPE_DIALOG1,{tile=true});
dialog.load.caption                = getLabelEX(dialog.load,anchorLTR,XYWH(0,20,dialog.load.width,20),Trebuchet_20,loc(TID_InGame_File_menu_Load_game),
                                      {wordwrap=true,nomouseevent=true,text_halign=ALIGN_MIDDLE,});

dialog.load.savelist               = loadsave.makeSaveList(dialog.load,XYWH(22,50,700,270),'dialog.load.savelist',false);
dialog.load.savelist.onDoubleClick = 'dialog.load.savelist.loadbutton.onClick()';
dialog.load.savelist.loadbutton    = getImageButtonEX(dialog.load,anchorB,XYWH(335,330,140,24),
                                            loc(TID_msg_Ok),'','dialog.load.savelist.loadbutton.onClick()',SKINTYPE_BUTTON,{font_colour_disabled=GRAY(127),});

dialog.load.savelist.deletebutton    = getImageButtonEX(dialog.load,anchorB,XYWH(190,330,140,24),
                                            loc(TID_InGame_LoadSave_Delete),'','dialog.load.savelist.deletebutton.onClick()',SKINTYPE_BUTTON,{font_colour_disabled=GRAY(127),});

dialog.load.back                   = getImageButtonEX(dialog.load,anchorB,XYWH(25,dialog.load.savelist.loadbutton.y,140,24),
                                            loc(TID_InGame_LoadSave_Back),'','dialog.load.close()',SKINTYPE_BUTTON,{font_colour_disabled=GRAY(127),});

dialog.save                        = getDialogEX(dialog.back,anchorNone,XYWH(LayoutWidth / 2 - 450,125,760,380),SKINTYPE_DIALOG1,{tile=true});
dialog.save.caption                = getLabelEX(dialog.save,anchorLTR,XYWH(0,20,dialog.save.width,20),Trebuchet_20,loc(TID_InGame_File_menu_Save_game),
                                      {wordwrap=true,nomouseevent=true,text_halign=ALIGN_MIDDLE,});

dialog.save.savelist               = loadsave.makeSaveList(dialog.save,XYWH(22,50,700,270),'dialog.save.savelist',true);
dialog.save.savelist.onDoubleClick = 'dialog.save.savelist.loadbutton.onClick()';
dialog.save.savelist.loadbutton    = getImageButtonEX(dialog.save,anchorB,XYWH(335,330,140,24),
                                            loc(TID_msg_Ok),'','dialog.save.savelist.loadbutton.onClick()',SKINTYPE_BUTTON,{font_colour_disabled=GRAY(127),});

dialog.save.savelist.deletebutton    = getImageButtonEX(dialog.save,anchorB,XYWH(180,330,140,24),
                                            loc(TID_InGame_LoadSave_Delete),'','dialog.save.savelist.deletebutton.onClick()',SKINTYPE_BUTTON,{font_colour_disabled=GRAY(127),});

dialog.save.back                   = getImageButtonEX(dialog.save,anchorB,XYWH(25,dialog.save.savelist.loadbutton.y,140,24),
                                            loc(TID_InGame_LoadSave_Back),'','dialog.save.close()',SKINTYPE_BUTTON,{font_colour_disabled=GRAY(127),});


dialog.savename                    = getDialogEX(dialog.back,anchorNone,XYWH(LayoutWidth / 2 - 170,125,340,130),SKINTYPE_DIALOG1,{tile=true});
dialog.savename.PREFIX             = '';
dialog.savename.edit               = getEditEX(dialog.savename,anchorLT,XYWH(20,42,300,20),Tahoma_13,'','',COLOURS_DIALOG_EDIT,{callback_keypress='dialog.savename.edit.onKeyPressed(%k);'});

dialog.savename.ok                 = getImageButtonEX(dialog.savename,anchorB,XYWH(180,80,140,24),
                                            loc(TID_msg_Ok),'','dialog.savename.ok.onClick()',SKINTYPE_BUTTON,{font_colour_disabled=GRAY(127),});

dialog.savename.back               = getImageButtonEX(dialog.savename,anchorB,XYWH(25,dialog.savename.ok.y,140,24),
                                            loc(TID_msg_Cancel),'','dialog.savename.close()',SKINTYPE_BUTTON,{font_colour_disabled=GRAY(127),});

-- [LOAD/SAVE] CALLBACKS --

function dialog.load.close()
	HideDialog(dialog.load);
        OW_FORM_CLOSE(dialog.load.FORMID,TID_msg_Ok);
end;

function dialog.load.savelist.loadbutton.onClick()
	if dialog.load.savelist.SAVENAME ~= nil then
        	dialog.load.close();
        	OW_SAVEGAME_LOAD(dialog.load.savelist.SAVENAME);
        end;
end;

function dialog.load.savelist.deletebutton.onClick()
	if dialog.load.savelist.DELETENAME ~= nil then
        	if OW_SAVEGAME_DELETE(dialog.load.savelist.DELETENAME) then
                	OW_SAVEGAME_GET();
                end;
        end;
end;

function dialog.save.savelist.deletebutton.onClick()
	if dialog.save.savelist.DELETENAME ~= nil then
        	if OW_SAVEGAME_DELETE(dialog.save.savelist.DELETENAME) then
                	OW_SAVEGAME_GET();
                end;
        end;
end;

function dialog.save.close()
	HideDialog(dialog.save);
        OW_FORM_CLOSE(dialog.save.FORMID,TID_msg_Ok);
end;

function dialog.save.savelist.loadbutton.onClick()
	if dialog.save.savelist.SAVENAME ~= nil then
        	if dialog.save.savelist.SAVENAME == '' then
	                dialog.savename.PREFIX = OW_SAVEGAME_PREFIX();
                	setText(dialog.savename.edit,'');
                        setEnabled(dialog.save,false);
                        setEnabled(dialog.savename.ok,false);
                	ShowDialog(dialog.savename);
                        setFocus(dialog.savename.edit);
                	return;
                end;

        	if (OW_SAVEGAME_SAVE(dialog.save.savelist.SAVENAME)) then
                	dialog.save.close();
                end;
        end;
end;

function dialog.savename.saveExists(NAME)
	local sn = string.upper(dialog.savename.PREFIX..''..NAME..'.OWP');
        local SAVELIST = dialog.save.savelist;

        for i in ipairs(SAVELIST.DATA) do
        	if (string.upper(SAVELIST.DATA[i].SAVENAME) == sn) then
                	return true;
                end;
	end;

        return false;
end;

function dialog.savename.edit.onKeyPressed(KEY)
	local et = getText(dialog.savename.edit);
        setEnabled(dialog.savename.ok,(et ~= '') and (not dialog.savename.saveExists(getText(dialog.savename.edit))));

        if KEY == 13 then
        	dialog.savename.ok.onClick();
        elseif KEY == 27 then
        	dialog.savename.close();
        end;
end;

function dialog.savename.ok.onClick()
	dialog.save.savelist.SAVENAME = getText(dialog.savename.edit);
        dialog.savename.close();
        dialog.save.savelist.loadbutton.onClick();
end;

function dialog.savename.close()
	clearFocus();
	HideDialog(dialog.savename);
        setEnabled(dialog.save,true);
end;

---[MEDALS]---------------------------------------------------------------------------------------------------------------------

dialog.medals         = getDialogEX(dialog.back,anchorNone,XYWH(LayoutWidth / 2 - 200,100,341,420),SKINTYPE_DIALOG2,{tile=true});

dialog.medals.victory = getLabelEX(dialog.medals,anchorLTR,XYWH(40,18,dialog.medals.width-80,39),Trebuchet_20,loc(TID_InGame_Victory),
                                   {wordwrap=true,nomouseevent=true,font_colour=RGB(128,6,18),text_halign=ALIGN_MIDDLE,});

dialog.medals.pad     = getElementEX(dialog.medals,anchorLTR,XYWH(10,85,320,240),true,{texture='SGUI/Amer/pad.png',});

dialog.medals.hint    = getLabelEX(dialog.medals,anchorLRB,XYWH(40,324,dialog.medals.width-80,50),Tahoma_13,'',
                                   {wordwrap=true,nomouseevent=true,font_colour=RGB(221,224,211),text_halign=ALIGN_MIDDLE,});

dialog.medals.ok      = getImageButtonEX(dialog.medals,anchorB,XYWH(dialog.medals.width/2-150/2,370,150,24),
                                         loc(TID_msg_Ok),'',
                                         'HideDialog(dialog.medals);OW_FORM_CLOSE(dialog.medals.FORMID,TID_msg_Ok);',SKINTYPE_BUTTON,{font_colour_disabled=GRAY(127),});

dialog.medals.pad.m = {};

function MakeMedal(I,X,Y,W,H)
        dialog.medals.pad.m[I] = getImageEX_Loop(dialog.medals.pad,anchorLT,XYWH(X,Y,W,H),'SGUI/Amer/m'..I..'.png',
                                                 {callback_mousemove='MedalMouseMove('..I..')',callback_animend='MedalAnim()',});
	--dialog.medals.pad.m[I] = MakeLoopImageElement(dialog.medals.pad,anchorLT,X,Y,W,H,'SGUI/Amer/m'..I..'.png');
	--set_Callback(dialog.medals.pad.m[I].ID,CALLBACK_MOUSEMOVE,'MedalMouseMove('..I..')');
	--set_Callback(dialog.medals.pad.m[I].ID,CALLBACK_ANIMEND,'MedalAnim()');
end;

MakeMedal(1,0,0,115,240);
MakeMedal(2,115,0,85,240);
MakeMedal(3,200,0,120,240);
MakeMedal(4,110,170,100,70);

Mz = {};
Mz[1] = 'Effects/medaile/medL.wav';
Mz[2] = 'Effects/medaile/medS.wav';
Mz[3] = 'Effects/medaile/medP.wav';
Mz[4] = 'Effects/medaile/medD.wav';
Ms = {};
for i = 1,4 do
	Ms[i] = -1;
end;

function MedalAnim()
	dialog.medals.cur = dialog.medals.cur + 1;
	if dialog.medals.cur > 4 then
		setVisible(dialog.medals.ok,true);
	else
		if dialog.medals.earned[dialog.medals.cur] then
			set_Property(dialog.medals.pad.m[dialog.medals.cur].ID,PROP_ANIM_PLAY,true);
			setText(dialog.medals.hint,dialog.medals.text[dialog.medals.cur]);
                        OW_OAL_PLAY(Ms[dialog.medals.cur]);
		else
			MedalAnim()
		end;
	end;
end;

function MedalMouseMove(I)
	setText(dialog.medals.hint,dialog.medals.text[I]);
end;

function MedalReset(I)
	set_Property(dialog.medals.pad.m[I].ID,PROP_ANIM_PLAY,true);
	set_Property(dialog.medals.pad.m[I].ID,PROP_ANIM_PLAY,false);
end;

function FROMOW_LOADSAVE(DATA)
	OW_SAVEGAME_GET();
	local ls = nil;
	local lsstr = nil;

	if DATA.LOAD then
		ls = dialog.load;
		lsstr = 'dialog.load';
	else
		ls = dialog.save;
		lsstr = 'dialog.save';
	end;

	ls.FORMID = DATA.FORMID;
	ls.LOAD   = DATA.LOAD;
	ShowDialog(ls);
	OF_HideDialog(ls.FORMID,lsstr);
end;

function FROMOW_MEDALS_SHOW(DATA) -- OW CALLS THIS!

	for i = 1,4 do
        	if tonumber(Ms[i]) > -1 then
                	OW_OAL_FREE(Ms[i]);
                end;
		Ms[i] = OW_OAL_LOAD(Mz[i]);
	end;

        dialog.medals.FORMID = DATA.FORMID;
	dialog.medals.text   = DATA.MR.text;
	dialog.medals.earned = DATA.MR.earned;
	dialog.medals.cur    = 0;
	setVisible(dialog.medals.ok,false);
	MedalReset(1);
	MedalReset(2);
	MedalReset(3);
	MedalReset(4);
	setText(dialog.medals.hint,'');
	MedalAnim();
	ShowDialog(dialog.medals);
	OF_HideDialog(dialog.medals.FORMID,'dialog.medals');
end;

function FROMOW_MISSIONOBJECTIVES_SHOW(DATA) -- OW CALLS THIS!
--[[
DATA BREAKDOWN
  LIST   Array [1..COUNT] of
      NAME    String
      COLOUR  Colour
      ST      Boolean (Strike Through)
      MODE    Number  (0 = unknown, 1 = type (Main, Secondary, Optional), 2 = new, 3 = old, 4 = strikethrough)
  COUNT     Number
  FORMID    Number
  ALLOW_END Boolean
--]]

        dialog.objectives.FORMID = DATA.FORMID;
        if DATA.ALLOW_END then
                setX(dialog.objectives.ok,getWidth(dialog.objectives)/2-152);
        else
                setX(dialog.objectives.ok,getWidth(dialog.objectives)/2-75);
        end;

        setX(dialog.objectives.exit,getWidth(dialog.objectives)/2+2);
        setVisible(dialog.objectives.exit,DATA.ALLOW_END);

        sgui_deletechildren(dialog.objectives.panel.ID);

        local h = 0;
        local b = nil;
        local mh = getHeight(dialog.objectives)-getHeight(dialog.objectives.panel);

        for i=1,DATA.COUNT do
        	b = getLabelEX(dialog.objectives.panel,anchorLTR,XYWH(0,h,0,0),Tahoma_13B,
                               DATA.LIST[i].NAME,{font_colour=DATA.LIST[i].COLOUR,wordwrap=true,autosize=true,automaxwidth=getWidth(dialog.objectives.panel)});
                setStrikeThrough(b,DATA.LIST[i].ST);
                sgui_autosizecheck(b.ID);
                if DATA.LIST[i].MODE == 1 then
                        setY(b,h+3);
			h = h + getHeight(b) + 4;
                else
                        h = h + getHeight(b) + 0;
                end;
        end;

        setHeight(dialog.objectives,mh+h);

	ShowDialog(dialog.objectives);

	OF_HideDialog(dialog.objectives.FORMID,'dialog.objectives');
end;

function FROMOW_SHOW_INGAME_MENU(DATA)
        dialog.menu.FORMID=DATA.FORMID;

        sgui_deletechildren(dialog.menu.panel.ID);

        local h = 0;
        local b = nil;
        local mh = getHeight(dialog.menu)-getHeight(dialog.menu.panel);

        for i=1,DATA.COUNT do
		b = getImageButtonEX(dialog.menu.panel,anchorLTR,XYWH(0,h,getWidth(dialog.menu.panel),24),loc(DATA.BUTTONS[i]),'','HideDialog(dialog.menu);OW_FORM_CLOSE(dialog.menu.FORMID,'..(DATA.BUTTONS[i])..');',SKINTYPE_BUTTON,{});
                UpdateDialogButton(b,interface.current.dialog.button);
		h = h + getHeight(b) + 4; -- In future this will be useful when buttons can do auto width word wrap
        end;

        setHeight(dialog.menu,mh+h);
--        setHeight(dialog.menu.panel,h);
        ShowDialog(dialog.menu);
		OF_HideDialog(dialog.menu.FORMID,'dialog.menu');
end;

function FROMOW_SHOW_GAMEDIALOG(DATA) -- OW CALLS THIS!
	dialog.game.FORMID=DATA.FORMID;

	sgui_deletechildren(dialog.game.panel.ID);

	local b = nil;
        local list = {};

	local h = 10;
        local w = 360-20;
	local mh = getHeight(dialog.game)-getHeight(dialog.game.panel);
        local mw = getWidth(dialog.game)-getWidth(dialog.game.panel);

	for i=1,DATA.COUNT do
		b = getImageButtonEX(dialog.game.panel,anchorLT,XYWH(0,h,0,24),DATA.LIST[i],'','HideDialog(dialog.game);OW_FORM_CLOSE(dialog.game.FORMID,'..(i)..');',SKINTYPE_BUTTON,{autosize=true});
                UpdateDialogButton(b,interface.current.dialog.button);
                sgui_autosizecheck(b.ID);

                if getWidth(b) > w then
                	w = getWidth(b);
                end;

		h = h + getHeight(b) + 4;

                list[i] = b;
	end;

        w = w + 20;

        setWidth(dialog.game,mw+w);

        local lab = getLabelEX(dialog.game.panel,anchorLT,XYWH(0,0,0,0),Tahoma_16, DATA.QUESTION,{wordwrap=true,autosize=true,automaxwidth=w});
        sgui_autosizecheck(lab.ID);

        h = h + getHeight(lab);

        for i=1,DATA.COUNT do
        	setWidth(list[i],w);
                setY(list[i],getY(list[i]) + getHeight(lab));
        end;

	setHeight(dialog.game,mh+h);
	ShowDialog(dialog.game);
	OF_HideDialog(dialog.game.FORMID,'dialog.game');
end;

function FROMOW_HIDE_GAMEDIALOG() -- OW CALLS THIS!
 HideDialog(dialog.game);
end;

--OW_DIALOG_OBJ_SETUP(dialog.objectives.ID,dialog.objectives.panel.ID);
--OW_DIALOG_MENU_SETUP(dialog.menu.ID,dialog.menu.panel.ID);
--OW_DIALOG_GAME_SETUP(dialog.game.ID,dialog.game.panel.ID,dialog.game.label.ID);

function DoInterfaceChange_Dialog(Layout)
        setTexture(dialog.medals.pad,Layout.dialog.pad.texture);
	--set_Property(dialog.medals.pad.ID,PROP_TEXTURE,Layout.dialog.pad.texture);
	setXYWH(dialog.medals.pad,Layout.dialog.pad.d);

        if Layout.dialog.pad.colour1 ~= nil then
        	setColour1(dialog.medals.pad,Layout.dialog.pad.colour1);
        else
        	setColour1(dialog.medals.pad,WHITE());
        end;

        setHeight(dialog.medals,Layout.dialog.pad.height);

	for I = 1, 4 do
                setTexture(dialog.medals.pad.m[I],Layout.dialog.medal..I..'.png');
		--set_Property(dialog.medals.pad.m[I].ID,PROP_TEXTURE,Layout.dialog.medal..I..'.png');
		setXYWH(dialog.medals.pad.m[I],Layout.dialog.medals[I]);
	end;

	sgui_forcetextures(dialog.back.ID);
end;

OPENFORMLIST = {LIST={},COUNT=0};

function FROMOW_CLOSEFORM(FORMID)
	OPENFORMLIST.delete(FORMID,true);
end;

function FROMOW_CLOSEFORM_NORMAL()
	OPENFORMLIST.delete(FORMID,false);
end;

function OPENFORMLIST.add(FORMID,CALLBACK)
	OPENFORMLIST.COUNT                    = OPENFORMLIST.COUNT+1;
	OPENFORMLIST.LIST[OPENFORMLIST.COUNT] = {FID=FORMID,C=CALLBACK};
end;

function OPENFORMLIST.delete(FORMID,RUNCALLBACK)
	for i = 1,OPENFORMLIST.COUNT do
		if OPENFORMLIST.LIST[i] ~= nil then
			if OPENFORMLIST.LIST[i].FID == FORMID then
				if RUNCALLBACK then
					runstring(OPENFORMLIST.LIST[i].C);
				end;
				OPENFORMLIST.LIST[i] = nil;
				while OPENFORMLIST.LIST[OPENFORMLIST.COUNT] == nil do
					OPENFORMLIST.COUNT = OPENFORMLIST.COUNT - 1;
					if OPENFORMLIST.COUNT == 0 then
						return;
					end;
				end;
				return;
			end;
		end;
	end;
end;
