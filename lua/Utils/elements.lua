--[[
        This unit holds all the functions to create elements
--]]

function getElementEX(PARENT,ANCHOR,POSSIZE,VISIBLE,ELEMENT)
        if ELEMENT.type == nil then
                ELEMENT.type = TYPE_ELEMENT;
        end;

        ELEMENT.parent  = PARENT;
        ELEMENT.anchor  = ANCHOR;
        ELEMENT.x       = POSSIZE.X;
        ELEMENT.y       = POSSIZE.Y;
        ELEMENT.width   = POSSIZE.W;
        if POSSIZE.H ~= 0 then
                ELEMENT.height  = POSSIZE.H;
        end;
        if ELEMENT.visible == nil then
                ELEMENT.visible = VISIBLE;
        end;
	ELEMENT = AddElement(ELEMENT);

        if ELEMENT.SKIN ~= nil then
                ELEMENT = AddSkinnedElement(ELEMENT,ELEMENT.SKIN);
        end;

        if POSSIZE.H == 0 then
                ELEMENT.height = 0;
        end;

        return ELEMENT;
end;

function getBlankElementEX(PARENT,ANCHOR,ELEMENT)
	return getElementEX(PARENT,ANCHOR,XYWH(0,0,0,0),true,ELEMENT);
end;

function getScrollboxEX(PARENT,ANCHOR,POSSIZE,ELEMENT)
	ELEMENT.type = TYPE_SCROLLBOX;
	return getElementEX(PARENT,ANCHOR,POSSIZE,true,ELEMENT);
end;

function getImageEX(PARENT,ANCHOR,POSSIZE,TEXTURE_BLEND,SUBTEXTURE,ELEMENT)
        ELEMENT.texture_blend = TEXTURE_BLEND;
        ELEMENT.subtexture    = SUBTEXTURE;
	return getElementEX(PARENT,ANCHOR,XYWH(POSSIZE.X,POSSIZE.Y,POSSIZE.W,POSSIZE.H),true,ELEMENT);
end;

function getImageEX_Loop(PARENT,ANCHOR,POSSIZE,TEXTURE,ELEMENT)
        ELEMENT.texture   = TEXTURE;
        if ELEMENT.anim_loop == nil then
                ELEMENT.anim_loop = false;
        end;
        if ELEMENT.anim_play == nil then
                ELEMENT.anim_play = false;
        end;
	return getElementEX(PARENT,ANCHOR,POSSIZE,true,ELEMENT);
end;

function getLabelEX(PARENT,ANCHOR,POSSIZE,FONT_NAME,TEXT,ELEMENT)
        ELEMENT.type      = TYPE_LABEL;
        if ELEMENT.font_name == nil then
                ELEMENT.font_name = FONT_NAME;
        end;
        ELEMENT.text      = TEXT;

	return getElementEX(PARENT,ANCHOR,POSSIZE,true,ELEMENT);
end;

function getWindowEX(PARENT,ANCHOR,POSSIZE,VISIBLE,CAPTION,BACKGROUND,ELEMENT)
        if BACKGROUND.bevel then
                ELEMENT.bevel            = true;
                ELEMENT.bevel_colour1    = BACKGROUND.bevel_colour1;
                ELEMENT.bevel_colour2    = BACKGROUND.bevel_colour2;
        end;
        if BACKGROUND.gradient then
                ELEMENT.gradient         = true;
                ELEMENT.gradient_colour1 = BACKGROUND.gradient_colour1;
                ELEMENT.gradient_colour2 = BACKGROUND.gradient_colour2;
        end;

        if ELEMENT.title_border_colour == nil then
           ELEMENT.title_border_colour = GRAY(10);
        end;

        if ELEMENT.title_colour == nil then
           ELEMENT.title_colour = RGB(89,89,87);
        end;

        if ELEMENT.title_font_name == nil then
           ELEMENT.title_font_name = Neuropol;
        end;

        if ELEMENT.title_font_scale == nil then
           ELEMENT.title_font_scale = 0.4;
        end;

        ELEMENT       = getElementEX(PARENT,ANCHOR,XYWH(POSSIZE.X,POSSIZE.Y,POSSIZE.W,POSSIZE.H),VISIBLE,ELEMENT);
        ELEMENT.title = getLabelEX(ELEMENT,anchorLTR,XYWH(1,1,POSSIZE.W-2,28),nil,CAPTION,
                                   {text_case=CASE_UPPER,font_colour=WHITE(),colour1=ELEMENT.title_colour, text_halign=ALIGN_MIDDLE,
                                    border_type=BORDER_TYPE_OUTER, border_colour=ELEMENT.title_border_colour, border_size=1, shadowtext=true, font_name=ELEMENT.title_font_name, font_scale=ELEMENT.title_font_scale});
        return ELEMENT;
