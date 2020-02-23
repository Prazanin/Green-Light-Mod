-----------------------------------------------------------------------------
---  Orig. File : /lua/window_skirmish.lua
---  Version    : 4
---
---  Summary    : Skirmish Management.
---
---  Created    : Stuart 'Stucuk' Carey, OW Support
---               Petr 'Sali' Salak, Freya Group
------------------------------------------------------------------------------

--skirmishwindow = AddElement({
--	type=TYPE_ELEMENT,
--	parent=campaignwindow,
--	anchor={top=true,bottom=true,left=true,right=true},
--	visible=false,
--	x=0,
--	y=0,
--	width=campaignwindow.width,
--	height=campaignwindow.height,
--	colour1={red=0,green=0,blue=0,alpha=0},
--});

skirmishwindow = getWindowEX(campaignwindow,LRTB,XYWH(0, 0, ScrWidth, ScrHeight),false, '',
          	      WINDOW_BACKGROUND_GL,
                      ({
                	title_colour=BLACK(255),
                        title_border_colour=BLACK(255),
                        colour1=BLACKA(0),
                        border_type=BORDER_TYPE_OUTER,
                        border_colour=GREENA(70),
                        border_size=1,
                        title_font_name=Neuropol,
                        visible=false
                      }));

skirmishscrollbox = AddElement({
	type=TYPE_SCROLLBOX,
	parent=skirmishwindow,
	anchor={top=true,bottom=true,left=true,right=true},
	x=20,
	y=60,
	width=skirmishwindow.width-40-13,
	height=skirmishwindow.height-40-40,
	colour1={red=0,green=0,blue=0,alpha=127},
	bevel=true,
});

skirmishscrollbox_scrollV = AddElement({
	type=TYPE_SCROLLBAR,
	parent=skirmishwindow,
	anchor={top=true,bottom=true,left=false,right=true},
	x=skirmishscrollbox.x+skirmishscrollbox.width+1,
	y=skirmishscrollbox.y,
	width=12,
	height=skirmishscrollbox.height,
	colour1=Scrollbar_Colour1,
	colour2=Scrollbar_Colour2,
	texture2="scrollbar.png",
});

sgui_set(skirmishscrollbox.ID,PROP_SCROLLBAR,skirmishscrollbox_scrollV.ID);

--skirmish_options = AddElement(merge({
--	type=TYPE_SCROLLBOX,
--	parent=skirmishwindow,
--	anchor={top=true,bottom=true,left=true,right=true},
--	x=skirmishscrollbox.x,
--	y=skirmishscrollbox.y,
--	width=skirmishscrollbox.width,
--	height=skirmishscrollbox.height,
--	visible=false,
--},Window_Back));

skirmish_options = getWindowEX(skirmishwindow,LRTB,XYWH(skirmishscrollbox.x, skirmishscrollbox.y, skirmishscrollbox.width, skirmishscrollbox.height),false, '',
          	      WINDOW_BACKGROUND_GL,
                      ({
                        type=TYPE_SCROLLBOX,
                	title_colour=BLACK(255),
                        title_border_colour=BLACK(255),
                        colour1=BLACKA(0),
                        border_type=BORDER_TYPE_OUTER,
                        border_colour=GREENA(70),
                        border_size=1,
                        title_font_name=Neuropol,
                        visible=false
                      }));

skirmish_preview = AddElement({
	type=TYPE_ELEMENT,
	parent=skirmish_options,
	anchor={top=true,bottom=false,left=true,right=false},
	x=10,
	y=10,
	width=250,
	height=165,
	colour1={red=255,green=255,blue=255,alpha=200},
	bevel=true,
	texture_fallback='skirmish_unknown.png',
});

skirmish_title = AddElement({
	type=TYPE_LABEL,
	parent=skirmish_options,
	anchor={top=true,bottom=false,left=true,right=true},
	x=skirmish_preview.x+skirmish_preview.width+10,
	y=skirmish_preview.y,
	width=skirmish_options.width-((skirmish_preview.x*2)+skirmish_preview.width),
	height=50,
	text='',
	wordwrap=true,
	nomouseevent=true,
	text_halign=ALIGN_LEFT,
	font_colour={red=255,green=255,blue=255,alpha=255},
        font_name=Neuropol,
        font_scale=0.5
});

