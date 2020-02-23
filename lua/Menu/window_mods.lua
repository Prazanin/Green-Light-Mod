-----------------------------------------------------------------------------
---  Orig. File : /lua/windows_mods.lua
---  Version    : 9
---
---  Summary    : Mods Management.
---
---  Created    : Petr 'Sali' Salak, Freya Group
---               Stuart 'Stucuk' Carey, OW Support
------------------------------------------------------------------------------

modswindow = AddElement({
	type=TYPE_ELEMENT,
	parent=menu,
	anchor={top=true,bottom=true,left=true,right=true},
	visible=false,
	x=menu.side.width+5,
	y=40,
	width=LayoutWidth-menu.side.width-5-5,
	height=LayoutHeight-80,
	colour1={red=0,green=0,blue=100,alpha=0},
});

modsscrollbox = AddElement({
	type=TYPE_SCROLLBOX,
	parent=modswindow,
	anchor={top=true,bottom=true,left=true,right=true},
	x=20,
	y=30,
	width=modswindow.width-40-13,
	height=modswindow.height-60,
	colour1={red=0,green=0,blue=0,alpha=0},
	bevel=true,
});

modsscrollbox_scrollV = AddElement({
	type=TYPE_SCROLLBAR,
	parent=modswindow,
	anchor={top=true,bottom=true,left=false,right=true},
	x=modsscrollbox.x+modsscrollbox.width+1,
	y=modsscrollbox.y,
	width=12,
	height=modsscrollbox.height,
	colour1=Scrollbar_Colour1,
	colour2=Scrollbar_Colour2,
	texture2="scrollbar.png",
});

modswindow.title = AddElement ({
	type=TYPE_LABEL,
	parent=modswindow,
	anchor={top=true,bottom=false,left=true,right=true},
	x=0,
	y=-10,
	width=modswindow.width,
	height=30,
	text=loc(TID_MODS), --mods
	font_colour={red=255,green=255,blue=255,alpha=255},
	nomouseevent=true,
	text_halign=ALIGN_MIDDLE,
	font_name=Tahoma_30B ,
--font_scale=1.5,
	shadowtext=true,
});

--modswindow.line = AddElement({
--	type=TYPE_ELEMENT,
--	parent=modswindow,
--	anchor={top=true,bottom=false,left=true,right=true},
--	x=30,
--	y=10+10,
--	width=modswindow.width-80,
--	height=2,
--	colour1={red=136,green=132,blue=96,alpha=255},
--});

--modswindow.line2 = AddElement({
--	type=TYPE_ELEMENT,
--	parent=modswindow,
--	anchor={top=false,bottom=true,left=true,right=true},
--	x=30,
--	y=modswindow.height-20,
--	width=modswindow.width-80,
--	height=2,
--	colour1={red=136,green=132,blue=96,alpha=255},
--});

sgui_set(modsscrollbox.ID,PROP_SCROLLBAR,modsscrollbox_scrollV.ID);

mcolourhover={red=150,green=200,blue=150,alpha=255};
selectedcolour={red=50,green=50,blue=100,alpha=255};

	currentCulumm=0;
	currentLine=0;
function mods_add_elements(INFO,Index,Selected,DIR)
	local ms=1
	if ScrWidth	>=	(2560) then
		ms = ScrWidth/2560;  --modifed size
	end;