end;

--When a getCheckBoxEX's label is clicked this switches the Checked value of the CheckBox
function mcbChecked(BUTTON, ID)
	if (BUTTON == 0) then
		sgui_set(ID,PROP_CHECKED,not sgui_get(ID,PROP_CHECKED));
	end;
end;

function getCheckBoxEX(PARENT,ANCHOR,POSSIZE,CAPTION,ONCHECKED,ELEMENT)
        ELEMENT.type             = TYPE_CHECKBOX;
        ELEMENT.callback_checked = ONCHECKED;
        ELEMENT                  = getElementEX(PARENT,ANCHOR,XYWH(POSSIZE.X,POSSIZE.Y,POSSIZE.W,POSSIZE.H),true,ELEMENT);
        ELEMENT.label            = getLabelEX(PARENT,ANCHOR,XYWH(POSSIZE.X+POSSIZE.W,POSSIZE.Y,10,POSSIZE.H),Tahoma_13,CAPTION,
                                              {font_colour=WHITE(), colour1=BLACKA(0), autosize=true,
                                               callback_mousedown='mcbChecked(%b,'..tostring(ELEMENT.ID)..')',});
        return ELEMENT;
end;

function getCheckBoxEX_MENU(PARENT,ANCHOR,POSSIZE,CAPTION,COLOURS,ONCHECKED,ELEMENT)
        ELEMENT.bevel         = true;
        if COLOURS.bevel_colour1 then
                ELEMENT.bevel_colour1 = COLOURS.bevel_colour1;
        else
                ELEMENT.bevel_colour1 = Bevel_Shadow;
        end;
        if COLOURS.bevel_colour2 then
                ELEMENT.bevel_colour2 = COLOURS.bevel_colour2;
        else
                ELEMENT.bevel_colour2 = Bevel_Highlight;
        end;

        if COLOURS.colour1 then
                ELEMENT.colour1 = COLOURS.colour1;
        end;
        if COLOURS.colour2 then
                ELEMENT.colour2 = COLOURS.colour2;
        end;

        if COLOURS.gradient then
                ELEMENT.gradient         = true;
                ELEMENT.gradient_colour1 = COLOURS.gradient_colour1;
                ELEMENT.gradient_colour2 = COLOURS.gradient_colour2;
        end;

        return getCheckBoxEX(PARENT,ANCHOR,POSSIZE,CAPTION,ONCHECKED,ELEMENT);
end;

function getCheckBoxEX_UI(PARENT,ANCHOR,POSSIZE,CAPTION,COLOURS,ONCHECKED,ELEMENT)

        if COLOURS.bevel then
                ELEMENT.bevel_colour1 = COLOURS.bevel_colour1;
                ELEMENT.bevel_colour2 = COLOURS.bevel_colour2;
        end;

        if COLOURS.colour1 then
                ELEMENT.colour1 = COLOURS.colour1;
        else
                ELEMENT.colour1 = WHITE();
        end;
        if COLOURS.colour2 then
                ELEMENT.colour2 = COLOURS.colour2;
        else
                ELEMENT.colour2 = WHITE();
        end;

        if COLOURS.gradient then
                ELEMENT.gradient         = true;
                ELEMENT.gradient_colour1 = COLOURS.gradient_colour1;
                ELEMENT.gradient_colour2 = COLOURS.gradient_colour2;
        end;

        ELEMENT.SKIN = SKINTYPE_CHECKBOX;

        return getCheckBoxEX(PARENT,ANCHOR,POSSIZE,CAPTION,ONCHECKED,ELEMENT);