skirmish_desc = AddElement({
	type=TYPE_LABEL,
	parent=skirmish_options,
	anchor={top=true,bottom=false,left=true,right=true},
	x=skirmish_preview.x+skirmish_preview.width+10,
	y=skirmish_preview.y+50,
	width=skirmish_options.width-((skirmish_preview.x*2)+skirmish_preview.width),
	height=skirmish_preview.height-50,
	text='',
	wordwrap=true,
	nomouseevent=true,
	text_halign=ALIGN_LEFT,
	font_colour={red=255,green=255,blue=255,alpha=255},
	font_name=Tahoma_14,
});

skirmish_options_scrollbox = AddElement({
	type=TYPE_SCROLLBOX,
	parent=skirmish_options,
	anchor={top=true,bottom=true,left=true,right=true},
	x=20,
	y=skirmish_preview.y+skirmish_preview.height+20,
	width=skirmish_options.width-40-13,
	height=skirmish_options.height-(skirmish_preview.y+skirmish_preview.height+20)-20-40,
	colour1={red=0,green=0,blue=0,alpha=127},
	bevel=true,
});

skirmish_options_scrollbox_scrollV = AddElement({
	type=TYPE_SCROLLBAR,
	parent=skirmish_options,
	anchor={top=true,bottom=true,left=false,right=true},
	x=skirmish_options_scrollbox.x+skirmish_options_scrollbox.width+1,
	y=skirmish_options_scrollbox.y,
	width=12,
	height=skirmish_options_scrollbox.height,
	colour1=Scrollbar_Colour1,
	colour2=Scrollbar_Colour2,
	texture2="scrollbar.png",
});

sgui_set(skirmish_options_scrollbox.ID,PROP_SCROLLBAR,skirmish_options_scrollbox_scrollV.ID);

skirmish_options_element = AddElement({
	type=TYPE_ELEMENT,
	parent=skirmish_options_scrollbox,
	anchor={top=true,bottom=false,left=true,right=true},
	x=0,
	y=0,
	width=skirmish_options_scrollbox.width,
	height=10,
	colour1={red=0,green=0,blue=0,alpha=0},
});

--skirmish_run_button = makeButton({
--	parent=skirmish_options,
--	anchor={top=false,bottom=true,left=true,right=true},
--	x=skirmish_options.width/2-100,
--	y=skirmish_options.height-40,
--	width=200,
--	height=20,
--	text='Run Skirmish',
--	callback_mouseclick='skirmish_run();',
--},Button_Colour,Bevel_Highlight,Bevel_Shadow);

skirmish_backToMenu_button = getImageButtonEX(skirmish_options,anchorBLR,XYWH(skirmish_options.width/2-310,skirmish_options.height-40,200, 20), 'Back to Menu', '', 'BackToMenu()', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });

skirmish_back_button = getImageButtonEX(skirmish_options,anchorBLR,XYWH(skirmish_options.width/2-100,skirmish_options.height-40,200, 20), 'Change Map', '', 'SkirmishInit()', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });

skirmish_run_button = getImageButtonEX(skirmish_options,anchorBLR,XYWH(skirmish_options.width/2+110,skirmish_options.height-40,200, 20), 'Run Skirmish', '', 'skirmish_run();', SKINTYPE_NONE,
                                 {
                                   font_colour=RGB(255,255,255),
                                   font_name=Neuropol,
                                   font_scale=0.4,
                                   texture='SGUI/Alien/button/button_round_left_big.png',
                                   texture2='SGUI/Alien/button/button_round_middle_big.png',
                                   texture3='SGUI/Alien/button/button_round_right_big.png'
                                 });

function SkirmishInit()
	SkirmishList={};
	sgui_scrollbox_xyreset(skirmishscrollbox.ID);
	OW_skirmishlist(skirmishscrollbox.ID);
	setVisible(skirmishscrollbox,true);
	setVisible(skirmish_options,false);
end;

rowcolour1={red=100,green=100,blue=100,alpha=127};
rowcolour2={red=50,green=50,blue=50,alpha=127};
colourhover={red=150,green=200,blue=150,alpha=200};

fcolourover={red=255,green=255,blue=255,alpha=255};
fcolourleave={red=150,green=200,blue=150,alpha=255};

SkirmishList={};

function FROMOW_SKIRMISH_LISTBOX_ADD(INFO,Index) -- Called by OW!
	SkirmishList[Index+1] = INFO;

	local mcolourhover={red=150,green=200,blue=150,alpha=255};
	local colour={red=255,green=255,blue=255,alpha=255};