--	if ScrWidth >= (3*600+(100+menu.side.width)) then
--		--xpos=getWidth(modsscroll)/3+5+(currentCulumm*605);
--		xpos=(getWidth(modsscrollbox)/2)-(1.5*(605*ms))+(currentCulumm*(605*ms));
--		ypos=currentLine;
--		currentCulumm=currentCulumm+1;
--		if currentCulumm == 3 then
--			currentCulumm = 0;
--			currentLine=currentLine+1;
--		end;
--	elseif ScrWidth >= (2*600+100+menu.side.width) then
--		if odd(Index) then
--			xpos= getWidth(modsscrollbox)/2+5;
--			ypos= Index/2-0.5;
--		else
--			xpos= getWidth(modsscrollbox)/2-605;
--			ypos= Index/2;
--		end;
--	else
--		xpos= getWidth(modsscrollbox)/2-300;
--		ypos= Index;
--	end;

	if Selected then
		colour=selectedcolour;
	else
		colour={red=255,green=255,blue=255,alpha=255};
	end;


	local w = getWidth(modsscrollbox)-10*ms;
	local countW = div(w,((605)*ms));

	local shiftX = (w - countW * ((605)*ms) )/ 2

	local x = mod(Index,countW);
	local y = div(Index,countW);




	local tmp = IsVersionNewer(INFO.Req_Ver,getvalue(OWV_VERSION));
	local riskVer = {};
	if tmp == 0 then
		riskVer = {red=0,green=255,blue=0,alpha=255};
	elseif tmp == 1 then
		riskVer = {red=255,green=255,blue=0,alpha=255};
	elseif tmp == 2 then
		riskVer = {red=255,green=165,blue=0,alpha=255};
	else
		riskVer = {red=255,green=0,blue=0,alpha=255};
	end;


	if DIR==nil then
		modtex = 'SGUI/Alien/mod_default.png';
	else
		modtex='%ow%/mods/'..DIR..'/modbanner.png';
	end;


	local Row = getElementEX(
				modsscrollbox,
				anchorTL,
				XYWH(
					x*((605)*ms)+5*ms+shiftX,
					y*(145*ms)+10*ms,
					(600)*ms,
					140*ms
				),
				true,
				{
					texture=modtex,
					colour1=colour,
					texture_fallback='SGUI/Alien/mod_unknown.png',
					callback_mouseclick='mods_selectclick(%b,'..tostring(Index-1)..');',
				}
	);

	if INFO.Mod ~= nil then
		INFO.Mod = SGUI_widesub(INFO.Mod, 1, 45);
	end;

	if Selected then
		INFO.Mod = INFO.Mod.." " ..loc(TID_Mod_Current);
	end;

	AddElement({
		type=TYPE_LABEL,
		parent=Row,
		anchor={top=true,bottom=false,left=true,right=false},
		x=8*ms,
		y=5*ms,
		width=Row.width-100*ms,
		height=30*ms,
		colour1={red=0,green=0,blue=0,alpha=0},
		text=INFO.Mod,
		nomouseevent=true,
		wordwrap=false,
		font_name='Trebuchet MS_70_Fixed_16_2.DFF;'..0.72*ms ..';0.3;0.5;1',--Trebuchet_30,
                font_style_outline=true,
                shadowtext=true,
		font_colour={red=255,green=255,blue=255,alpha=255},
	});

	if INFO.Req_Ver then
		AddElement({
			type=TYPE_LABEL,
			parent=Row,
			anchor={top=true,bottom=false,left=false,right=true},
			x=(600-10-100)*ms,
			y=3*ms,
			width=100*ms,
			height=12*ms,
			colour1={red=0,green=0,blue=0,alpha=0},
			text=loc(TID_Min_Ver),
			nomouseevent=true,
			wordwrap=false,
			text_halign=ALIGN_RIGHT,
			font_name=Tahoma_12B , 	-- --Tahoma_10B  10 isn't readable for japanese
                        font_style_outline=true,
                        shadowtext=true,
			font_colour={red=255,green=255,blue=255,alpha=255},
		});
		reqVer = AddElement({
			type=TYPE_LABEL,
			parent=Row,
			anchor={top=true,bottom=false,left=false,right=true},
			x=(600-10-100)*ms,
			y=(3+14)*ms,
			width=100*ms,
			height=12*ms,
			colour1={red=0,green=0,blue=0,alpha=0},
			text=INFO.Req_Ver,

			nomouseevent=true,
			wordwrap=false,
			text_halign=ALIGN_RIGHT,
			font_name=Tahoma_12B ,	--Tahoma_10B  10 isn't readable for japanese
                        font_style_outline=true,
                        shadowtext=true,
			font_colour=riskVer,
		});
	end;

	local t = "";
	if INFO.Desc then
		t = SGUI_widesub(INFO.Desc, 1, 300);
	end;

	Row.Desc = AddElement({
		type=TYPE_TEXTBOX,
		parent=Row,
		x=10,
		y=(5+35) * ms,
		width=585*ms-10,
		height=70*ms,
		text=t,
		nomouseevent=true,
		wordwrap=true,
		text_halign=ALIGN_LEFT,
		font_name=Tahoma_14B,
		font_colour=WHITEA(255),
		font_style_outline=true,
		callback_mouseclick='mods_selectclick(%b,'..tostring(Index-1)..');',
		shadowtext=true,
	});