end;

function getImageButtonEX(PARENT,ANCHOR,POSSIZE,TEXT,TEXTURE,ONMOUSECLICK,SKINTYPE,ELEMENT)
        ELEMENT.type                = TYPE_IMAGEBUTTON;
        ELEMENT.callback_mouseclick = ONMOUSECLICK;
        ELEMENT.text                = TEXT;

        if ELEMENT.font_colour == nil then
                ELEMENT.font_colour = RGB(150,200,150);
        end;

        if ELEMENT.font_name == nil then
                ELEMENT.font_name = Tahoma_13;
        end;

        if TEXTURE ~= '' then
                ELEMENT.texture = TEXTURE;
        end;

        ELEMENT.SKIN = SKINTYPE;

        return getElementEX(PARENT,ANCHOR,XYWH(POSSIZE.X,POSSIZE.Y,POSSIZE.W,POSSIZE.H),true,ELEMENT);
end;

function getCustomListBoxEX(PARENT,ANCHOR,POSSIZE,ITEMHEIGHT,ITEMADDED,ITEMUPDATED,ELEMENT)
        ELEMENT.type                 = TYPE_CUSTOMLISTBOX;
        ELEMENT.itemheight           = ITEMHEIGHT;
        ELEMENT.callback_itemadded   = ITEMADDED;
        ELEMENT.callback_itemupdated = ITEMUPDATED;

        if (ELEMENT.colour1 == nil) then
                ELEMENT.colour1 = BLACKA(127);
        end;

        return getElementEX(PARENT,ANCHOR,XYWH(POSSIZE.X,POSSIZE.Y,POSSIZE.W,POSSIZE.H),true,ELEMENT);
end;

function updateProgressLabel_Percent(PID,LID,PROGRESS)
	local minmax = getMinMaxID(PID);
	local t = ((PROGRESS-minmax.min)/(minmax.max-minmax.min))*100;
	setTextID(LID,tostring(Int(t))..'%');
end;

function updateProgressLabel_Number(PID,LID,PROGRESS)
	setTextID(LID,tostring(Int(PROGRESS)));
end;

function getProgressBarEX(PARENT,ANCHOR,POSSIZE,ONPROGRESS,FONT_COLOUR,LABELUPDATE,ELEMENT)
	ELEMENT.type  = TYPE_PROGRESSBAR;
	ELEMENT       = getElementEX(PARENT,ANCHOR,POSSIZE,true,ELEMENT);

	ELEMENT.label = getLabelEX(ELEMENT,anchorLTRB,XYWH(0,0,POSSIZE.W,POSSIZE.H),Tahoma_14,'',
	                           {colour1=BLACK(0), font_colour=FONT_COLOUR, text_valign=ALIGN_MIDDLE, text_halign=ALIGN_MIDDLE, nomouseevent=true,});
	set_Callback(ELEMENT.ID,CALLBACK_PROGRESS,ONPROGRESS..' '..LABELUPDATE..'('..tostring(ELEMENT.ID)..','..tostring(ELEMENT.label.ID)..',%p);');

	return ELEMENT;
end;

function getProgressBarEX_NoLabel(PARENT,ANCHOR,POSSIZE,ELEMENT)
        ELEMENT.type  = TYPE_PROGRESSBAR;

        return getElementEX(PARENT,ANCHOR,XYWH(POSSIZE.X,POSSIZE.Y,POSSIZE.W,POSSIZE.H),true,ELEMENT);
end;

function getProgressBarEX_WithPercent(PARENT,ANCHOR,POSSIZE,ONPROGRESS,FONT_COLOUR,ELEMENT)
	return getProgressBarEX(PARENT,ANCHOR,POSSIZE,ONPROGRESS,FONT_COLOUR,'updateProgressLabel_Percent',ELEMENT);
end;

function getProgressBarEX_WithNumber(PARENT,ANCHOR,POSSIZE,ONPROGRESS,FONT_COLOUR,ELEMENT)
	return getProgressBarEX(PARENT,ANCHOR,POSSIZE,ONPROGRESS,FONT_COLOUR,'updateProgressLabel_Number',ELEMENT);