--[[
	if odd(Index) then
		colour=rowcolour1;
	else
		colour=rowcolour2;
	end;

	Row = AddElement({
		type=TYPE_ELEMENT,
		parent=skirmishscrollbox,
		anchor={top=true,bottom=false,left=true,right=true},
		x=0,
		y=Index*165,
		width=getWidth(skirmishscrollbox), -- Since we get this at runtime after the resolution has changed, we need to get the current width
		height=165,
		colour1=colour,
		callback_mouseclick='skirmish_map_select('..Index..')',
	});

	AddElement({
		type=TYPE_ELEMENT,
		parent=Row,
		anchor={top=true,bottom=false,left=true,right=false},
		x=0,
		y=0,
		width=250,
		height=165,
		colour1={red=255,green=255,blue=255,alpha=200},
		texture='%missions%/_skirmish/'..INFO.map..'/mappic.png',
		texture_fallback='skirmish_unknown.png',
		nomouseevent=true,
	});

	Label = AddElement({
		type=TYPE_LABEL,
		parent=Row,
		anchor={top=true,bottom=false,left=true,right=true},
		x=250,
		y=0,
		width=Row.width-250,
		height=165,
		colour1={red=0,green=0,blue=0,alpha=0},
		text=INFO.title,
		nomouseevent=true,
		wordwrap=true,
		font_colour={red=150,green=200,blue=150,alpha=255},
	});

	set_Callback(Row.ID,CALLBACK_MOUSEOVER,'setColour1ID('..Row.ID..','..colourToString(colourhover)..');setFontColourID('..Label.ID..','..colourToString(fcolourover)..');');
	set_Callback(Row.ID,CALLBACK_MOUSELEAVE,'setColour1ID('..Row.ID..','..colourToString(colour)..');setFontColourID('..Label.ID..','..colourToString(fcolourleave)..');');
	--]]

	local ms=1
	if ScrWidth	>=	(2650) then
		ms = ScrWidth/2650;  --modifed size
	end;
	local w = getWidth(skirmishscrollbox)-10*ms;
	local countW = div(w,((605+212)*ms));

	local shiftX = (w - countW * ((605+212)*ms) )/ 2

	local x = mod(Index,countW);
	local y = div(Index,countW);

	local Row = getElementEX(
				skirmishscrollbox,
				anchorTL,
				XYWH(
					x*((605+212)*ms)+5*ms+shiftX,
					y*(145*ms)+10*ms,
					(600+213)*ms,
					140*ms
				),
				true,
				{
					colour1=WHITEA(0),
					callback_mouseclick='skirmish_map_select('..Index..')',
				}
	);

	Row.Mapbar = getElementEX(
				Row,
				anchorTL,
				XYWH(
					212*ms,
					0,
					(600)*ms,
					140*ms
				),
				true,
				{
					colour1=WHITEA(255),
					texture='%missions%/_skirmish/'..INFO.map..'/mapbar.png',
					texture_fallback='SGUI/Alien/mod_unknown.png',
					nomouseeventthis = true,

				}
	);

	Row.Mappic = getElementEX(
			Row,
			anchorTL,
			XYWH(
				0,
				2*ms,
				212*ms,
				136*ms
			),
			true,
			{
				colour1=WHITEA(255),
				texture='%missions%/_skirmish/'..INFO.map..'/mappic.png',
				texture_fallback='skirmish_unknown.png',
				nomouseevent = true,

			}
	);

	Row.Name = getLabelEX(
		Row.Mapbar,
		anchorLT,
		XYWH(
			5*ms,
			5*ms,
			590*ms,
			30*ms
		),
		Tahoma_20B,
		INFO.title,
		{
			nomouseevent=true,
			font_style_outline=true,

	});
--[[
Row.DescScrollBox = AddElement({
	type=TYPE_SCROLLBOX,
	parent=Row.Mapbar,
	anchor={top=true,bottom=true,left=true,right=true},
	x=5*ms,
	y=(5+35)*ms,
	width=590*ms-13,
	height=95*ms,
	colour1={red=0,green=0,blue=0,alpha=0},
	--bevel=true,
	nomouseevent=true,
});--]]