--	Row.DescScrollBox_scrollV = AddElement({
--		type=TYPE_SCROLLBAR,
--		parent=Row,
--		anchor={top=true,bottom=true,left=false,right=true},
--		x=Row.Desc.x+Row.Desc.width+1,
--		y=Row.Desc.y,
--		width=12,
--		height=Row.Desc.height,
--		colour1=Scrollbar_Colour1,
--		colour2=Scrollbar_Colour2,
--		texture2="scrollbar.png",
--	});

--	sgui_set(Row.Desc.ID,PROP_SCROLLBAR,Row.DescScrollBox_scrollV.ID);

	if INFO.Mod_Ver then
		AddElement({
			type=TYPE_LABEL,
			parent=Row,
			anchor={top=false,bottom=false,left=true,right=false},
			x=10*ms,
			y=115*ms,
			width=580*ms,
			height=12*ms,
			colour1={red=0,green=0,blue=0,alpha=0},
			text=loc(TID_Mod_Ver) ..' '.. INFO.Mod_Ver,
			nomouseevent=true,
			wordwrap=false,
			text_halign=ALIGN_LEFT,
			font_name=Tahoma_12B ,
                        font_style_outline=true,
                        shadowtext=true,
			font_colour={red=255,green=255,blue=255,alpha=255},
		});
	end;

	marks_count = 0;
 	if INFO.Marks then
		for i=1,table.getn(INFO.Marks) do

		mark = AddElement({
				type=TYPE_ELEMENT,
				parent=Row,
				anchor={top=false,bottom=true,left=false,right=true},
				x=(600-40-5-35*marks_count)*ms,
				y=(140-30)*ms,
				width=40*ms,
				height=27*ms,
				colour1={red=255,green=255,blue=255,alpha=255},
				texture='SGUI/Alien/modmarks/' ..INFO.Marks[i].. '.png',
				hint=loc(marks_hints[INFO.Marks[i]]);
				--nomouseevent=true,
				callback_mouseclick='mods_selectclick(%b,'..tostring(Index-1)..');',
			});

			marks_count = marks_count+1;
			set_Callback(mark.ID,CALLBACK_MOUSEOVER,'setColour1ID('..Row.ID..','..colourToString(mcolourhover)..');');
			set_Callback(mark.ID,CALLBACK_MOUSELEAVE,'setColour1ID('..Row.ID..','..colourToString(colour)..');');
		end;
	end;

	set_Callback(Row.ID,CALLBACK_MOUSEOVER,'setColour1ID('..Row.ID..','..colourToString(mcolourhover)..');');
	set_Callback(Row.ID,CALLBACK_MOUSELEAVE,'setColour1ID('..Row.ID..','..colourToString(colour)..');');
	set_Callback(Row.Desc.ID,CALLBACK_MOUSEOVER,'setColour1ID('..Row.ID..','..colourToString(mcolourhover)..');');
	set_Callback(Row.Desc.ID,CALLBACK_MOUSELEAVE,'setColour1ID('..Row.ID..','..colourToString(colour)..');');
end;

function FROMOW_MODS_ADD(INFO) -- Called by OW!
	mods_add_elements(INFO.ini,INFO.id+1,INFO.selected,INFO.dir);
end;

marks_hints={	['am']=TID_Mark_Hint_am,
				['ar']=TID_Mark_Hint_ar,
				['ru']=TID_Mark_Hint_ru,
				['skir']=TID_Mark_Hint_skir,
				['balanc']=TID_Mark_Hint_balanc,
				['coop']=TID_Mark_Hint_coop,
				['moded']=TID_Mark_Hint_moded,
				['multi']=TID_Mark_Hint_multi,
				['ncunit'] = TID_Mark_Hint_ncunit,
				['spec']=TID_Mark_Hint_spec};
mods_count = 0;

function mods_show()
	sgui_deletechildren(modsscrollbox.ID);
	sgui_scrollbox_xyreset(modsscrollbox.ID);
	currentLine=0;
	currentCulumm=0;

	mods_count = OW_mods_initex();

        setVisible(modswindow,true);
end;

function mods_selectclick(button,index)
	if (button == 0) then
		OW_mods_switchex(index);
		setVisible(modswindow,false);
	end;
end;