end;

function getDialogEX(PARENT,ANCHOR,POSSIZE,SKINTYPE,ELEMENT)
        ELEMENT.SKIN     = SKINTYPE;
	ELEMENT          = getElementEX(PARENT,ANCHOR,POSSIZE,false,ELEMENT);

	ELEMENT.cornerTL = getElementEX(ELEMENT,anchorLT,XYWH(-8,-8,63,62),true,{nomouseevent=true,});
	ELEMENT.cornerTR = getElementEX(ELEMENT,anchorTR,XYWH(POSSIZE.W-63+8,-8,63,62),true,{nomouseevent=true,});
	ELEMENT.cornerBL = getElementEX(ELEMENT,anchorLB,XYWH(-8,POSSIZE.H-62+8,63,62),true,{nomouseevent=true,});
	ELEMENT.cornerBR = getElementEX(ELEMENT,anchorRB,XYWH(POSSIZE.W-63+8,POSSIZE.H-62+8,63,62),true,{nomouseevent=true,});

	ELEMENT.cornerT  = getElementEX(ELEMENT,anchorLTR,XYWH(0,-8,0,0),true,{nomouseevent=true, tile=true,});
	ELEMENT.cornerB  = getElementEX(ELEMENT,anchorLRB,XYWH(0,0,0,0),true,{nomouseevent=true, tile=true,});
	ELEMENT.cornerR  = getElementEX(ELEMENT,anchorTRB,XYWH(0,0,0,0),true,{nomouseevent=true, tile=true,});
	ELEMENT.cornerL  = getElementEX(ELEMENT,anchorLTB,XYWH(-8,0,0,0),true,{nomouseevent=true, tile=true,});

        return ELEMENT;
end;

function getButtonEX(PARENT,ANCHOR,POSSIZE,SKINTYPE,MOUSEDOWN,MOUSEUP,MOUSECLICK,ELEMENT)
        ELEMENT.type                = TYPE_LABEL;
        ELEMENT.text_halign         = ALIGN_MIDDLE;
        ELEMENT.callback_mousedown  = MOUSEDOWN;
        ELEMENT.callback_mouseupany = MOUSEUP;
        ELEMENT.callback_mouseclick = MOUSECLICK;
        ELEMENT.callback_disabled   = MOUSEUP;
        ELEMENT.callback_hidden     = MOUSEUP;

        ELEMENT.SKIN                = SKINTYPE;

        return getElementEX(PARENT,ANCHOR,POSSIZE,true,ELEMENT);
end;

function getButtonEX_Basic(PARENT,ANCHOR,POSSIZE,SKINTYPE,MOUSECLICK,BACKCOLOR,HIGHLIGHTCOLOUR,SHADOWCOLOUR,ELEMENT)
        ELEMENT.colour1       = BACKCOLOR;
        ELEMENT.bevel_colour1 = HIGHLIGHTCOLOUR;
        ELEMENT.bevel_colour2 = SHADOWCOLOUR;
        ELEMENT.bevel         = true;

	ELEMENT               = getButtonEX(PARENT,ANCHOR,POSSIZE,SKINTYPE,'','',MOUSECLICK,ELEMENT);

	ELEMENT.callback_mousedown  = makeBevelStr(ELEMENT.ID,ELEMENT.bevel_colour2,ELEMENT.bevel_colour1);
	ELEMENT.callback_mouseupany = makeBevelStr(ELEMENT.ID,ELEMENT.bevel_colour1,ELEMENT.bevel_colour2);
	ELEMENT.callback_mouseclick = ELEMENT.callback_mouseupany..''..ELEMENT.callback_mouseclick;

        set_Callback(ELEMENT.ID,CALLBACK_MOUSEDOWN,ELEMENT.callback_mousedown);
        set_Callback(ELEMENT.ID,CALLBACK_MOUSEUPANY,ELEMENT.callback_mouseupany);
        set_Callback(ELEMENT.ID,CALLBACK_MOUSECLICK,ELEMENT.callback_mouseclick);
        set_Callback(ELEMENT.ID,CALLBACK_DISABLED,ELEMENT.callback_mouseupany);
        set_Callback(ELEMENT.ID,CALLBACK_HIDDEN,ELEMENT.callback_mouseupany);

        return ELEMENT;