--[[
	Row.Desc = getTextboxEX(
		Row.DescScrollBox,
		anchorLT,
		XYWH(
			0,
			0,
			590*ms,
			0
		),
		Tahoma_20B,
		INFO.desc,
		{
			nomouseevent=true,
			wordwrap=true,

	});
	--]]

	Row.Desc = AddElement({
		type=TYPE_TEXTBOX,
		parent=Row.Mapbar,
		x=0,
		y=(5+35) * ms,
		width=590*ms-5,
		height=95*ms,
		text=INFO.desc;
		--nomouseevent=true,
		wordwrap=true,
		text_halign=ALIGN_LEFT,
		font_name=Tahoma_14B,
		font_colour=WHITEA(255),
		font_style_outline=true,
                callback_mouseclick='skirmish_map_select('..Index..')',
	});

	Row.DescScrollBox_scrollV = AddElement({
		type=TYPE_SCROLLBAR,
		parent=Row,
		anchor={top=true,bottom=true,left=false,right=true},
		x=Row.Mapbar.x+Row.Desc.x+Row.Desc.width+1,
		y=Row.Desc.y,
		width=12,
		height=Row.Desc.height,
		colour1=Scrollbar_Colour1,
		colour2=Scrollbar_Colour2,
		texture2="scrollbar.png",
	});

	sgui_set(Row.Desc.ID,PROP_SCROLLBAR,Row.DescScrollBox_scrollV.ID);

	set_Callback(Row.ID,CALLBACK_MOUSEOVER,'setColour1ID('..Row.Mapbar.ID..','..colourToString(mcolourhover)..');');
	set_Callback(Row.ID,CALLBACK_MOUSELEAVE,'setColour1ID('..Row.Mapbar.ID..','..colourToString(colour)..');');
        set_Callback(Row.Desc.ID,CALLBACK_MOUSEOVER,'setColour1ID('..Row.Mapbar.ID..','..colourToString(mcolourhover)..');');
	set_Callback(Row.Desc.ID,CALLBACK_MOUSELEAVE,'setColour1ID('..Row.Mapbar.ID..','..colourToString(colour)..');');

end;

skirmish_info = {};

function skirmish_run()
	OW_runmap_single('_skirmish/'..skirmish_info.map);
end;

function skirmish_map_option_set(index,ID)
	OW_MULTIROOM_HOST_SET_MAPPARAM(index,ID);
end;

function skirmish_map_option_set_LB(index,ID)
	skirmish_map_option_set(index,getIndexID(ID));
end;

optionperrow = 1;
optionheight = 0;

function setOptionHeight(value)
	if optionheight < value then
		optionheight = value;
	end;
end;

function addoption_listbox(option,mi,xpos,wid)
	local LBtext = '';
	for i=1,table.getn(option.list) do
		if LBtext == '' then
			LBtext = option.list[i];
		else
			LBtext = LBtext..'\r'..option.list[i];
		end;
	end;

	local LB = AddElement({
		type=TYPE_LISTBOX,
		parent=skirmish_options_element,
		anchor={top=true,bottom=false,left=true,right=false},
		x=xpos,
		y=skirmish_options_element.height,
		width=wid,
		height=80,
		colour1={red=0,green=0,blue=0,alpha=127},
		text=LBtext,
		font_colour={red=150,green=200,blue=150,alpha=255},
		font_name=Tahoma_14,
	});

	local LB_scrollV = AddElement({
		type=TYPE_SCROLLBAR,
		parent=skirmish_options_element,
		anchor={top=true,bottom=false,left=true,right=false},
		x=LB.x+LB.width+1,
		y=LB.y,
		width=12,
		height=LB.height,
		colour1=Scrollbar_Colour1,
		colour2=Scrollbar_Colour2,
		texture2="scrollbar.png",
	});

	sgui_set(LB.ID,PROP_SCROLLBAR,LB_scrollV.ID);

	set_Callback(LB.ID,CALLBACK_INDEXSET,'skirmish_map_option_set_LB('..tostring(option.id)..','..tostring(LB.ID)..');');
	setIndex(LB,option.default);

	setOptionHeight(80);
end;

function addoption_progressbar_percent(option,mi,xpos,wid)
	local progressbar = merge({
		type=TYPE_PROGRESSBAR,
		parent=skirmish_options_element,
		anchor={top=true,bottom=false,left=true,right=false},
		x=xpos,
		y=skirmish_options_element.height,
		width=wid,
		height=20,
		minmax={min=option.min,max=option.max},
	},progressbar_merge);

	progressbar = makeProgressBarWithPercent(progressbar,'skirmish_map_option_set('..tostring(option.id)..',%p);',{red=255,green=255,blue=255,alpha=255});
	set_Property(progressbar.ID,PROP_PROGRESS,option.default);
	setOptionHeight(20);
end;

function addoption_progressbar_number(option,mi,xpos,wid)
	local progressbar = merge({
		type=TYPE_PROGRESSBAR,
		parent=skirmish_options_element,
		anchor={top=true,bottom=false,left=true,right=false},
		x=xpos,
		y=skirmish_options_element.height,
		width=wid,
		height=20,
		minmax={min=option.min,max=option.max},
	},progressbar_merge);

	progressbar = makeProgressBarWithNumber(progressbar,'skirmish_map_option_set('..tostring(option.id)..',%p);',{red=255,green=255,blue=255,alpha=255});
	set_Property(progressbar.ID,PROP_PROGRESS,option.default);
	setOptionHeight(20);