end;

function getButtonEX_Gradient(PARENT,ANCHOR,POSSIZE,SKINTYPE,MOUSECLICK,COLOURS,ELEMENT)
        ELEMENT.colour1             = WHITE();
        ELEMENT.gradient            = true;
        ELEMENT.gradient_colour1    = COLOURS.col1;
        ELEMENT.gradient_colour2    = COLOURS.col2;
        ELEMENT.bevel               = true;
        ELEMENT.bevel_colour1       = COLOURS.b_highlight1;
        ELEMENT.bevel_colour2       = COLOURS.b_shadow1;

        ELEMENT.callback_mouseover  = gradColIDStr(COLOURS.highlight1,COLOURS.highlight2)..''..bevelColIDStr(COLOURS.b_highlight2,COLOURS.b_shadow2);
        ELEMENT.callback_mouseleave = gradColIDStr(COLOURS.col1,COLOURS.col2)..''..bevelColIDStr(COLOURS.b_highlight1,COLOURS.b_shadow1);
        ELEMENT.shadowtext          = true;

        return getButtonEX(PARENT,ANCHOR,POSSIZE,SKINTYPE,bevelColIDStr(COLOURS.b_shadow2,COLOURS.b_highlight2),
                           bevelColIDStr(COLOURS.b_highlight1,COLOURS.b_shadow1),MOUSECLICK,ELEMENT)
end;

function setElementColours(ELEMENT,COLOURS)
        if COLOURS.bevel then
        	ELEMENT.bevel         = true;
                ELEMENT.bevel_colour1 = COLOURS.bevel_colour1;
                ELEMENT.bevel_colour2 = COLOURS.bevel_colour2;
        end;

        if COLOURS.colour1 then
                ELEMENT.colour1 = COLOURS.colour1;
        end;

        if COLOURS.colour2 then
                ELEMENT.colour2 = COLOURS.colour2;
        end;

        if COLOURS.gradient then
                ELEMENT.gradient         = true;
                ELEMENT.gradient_colour1 = COLOURS.gradient_colour1;
                ELEMENT.gradient_colour2 = COLOURS.gradient_colour2;
        end;

        return ELEMENT;
end;

function getEditEX(PARENT,ANCHOR,POSSIZE,FONT_NAME,TEXT,INVALIDCHARS,COLOURS,ELEMENT)
        ELEMENT.type         = TYPE_EDIT;
        ELEMENT.text         = TEXT;
        ELEMENT.invalidchars = INVALIDCHARS;
        if ELEMENT.font_name == nil then
                ELEMENT.font_name = FONT_NAME;
        end;
        return getElementEX(PARENT,ANCHOR,POSSIZE,true,setElementColours(ELEMENT,COLOURS));
end;

function getListBoxEX(PARENT,ANCHOR,POSSIZE,FONT_NAME,TEXT,COLOURS,ELEMENT)
        ELEMENT.type         = TYPE_LISTBOX;
        ELEMENT.text         = TEXT;
        ELEMENT.invalidchars = INVALIDCHARS;
        if ELEMENT.font_name == nil then
                ELEMENT.font_name = FONT_NAME;
        end;
        return getElementEX(PARENT,ANCHOR,POSSIZE,true,setElementColours(ELEMENT,COLOURS));
end;

function getRadioEX(PARENT,ANCHOR,POSSIZE,CHECKED,GROUP,CAPTION,COLOURS,ELEMENT)
        ELEMENT.type    = TYPE_CHECKBOX;
        ELEMENT.checked = CHECKED;
        ELEMENT.group   = GROUP;
        ELEMENT.caption = CAPTION;
        return getRadioWithCaption(PARENT,ANCHOR,POSSIZE,setElementColours(ELEMENT,COLOURS));
end;

function getScrollBarEX(PARENT,ANCHOR,POSSIZE,TEXTURE,BINDTO,COLOURS,ELEMENT)
        ELEMENT.type     = TYPE_SCROLLBAR;
        if TEXTURE ~= nil then
                ELEMENT.texture2 = TEXTURE;
        else
                ELEMENT.texture2 = 'scrollbar.png';
        end;

        ELEMENT = getElementEX(PARENT,ANCHOR,POSSIZE,true,setElementColours(ELEMENT,COLOURS));

        if BINDTO ~= nil then
        	if sgui_get(ELEMENT.ID,PROP_VERTICAL) then
                	sgui_set(BINDTO.ID,PROP_SCROLLBAR,ELEMENT.ID);
                else
                	sgui_set(BINDTO.ID,PROP_SCROLLBAR2,ELEMENT.ID);
                end;
        end;

        return ELEMENT;
end;

function getScrollBarEX_RightOf(BINDTO,ANCHOR,WIDTH,TEXTURE,COLOURS,ELEMENT)
        return getScrollBarEX(BINDTO.parent,ANCHOR,XYWH(getElementRight(BINDTO)+1,BINDTO.y,WIDTH,BINDTO.height),TEXTURE,BINDTO,COLOURS,ELEMENT);
end;

function getScrollBarEX_WithButtons(PARENT,ANCHOR,POSSIZE,BINDTO,SKINTYPE,ELEMENT)
	ELEMENT.colour1    = BLACK(0);
        ELEMENT.SKIN       = SKINTYPE;
        ELEMENT            = getElementEX(PARENT,ANCHOR,XYWH(POSSIZE.X,POSSIZE.Y,POSSIZE.W,POSSIZE.H),true,ELEMENT);
        ELEMENT.bar        = getElementEX(ELEMENT,anchorLTRB,XYWH(0,16,16,POSSIZE.H-32),true,
                                          {type=TYPE_SCROLLBAR,texture='/SGUI/Amer/scrollbar_back.png',
                                           texture2='/SGUI/Amer/scrollbar_slider.png', tile=true, vertical=VERTICAL,});
        ELEMENT.buttonup   = getImageButtonEX(ELEMENT,anchorLTR,XYWH(0,0,16,16),'','/SGUI/Amer/scrollup.png',
                                              'SGUI_scrollbar_scroll('..ELEMENT.bar.ID..',120);',SKINTYPE_NONE,{});
        ELEMENT.buttondown = getImageButtonEX(ELEMENT,anchorLRB,XYWH(0,POSSIZE.H-16,16,16),'','/SGUI/Amer/scrolldown.png',
                                              'SGUI_scrollbar_scroll('..ELEMENT.bar.ID..',-120);',SKINTYPE_NONE,{});

        if BINDTO ~= nil then
        	if sgui_get(ELEMENT.bar.ID,PROP_VERTICAL) then
                	sgui_set(BINDTO.ID,PROP_SCROLLBAR,ELEMENT.bar.ID);
                else
                	sgui_set(BINDTO.ID,PROP_SCROLLBAR2,ELEMENT.bar.ID);
                end;
        end;

        return ELEMENT;
end;

function getScrollBarEX_WithButtons_RightOf(BINDTO,ANCHOR,WIDTH,SKINTYPE,ELEMENT)
        return getScrollBarEX_WithButtons(BINDTO.parent,ANCHOR,XYWH(getElementRight(BINDTO)+1,BINDTO.y,WIDTH,BINDTO.height),BINDTO,SKINTYPE,ELEMENT);
end;

----------------------------------------------------------
-- TODO BELOW THIS LINE!                                --
----------------------------------------------------------

function addAlienSlider(PARENT, ANCHOR, POSSIZE, MIN, MAX, POS, HINT, CALLBACK)
        local ele = addSliderElement(PARENT, ANCHOR, POSSIZE, MIN, MAX, POS, HINT, CALLBACK);

        setColours(ele.bar,ProgressBar_Colour1,ProgressBar_Colour2);
        setBevelAll(ele.bar,true,GRAY(10),GRAY(40));

        setColour1(ele,BLACKA(0));

        setGradientAll(ele.slider,true,ProgressBar_Gradient_Colour1,ProgressBar_Gradient_Colour2);
        setBevelAll(ele.slider,true,GRAY(40),GRAY(50));

        return ele;
end;