end;

function addoption_radio(option,mi,xpos,wid)
	local rgroup = NewRadioGroup();

	AddRadio({
		type=TYPE_CHECKBOX,
		parent=skirmish_options_element,
		anchor={top=true,bottom=false,left=true,right=false},
		x=xpos,
		y=skirmish_options_element.height,
		width=20,
		height=20,
		colour1={red=0,green=0,blue=0,alpha=127},
		colour2={red=150,green=150,blue=150,alpha=255},
		checked=(option.default==0),
		group=rgroup,
		caption=option.title1,
		callback_checked='skirmish_map_option_set('..tostring(option.id)..',0);',
	});

	AddRadio({
		type=TYPE_CHECKBOX,
		parent=skirmish_options_element,
		anchor={top=true,bottom=false,left=true,right=false},
		x=xpos+(wid/2),
		y=skirmish_options_element.height,
		width=20,
		height=20,
		colour1={red=0,green=0,blue=0,alpha=127},
		colour2={red=150,green=150,blue=150,alpha=255},
		checked=(option.default==1),
		group=rgroup,
		caption=option.title2,
		callback_checked='skirmish_map_option_set('..tostring(option.id)..',1);',
	});

	skirmish_map_option_set(option.id,option.default);

	setOptionHeight(20);
end;

OPTIONTYPE_LISTBOX             = 0;
OPTIONTYPE_PROGRESSBAR_PERCENT = 1;
OPTIONTYPE_PROGRESSBAR_NUMBER  = 2;
OPTIONTYPE_RADIO               = 3;

function skirmish_map_option(option,index)
	local mi = mod(index,optionperrow);
	local xpos = 15+250+10+mi*550;

	local optiontype = option.type;
	if optiontype == nil then
		optiontype = 0;
	end;

	switch(optiontype) : caseof {
			[0]   = function (x) addoption_listbox(option,mi,xpos,250); end,
			[1]   = function (x) addoption_progressbar_percent(option,mi,xpos,250); end,
			[2]   = function (x) addoption_progressbar_number(option,mi,xpos,250); end,
			[3]   = function (x) addoption_radio(option,mi,xpos,250); end,
		}

	local Label = AddElement({
		type=TYPE_LABEL,
		parent=skirmish_options_element,
		anchor={top=true,bottom=false,left=true,right=true},
		x=15+mi*550,
		y=skirmish_options_element.height,
		width=250,
		height=80,
		colour1={red=0,green=0,blue=0,alpha=0},
		text=option.name,
		text_valign=ALIGN_TOP,
		font_colour={red=200,green=200,blue=200,alpha=255},
		nomouseevent=true,
	});

	if (mi == (optionperrow-1)) then
		skirmish_options_element.height = skirmish_options_element.height+optionheight+10;
		setHeight(skirmish_options_element,skirmish_options_element.height);
		optionheight = 0;
	end;
end;

function skirmish_map_select(Index)
	skirmish_info = SkirmishList[Index+1];
	setVisible(skirmishscrollbox,false);
	setVisible(skirmishscrollbox_scrollV,false);
	setVisible(skirmish_options,true);
	setTexture(skirmish_preview,'%missions%/_skirmish/'..skirmish_info.map..'/mappic.png');
	setText(skirmish_title,skirmish_info.title);
	setText(skirmish_desc,skirmish_info.desc);

	sgui_deletechildren(skirmish_options_element.ID);

	sgui_scrollbox_xyreset(skirmish_options_scrollbox.ID);
        setVisible(skirmish_options_scrollbox_scrollV,false);
	optionperrow = Int((getWidth(skirmish_options_element)-30)/550);
	if (optionperrow < 1) then
		optionperrow = 1;
	end;

	OW_mapparams_clear(); -- sets the map params all to Zero

	skirmish_options_element.height = 10;
	setHeight(skirmish_options_element,skirmish_options_element.height);

	for i=1,table.getn(skirmish_info.options) do
		skirmish_map_option(skirmish_info.options[i],i-1);
	end;

	if (mod(table.getn(skirmish_info.options)-1,optionperrow) ~= (optionperrow-1)) then
		skirmish_options_element.height = skirmish_options_element.height+optionheight+10;
		setHeight(skirmish_options_element,skirmish_options_element.height);
		optionheight = 0;
	end;
end;
