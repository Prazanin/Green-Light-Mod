function set_Colour(ID,PROP,Colour)
	if (Colour ~= nil) then
		sgui_set(ID,PROP,Colour.red,Colour.green,Colour.blue,Colour.alpha);
	end;
end;

function set_SubCoords(ID,PROP,Value)
	if (Value ~= nil) then
		sgui_set(ID,PROP,Value.x,Value.y,Value.w,Value.h);
	end;
end;

function set_Anchor(ID,Anchor)
	if (Anchor ~= nil) then
		sgui_set(ID,PROP_ANCHOR,Anchor.left,Anchor.right,Anchor.top,Anchor.bottom);
	end;
end;

function set_Callback(ID,_TYPE,VALUE)
	if (VALUE ~= nil) then
		sgui_setcallback(ID,_TYPE,VALUE);
	end;
end;

function set_Property(ID,_TYPE,VALUE)
	if (VALUE ~= nil) then
		sgui_set(ID,_TYPE,VALUE);
	end;
end;

function set_PropertyID(ID,_TYPE,VALUE)
	if (VALUE ~= nil) then
		sgui_set(ID,_TYPE,VALUE.ID);
	end;
end;

function set_MinMax(ID,_TYPE,VALUE)
	if (VALUE ~= nil) then
		sgui_set(ID,_TYPE,VALUE.min,VALUE.max);
	end;
end;

function set_Shader(ID,Shader)
	if (Shader ~= nil) then
		sgui_set(ID,PROP_SHADER,Shader.name,Shader.width,Shader.height,Shader.texture0,Shader.texture1,Shader.texture2,Shader.texture3);
	end;
end;

function set_BlendFunc(ID,SFACTOR,DFACTOR)
	if ((SFACTOR ~= nil) or (DFACTOR ~= nil)) then
		sgui_set(ID,PROP_BLENDFUNC,SFACTOR,DFACTOR);
	end;
end;

function set_PropRotate(ID,VALUE)
	if ((VALUE ~= nil) and (VALUE.axis ~= nil) and (VALUE.angle ~= nil)) then
		sgui_set(ID,PROP_ROTATE,VALUE.axis,VALUE.angle,VALUE.flip);
	end;
end;

function AddElement(Input)
	if (Input.type == nil) then
		Input.type = TYPE_ELEMENT;
	end;

        if (Input.special == nil) then
                Input.special = false;
        end;

	if (Input.parent == nil) then
		Input.ID = sgui_create(Input.type,0,Input.special);
	else
		Input.ID = sgui_create(Input.type,Input.parent.ID,Input.special);
	end;

	if (Input.ID > 0) then

		--PROPERTIES BEGIN
			set_Property(Input.ID,PROP_X,Input.x);
			set_Property(Input.ID,PROP_Y,Input.y);
			set_Property(Input.ID,PROP_W,Input.width);
			set_Property(Input.ID,PROP_H,Input.height);
			set_Colour(Input.ID,PROP_COL1,Input.colour1);
			set_Colour(Input.ID,PROP_COL2,Input.colour2); -- If Gradient is true Colour 1 and Colour 2 are used for it. Colour2 is also used for the Checkbox's check colour and Progress Bar's progress colour
			set_Colour(Input.ID,PROP_HIGHLIGHTCOL,Input.highlightcol); -- Used for Listbox's selected item
			set_Colour(Input.ID,PROP_FONT_COL,Input.font_colour);
			set_Colour(Input.ID,PROP_FONT_COL_DISABLED,Input.font_colour_disabled);
			set_Colour(Input.ID,PROP_FONT_COL_OVER,Input.font_colour_over);
			set_Colour(Input.ID,PROP_FONT_COL_BACK,Input.font_colour_background);

			set_Property(Input.ID,PROP_BORDER_SIZE,Input.border_size);
			set_Property(Input.ID,PROP_BORDER_TYPE,Input.border_type); -- BORDER_TYPE_NONE, BORDER_TYPE_INNER, BORDER_TYPE_OUTER
			set_Colour(Input.ID,PROP_BORDER_COLOUR,Input.border_colour);

			set_Property(Input.ID,PROP_STRIKETHROUGH,Input.font_style_strikethrough);
			set_Property(Input.ID,PROP_UNDERLINE,Input.font_style_underline);
                        set_Property(Input.ID,PROP_OUTLINE,Input.font_style_outline);
                        set_Property(Input.ID,PROP_OUTLINE2,Input.font_style_outline2);

			if (Input.font_name == nil) then
				Input.font_name = default_font;
			end;
			set_Property(Input.ID,PROP_FONT_NAME,Input.font_name);

                        set_Property(Input.ID,PROP_FONT_SCALE,Input.font_scale);
                        set_Property(Input.ID,PROP_FONT_CHARGAP,Input.font_chargap);

			set_Property(Input.ID,PROP_SHADOWTEXT,Input.shadowtext);

			set_Property(Input.ID,PROP_GRADIENT,Input.gradient);
			set_Colour(Input.ID,PROP_GRADIENT_COL1,Input.gradient_colour1);
			set_Colour(Input.ID,PROP_GRADIENT_COL2,Input.gradient_colour2);
                        set_Property(Input.ID,PROP_TEXTURE_LINEAR,Input.texture_linear); -- Linear or Nearest Filter
			set_Property(Input.ID,PROP_TEXTURE,Input.texture); -- Texture is the background texture for an Element. It is multiplied by Colour1
			set_Property(Input.ID,PROP_FALLBTEXTURE,Input.texture_fallback); -- Fallback if PROP_TEXTURE does not exist
			set_Property(Input.ID,PROP_TEXTURE2,Input.texture2); -- Texture 2 is used to replace the Checkbox's Check and Progress Bar's progress with an image. It is multiplied by Colour 2
			set_Property(Input.ID,PROP_TEXTURE3,Input.texture3); -- Texture 3 is used by the TYPE_IMAGEBUTTON

			set_Property(Input.ID,PROP_TEXT,Input.text);
			set_Property(Input.ID,PROP_VISIBLE,Input.visible);
			set_Anchor(Input.ID,Input.anchor);

                        set_Property(Input.ID,PROP_SCROLL_TEXT,Input.scroll_text); -- Only works on Labels with 1 line

			set_Property(Input.ID,PROP_EDGES,Input.edges); -- Boolean value. Turns edges on/off
                        set_Property(Input.ID,PROP_EDGES_TEXTURE,Input.edges_texture);

			set_Property(Input.ID,PROP_HALIGN,Input.text_halign); -- Horizontal Text Alignment (ALIGN_LEFT or ALIGN_MIDDLE or ALIGN_RIGHT)
			set_Property(Input.ID,PROP_VALIGN,Input.text_valign); -- Vertical Text Alignment (ALIGN_TOP or ALIGN_MIDDLE or ALIGN_BOTTOM)

			set_Property(Input.ID,PROP_NOMOUSEEVT,Input.nomouseevent); -- If True the element ignores all mouse events allowing those under it to receive them
			set_Property(Input.ID,PROP_NOMOUSEEVTTHIS,Input.nomouseeventthis); -- If True OW ignores this element for mouse click checks but still considers children.
			set_Property(Input.ID,PROP_CHECKED,Input.checked);
			set_MinMax(Input.ID,PROP_MINMAX,Input.minmax);
			set_Property(Input.ID,PROP_PROGRESS,Input.progress);
			set_Property(Input.ID,PROP_ALPHA,Input.alpha);
			set_Property(Input.ID,PROP_TEXTURE_BLEND,Input.texture_blend); -- True by default. enables/disables gl_blend when drawing texture
			set_Property(Input.ID,PROP_INDEX,Input.index);
                        if Input.enabled ~= nil then
                                Input.disabled = not Input.enabled;
                        end;
			set_Property(Input.ID,PROP_DISABLED,Input.disabled); -- Disabled elements receive no mouse input, no keyboard input and may render differently (To show they are disabled)
			set_Property(Input.ID,PROP_AUTOSIZE,Input.autosize); -- Autosize currently only works on labels for automatically resizing their width based on the text and font

			set_Property(Input.ID,PROP_BEVEL,Input.bevel); -- Draw a bevel
			set_Colour(Input.ID,PROP_BEVEL_COL1,Input.bevel_colour1);
			set_Colour(Input.ID,PROP_BEVEL_COL2,Input.bevel_colour2);


			set_Property(Input.ID,PROP_GLYPH,Input.glyph);--Glyph's shouldn't be used as they are not aligned to the side of text. May fix their implementation at a later date
			set_Property(Input.ID,PROP_GLYPH_ALIGN,Input.glyph_align);-- Horizontal Alignment (ALIGN_LEFT or ALIGN_MIDDLE or ALIGN_RIGHT)

			set_Property(Input.ID,PROP_WORDWRAP,Input.wordwrap);

			set_Property(Input.ID,PROP_TEXTCASE,Input.text_case); --CASE_NORMAL, CASE_LOWER, CASE_UPPER, CASE_TITLE

			set_Shader(Input.ID,Input.shader);
			set_Property(Input.ID,PROP_TILE,Input.tile); -- Causes the background texture to tile when true

			set_PropertyID(Input.ID,PROP_SCROLLBAR,Input.scrollbar);
			set_PropertyID(Input.ID,PROP_SCROLLBAR2,Input.scrollbar2);

			set_Property(Input.ID,PROP_VERTICAL,Input.vertical); -- For TYPE_SCROLLBAR elements to state if they are vertical or horizontal. They are vertical by default.

			set_Property(Input.ID,PROP_ITEMHEIGHT,Input.itemheight);

			set_Property(Input.ID,PROP_ANIM_LOOP,Input.anim_loop);
			set_Property(Input.ID,PROP_ANIM_PLAY,Input.anim_play);
			set_Property(Input.ID,PROP_OVERDRAW,Input.overdraw);

			set_Property(Input.ID,PROP_SUBTEXTURE,Input.subtexture);
			set_SubCoords(Input.ID,PROP_SUBCOORDS,Input.subcoords);

			set_Property(Input.ID,PROP_AUTOMAXWIDTH,Input.automaxwidth);

			set_Property(Input.ID,PROP_HINT,Input.hint);
			set_Property(Input.ID,PROP_INVALIDCHARS,Input.invalidchars); -- Characters in the string can't be typed into the edit box

			set_Property(Input.ID,PROP_NOHIGHLIGHT,not Input.highlight); -- For Labels. When Highlight is true a Label will change colour when the mouse is over it.

			set_Property(Input.ID,PROP_SCISSOR,Input.scissor); -- When enabled an element can not draw outside of its area
			set_Property(Input.ID,PROP_SCISSOR_BORDER,Input.scissor_border); -- text will be clipped further by this amount

			set_Property(Input.ID,PROP_TAG,Input.tag); -- Number you can set. Default is 0. Has no usage other than to identify this element


			set_Property(Input.ID,PROP_TOPDOWN,not Input.bottomup); -- LABELS, TEXTBOX, IMAGEBUTTON - Reverses the Text so it goes from bottom up
			set_Property(Input.ID,PROP_DOWN_PIXELS,Input.downpixels); -- LABELS - Amount of pixels the Y position of text will move when Left Mouse is down

			set_Property(Input.ID,PROP_ISPASSWORD,Input.ispassword); -- EDIT - displays entered text as asterix's

			set_Property(Input.ID,PROP_SHADER_TIME,Input.shader_time); -- Sets the shaders time variable
			set_BlendFunc(Input.ID,Input.blendfuncs,Input.blendfuncd);

            set_PropRotate(Input.ID,Input.rotate);

			set_Property(Input.ID,PROP_MASK,Input.mask);


		--PROPERTIES END;

		--CALLBACKS BEGIN
			set_Callback(Input.ID,CALLBACK_MOUSEOVER,Input.callback_mouseover); -- %id = Element ID, %x = Mouse X Coord, %y = Mouse Y Coord
			set_Callback(Input.ID,CALLBACK_MOUSELEAVE,Input.callback_mouseleave); -- %id = Element ID, %x = Mouse X Coord, %y = Mouse Y Coord
			set_Callback(Input.ID,CALLBACK_MOUSEDOWN,Input.callback_mousedown); -- %id = Element ID, %b = Button(0 = left, 1 = right), %x = Mouse X Coord, %y = Mouse Y Coord
			set_Callback(Input.ID,CALLBACK_MOUSEMOVE,Input.callback_mousemove); -- %id = Element ID, %x = Mouse X Coord, %y = Mouse Y Coord
			set_Callback(Input.ID,CALLBACK_MOUSEUP,Input.callback_mouseup); -- %id = Element ID, %b = Button(0 = left, 1 = right), %x = Mouse X Coord, %y = Mouse Y Coord
			set_Callback(Input.ID,CALLBACK_CHECKED,Input.callback_checked); -- %id = Element ID, %value = checked (true/false)
			set_Callback(Input.ID,CALLBACK_MOUSEMOVEANY,Input.callback_mousemoveany); -- %id = Element ID, %x = Mouse X Coord, %y = Mouse Y Coord - Called when any element has mousemove (Only called on visible elements which accept mouse input)
			set_Callback(Input.ID,CALLBACK_RESIZED,Input.callback_resized); -- %id = Element ID. Called when an element is resized
			set_Callback(Input.ID,CALLBACK_INDEXSET,Input.callback_indexset); -- %id = Element ID, %index = index number, %line = line content (string)
			set_Callback(Input.ID,CALLBACK_ITEMCLICKED,Input.callback_itemclicked); -- %id = Element ID, %index = index number, %line = line content (string)
			set_Callback(Input.ID,CALLBACK_MOUSEUPANY,Input.callback_mouseupany); -- %id = Element ID, %b = Button(0 = left, 1 = right), %x = Mouse X Coord, %y = Mouse Y Coord - Called when any element has mouseup (Only called on visible elements which accept mouse input)
			set_Callback(Input.ID,CALLBACK_MOUSECLICK,Input.callback_mouseclick); -- %id = Element ID, %b = Button(0 = left, 1 = right), %x = Mouse X Coord, %y = Mouse Y Coord
			set_Callback(Input.ID,CALLBACK_MOUSEDBLCLICK,Input.callback_mousedblclick); -- %id = Element ID, %b = Button(0 = left, 1 = right), %x = Mouse X Coord, %y = Mouse Y Coord <Note: CALLBACK_MOUSECLICK will be called once before this fires>
			set_Callback(Input.ID,CALLBACK_KEYDOWN,Input.callback_keydown); -- %id = Element ID, %k = Virtual Key Code
			set_Callback(Input.ID,CALLBACK_KEYUP,Input.callback_keyup); -- %id = Element ID, %k = Virtual Key Code
			set_Callback(Input.ID,CALLBACK_KEYPRESS,Input.callback_keypress); -- %id = Element ID, %k = Virtual Key Code
			set_Callback(Input.ID,CALLBACK_PROGRESS,Input.callback_progress); -- TYPE_PROGRESSBAR -- %id = Element ID, %p = progress value

			set_Callback(Input.ID,CALLBACK_ITEMADDED,Input.callback_itemadded);        -- TYPE_ITEMADDED      -- %id = Element ID, %rowid = Row Element ID, %index = row index, %data = LUA Table
			set_Callback(Input.ID,CALLBACK_ITEMDELETED,Input.callback_itemdeleted);    -- TYPE_ITEMDELETED    -- %id = Element ID, %index = row index
			set_Callback(Input.ID,CALLBACK_ITEMUPDATED,Input.callback_itemupdated);    -- TYPE_ITEMUPDATED    -- %id = Element ID, %rowid = Row Element ID, %index = row index, %data = LUA Table
			set_Callback(Input.ID,CALLBACK_ITEMSELECTED,Input.callback_itemselected);   -- TYPE_ITEMSELECTED   -- %id = Element ID, %rowid = Row Element ID, %index = row index, %data = LUA Table
			set_Callback(Input.ID,CALLBACK_ITEMUNSELECTED,Input.callback_itemunselected); -- TYPE_ITEMUNSELECTED -- %id = Element ID, %rowid = Row Element ID, %index = row index, %data = LUA Table

			set_Callback(Input.ID,CALLBACK_ANIMEND,Input.callback_animend); -- %id = Element ID
			set_Callback(Input.ID,CALLBACK_DISABLED,Input.callback_disabled); -- %id = Element ID
			set_Callback(Input.ID,CALLBACK_HIDDEN,Input.callback_hidden); -- %id = Element ID

		--CALLBACKS END
	end;

	return Input;
end;

--[[
local ElementClass = {};
ElementClass.__index = ElementClass;

function ElementClass:new(element)    -- The constructor
  return setmetatable(element, ElementClass)
end;

function ElementClass:set(PROP,VALUE)     -- A method
	sgui_set(self.ID,PROP,VALUE);
end;

function ElementClass:get(PROP)     -- A method
	sgui_get(self.ID,PROP);
end;

function ElementClass:setWidth(VALUE)     -- A method
	self:set(PROP_W,VALUE);
end;

function ElementClass:getWidth(VALUE)     -- A method
	self:get(PROP_W,VALUE);
end;

function AddElementC(Input)
	return ElementClass:new(AddElement(Input));
end;
--]]

function switch(c)
  local swtbl = {
    casevar = c,
    caseof = function (self, code)
      local f
      if (self.casevar) then
        f = code[self.casevar] or code.default
      else
        f = code.missing or code.default
      end
      if f then
        if type(f)=="function" then
          return f(self.casevar,self)
        else
          error("case "..tostring(self.casevar).." not a function")
        end
      end
    end
  }
  return swtbl
end

function setVisible(element,value)
	sgui_set(element.ID,PROP_VISIBLE,value);
end;

function setVisibleID(ID,value)
	sgui_set(ID,PROP_VISIBLE,value);
end;

function getVisible(element)
	return sgui_get(element.ID,PROP_VISIBLE);
end;

function makeHealthBar(theparent)
	local element      = getBlankElement(theparent,anchorLT);
	setColour1(element,BLACK());
	element.bar        = getBlankElement(element,anchorLT);
	return element;
end;

function setHealthBarProgress(element,progress)
	w = getWidth(element);
	h = getHeight(element)-2;

	setXYWHV(element.bar,0,1,w*progress,h);
end;

function makeImageBar(theparent)
	local element      = getBlankImage(theparent,anchorLT,true,true);
	element.bar        = getBlankImage(element,anchorLT,true,true);
	return element;
end;

function makeImageBarWithCaption(theparent,thefont,thetext)
	local element    = getBlankElementA(theparent,anchorLT);
	element.progress = makeImageBar(element);
	element.label    = getBlankLabel(element,anchorLT,thefont,thetext);
	return element;
end;

function setImageBarProgress(element,progress)
	w = getWidth(element);
	h = getHeight(element);

	setSubCoords(element,SUBCOORD(0,0,w,h));
	setSubCoordsWH(element.bar,SUBCOORD(0,h,w*progress,h),w*progress,h);
end;

function setImageBarTexture(element,thetexture)
	setInterfaceTexture(element,thetexture);
	setInterfaceTexture(element.bar,thetexture);
end;

function setImageBarTexture2(element,thetexture,thetexture2)
	setInterfaceTexture(element,thetexture);
	setInterfaceTexture(element.bar,thetexture2);
end;

function setLabelFont(Element,Name,Colour)
         set_Property(Element.ID,PROP_FONT_NAME,Name);
         set_Colour(Element.ID,PROP_FONT_COL,Colour);
end;

function colourToString(Colour)
	return '{red='..Colour.red..',green='..Colour.green..',blue='..Colour.blue..',alpha='..Colour.alpha..'}';
end;

function RGBA(r,g,b,a)
	return {red=r,green=g,blue=b,alpha=a};
end;

function RGB(r,g,b)
	return RGBA(r,g,b,255);
end;

function GRAYA(V,A)
	return RGBA(V,V,V,A);
end;

function GRAY(v)
	return GRAYA(v,255);
end;

function BLACKA(A)
	return RGBA(0,0,0,A);
end;

function BLACK()
	return BLACKA(255);
end;

function WHITEA(A)
	return RGBA(255,255,255,A);
end;

function WHITE()
	return WHITEA(255);
end;

function getHexColour(rgb)
	if rgb == nil then
		rgb = RGB(200,200,200);
	end;

	return ('#C' ..string.format("%x%x%x", rgb.blue,rgb.green,rgb.red));
end;

function makeBevelStr(ID,COL1,COL2)
	return 'set_Colour('..ID..',PROP_BEVEL_COL1,'..colourToString(COL1)..');set_Colour('..ID..',PROP_BEVEL_COL2,'..colourToString(COL2)..');';
end;

function updateGradButton(element,colours)
        bevelColID(element.ID,colours.b_highlight1,colours.b_shadow1);
        setGradientColour1ID(element.ID,colours.col1);
        setGradientColour2ID(element.ID,colours.col2);


	element.callback_mouseleave=gradColIDStr(colours.col1,colours.col2)..''..bevelColIDStr(colours.b_highlight1,colours.b_shadow1);
        set_Callback(element.ID,CALLBACK_MOUSELEAVE,element.callback_mouseleave);
        set_Callback(element.ID,CALLBACK_DISABLED,element.callback_mouseleave);
        set_Callback(element.ID,CALLBACK_HIDDEN,element.callback_mouseleave);

        set_Callback(element.ID,CALLBACK_MOUSEOVER,gradColIDStr(colours.highlight1,colours.highlight2)..''..bevelColIDStr(colours.b_highlight2,colours.b_shadow2));

        set_Callback(element.ID,CALLBACK_MOUSEDOWN,bevelColIDStr(colours.b_shadow2,colours.b_highlight2));
        set_Callback(element.ID,CALLBACK_MOUSEUPANY,bevelColIDStr(colours.b_highlight1,colours.b_shadow1));
end;

function setText(element,text)
	element.text=text;
	sgui_set(element.ID,PROP_TEXT,element.text);
	return element;
end;

function setHint(element,hint)
	sgui_set(element.ID,PROP_HINT,hint);
end;

function setNoMouseEvent(element,value)
	sgui_set(element.ID,PROP_NOMOUSEEVT,value);
end;

function setNoMouseEventThis(element,value)
	sgui_set(element.ID,PROP_NOMOUSEEVTTHIS,value);
end;

function setTextID(ID,text)
	sgui_set(ID,PROP_TEXT,text);
end;

function getText(element)
	return sgui_get(element.ID,PROP_TEXT);
end;

function getTextID(ID)
	return sgui_get(ID,PROP_TEXT);
end;


function getX(element)
	return sgui_get(element.ID,PROP_X);
end;

function setX(element,VALUE)
	return sgui_set(element.ID,PROP_X,VALUE);
end;

function getXID(ID)
	return sgui_get(ID,PROP_X);
end;

function getY(element)
	return sgui_get(element.ID,PROP_Y);
end;

function setY(element,VALUE)
	return sgui_set(element.ID,PROP_Y,VALUE);
end;

function getYID(ID)
	return sgui_get(ID,PROP_Y);
end;

function getAbsX(element)
        return sgui_get(element.ID,PROP_ABS_X);
end;

function getAbsY(element)
        return sgui_get(element.ID,PROP_ABS_Y);
end;

function getWidth(element)
	return sgui_get(element.ID,PROP_W);
end;

function getWidthID(ID)
	return sgui_get(ID,PROP_W);
end;

function setProgress(element,VALUE)
	return sgui_set(element.ID,PROP_PROGRESS,VALUE);
end;

function setWidth(element,VALUE)
	return sgui_set(element.ID,PROP_W,VALUE);
end;

function getHeight(element)
	return sgui_get(element.ID,PROP_H);
end;

function getHeightID(ID)
	return sgui_get(ID,PROP_H);
end;

function setHeight(element,VALUE)
	return sgui_set(element.ID,PROP_H,VALUE);
end;

function getChecked(element)
	return sgui_get(element.ID,PROP_CHECKED);
end;

function setChecked(element,VALUE)
	return sgui_set(element.ID,PROP_CHECKED,VALUE);
end;

function setShaderTime(ELEMENT,VALUE)
	set_Property(ELEMENT.ID,PROP_SHADER_TIME,VALUE);
end;

function setXYWH(element,Data)
	sgui_set(element.ID,PROP_X,Data.X);
	sgui_set(element.ID,PROP_Y,Data.Y);
	sgui_set(element.ID,PROP_W,Data.W);
	sgui_set(element.ID,PROP_H,Data.H);
end;

function setXYWHV(element,X,Y,W,H)
	sgui_set(element.ID,PROP_X,X);
	sgui_set(element.ID,PROP_Y,Y);
	sgui_set(element.ID,PROP_W,W);
	sgui_set(element.ID,PROP_H,H);
end;

function setXY(element,X,Y)
	sgui_set(element.ID,PROP_X,X);
	sgui_set(element.ID,PROP_Y,Y);
end;

function setWH(element,W,H)
	sgui_set(element.ID,PROP_W,W);
	sgui_set(element.ID,PROP_H,H);
end;

function XYWH(SX,SY,SW,SH)
	return {X = SX, Y = SY, W = SW, H = SH};
end;

function SUBCOORD(XV,YV,WV,HV)
	return {x=XV,y=YV,w=WV,h=HV};
end;

function setEnabled(element,VALUE)
	set_Property(element.ID,PROP_DISABLED,not VALUE);
end;

function getEnabled(element)
	return not sgui_get(element.ID,PROP_DISABLED);
end;

function setEnabledID(ID,VALUE)
	set_Property(ID,PROP_DISABLED,not VALUE);
end;

function setAlpha(element,VALUE)
        set_Property(element.ID,PROP_ALPHA,VALUE);
end;

function getLineAT(listbox,line)
	return sgui_get(listbox.ID,PROP_LINE,line);
end;

function getIndex(listbox)
	return sgui_get(listbox.ID,PROP_INDEX);
end;

function getIndexID(ID)
	return sgui_get(ID,PROP_INDEX);
end;

function setIndex(listbox,index)
	return sgui_set(listbox.ID,PROP_INDEX,index);
end;

function setIndexID(ID,index)
	return sgui_set(ID,PROP_INDEX,index);
end;

function getLine(listbox)
	return sgui_get(listbox.ID,PROP_LINE,getIndex(listbox));
end;

function getLineID(ID)
	return sgui_get(ID,PROP_LINE,getIndexID(ID));
end;

function loc(id)
	id = localization(id)
	id = string.gsub(id, "\\n", CHAR13);-- '\n');	-- CHAR13 for safe hints
	return id;
end;

function loc1(id,s1)
        return string.format(loc(id),s1);
end;

function loc2(id,s1,s2)
        return string.format(loc(id),s1,s2);
end;

function loc3(id,s1,s2,s3)
        return string.format(loc(id),s1,s2,s3);
end;

function map_loc(id)
	return OW_LOCAL_LANG(id);  -- NOTE: It automatically converts \n to CHAR13 on the app side!
end;

function isVisible(element)
	return sgui_get(element.ID,PROP_VISIBLE);
end;

function setFocus(element)
	sgui_setkeyboardfocus(element.ID);
end;

function clearFocus()
	sgui_setkeyboardfocus(-1);
end;

function setColour1(element,colour)
	set_Colour(element.ID,PROP_COL1,colour);
end;

function setColour1ID(ID,colour)
	set_Colour(ID,PROP_COL1,colour);
end;

function setColour2(element,colour)
	set_Colour(element.ID,PROP_COL2,colour);
end;

function setColours(ELEMENT,COL1,COL2)
        set_Colour(ELEMENT.ID,PROP_COL1,COL1);
	set_Colour(ELEMENT.ID,PROP_COL2,COL2);
end;

function setHighlightColour(element,value)
	set_Colour(element.ID,PROP_HIGHLIGHTCOL,value);
end;

function setBorderColour(element,colour)
	set_Colour(element.ID,PROP_BORDER_COLOUR,colour);
end;

function setGradientColour1ID(ID,colour)
	set_Colour(ID,PROP_GRADIENT_COL1,colour);
end;

function setGradientColour2ID(ID,colour)
	set_Colour(ID,PROP_GRADIENT_COL2,colour);
end;

function setGradientAll(ELEMENT,VALUE,COL1,COL2)
        set_Property(ELEMENT.ID,PROP_GRADIENT,VALUE);
	set_Colour(ELEMENT.ID,PROP_GRADIENT_COL1,COL1);
        set_Colour(ELEMENT.ID,PROP_GRADIENT_COL2,COL2);
end;

function gradCol1ID(ID,colour)
	setGradientColour1ID(ID,colour);
end;

function gradCol2ID(ID,colour)
	setGradientColour2ID(ID,colour);
end;

function gradColID(ID,colour1,colour2)
	gradCol1ID(ID,colour1);
	gradCol2ID(ID,colour2);
end;

function gradColIDStr(colour1,colour2)
	return 'gradColID(%id,'..colourToString(colour1)..','..colourToString(colour2)..');';
end;

function bevelColID(ID,colour1,colour2)
	set_Colour(ID,PROP_BEVEL_COL1,colour1);
	set_Colour(ID,PROP_BEVEL_COL2,colour2);
end;

function setBevelCol(element,colour1,colour2)
	set_Colour(element.ID,PROP_BEVEL_COL1,colour1);
	set_Colour(element.ID,PROP_BEVEL_COL2,colour2);
end;

function bevelColIDStr(colour1,colour2)
	return 'bevelColID(%id,'..colourToString(colour1)..','..colourToString(colour2)..');';
end;

function setScrollText(ELEMENT,VALUE)
	sgui_set(ELEMENT.ID,PROP_SCROLL_TEXT,VALUE);
end;

function setScissor(ELEMENT,VALUE,BORDER)
	sgui_set(ELEMENT.ID,PROP_SCISSOR,VALUE);
        sgui_set(ELEMENT.ID,PROP_SCISSOR_BORDER,BORDER);
end;

function setFontColourID(ID,colour)
	set_Colour(ID,PROP_FONT_COL,colour);
end;

function setFontColour(element,colour)
	set_Colour(element.ID,PROP_FONT_COL,colour);
end;

function setFontColourOver(element,colour)
	set_Colour(element.ID,PROP_FONT_COL_OVER,colour);
end;

function setFontColourBoth(element,colour)
	set_Colour(element.ID,PROP_FONT_COL,colour);
	set_Colour(element.ID,PROP_FONT_COL_OVER,colour);
end;

function setFontName(ELEMENT,FONT_NAME)
	set_Property(ELEMENT.ID,PROP_FONT_NAME,FONT_NAME);
end;

function setFontScale(ELEMENT,FONT_SCALE)
	set_Property(ELEMENT.ID,PROP_FONT_SCALE,FONT_SCALE);
end;

function setTextureID(ID,texture)
	set_Property(ID,PROP_TEXTURE,texture);
end;

function setTextureFromID(element,ID,Width,Height,AWidth,AHeight)
	SGUI_settextureid(element.ID,ID,Width,Height,AWidth,AHeight);
end;

function setTexture(element,texture)
	set_Property(element.ID,PROP_TEXTURE,texture);
end;

function setTextureMask(element,texture)
	set_Property(element.ID,PROP_MASK,texture);
end;

function getTexture(element)
	return sgui_get(element.ID,PROP_TEXTURE);
end;

function setTexture2(element,texture)
	set_Property(element.ID,PROP_TEXTURE2,texture);
end;

function setTexture3(element,texture)
	set_Property(element.ID,PROP_TEXTURE3,texture);
end;

function setTextureFallbackID(ID,texture)
	set_Property(ID,PROP_FALLBTEXTURE,texture);
end;

function setTextureFallback(element,texture)
	set_Property(element.ID,PROP_FALLBTEXTURE,texture);
end;

function setEdgeTexture(element,value)
	set_Property(element.ID,PROP_EDGES_TEXTURE,value);
end;

function getMinMaxID(ID)
	return sgui_get(ID,PROP_MINMAX);
end;

function setBevel(element,value)
	set_Property(element.ID,PROP_BEVEL,value);
end;

function setBevelAll(ELEMENT,VALUE,COL1,COL2)
	set_Property(ELEMENT.ID,PROP_BEVEL,VALUE);
        set_Colour(ELEMENT.ID,PROP_BEVEL_COL1,COL1);
	set_Colour(ELEMENT.ID,PROP_BEVEL_COL2,COL2);
end;

function setBevelID(ID,value)
	set_Property(ID,PROP_BEVEL,value);
end;

function setStrikeThrough(ELEMENT,VALUE)
	sgui_set(ELEMENT.ID,PROP_STRIKETHROUGH,VALUE);
end;

function setGradient(element,value)
	set_Property(element.ID,PROP_GRADIENT,value);
end;

function setGradientID(ID,value)
	set_Property(ID,PROP_GRADIENT,value);
end;

function setTextHAlign(element,value)
	set_Property(element.ID,PROP_HALIGN,value);
end;

function setTextVAlign(element,value)
	set_Property(element.ID,PROP_VALIGN,value);
end;

function setSubTexture(element,value)
	set_Property(element.ID,PROP_SUBTEXTURE,value);
end;

function setSubCoords(element,value)
	set_SubCoords(element.ID,PROP_SUBCOORDS,value);
end;

function setSubCoordsWH(element,value,w,h)
	setSubCoords(element,value);
	setWHV(element,w,h);
end;

function setTextCase(ELEMENT,VALUE)
        set_Property(ELEMENT.ID,PROP_TEXTCASE,VALUE);
end;

function setTag(ELEMENT,VALUE)
        set_Property(ELEMENT.ID,PROP_TAG,VALUE);
end;

function setBorder(ELEMENT,TYPE,SIZE,COLOUR)
	set_Property(ELEMENT.ID,PROP_BORDER_SIZE,SIZE);
	set_Property(ELEMENT.ID,PROP_BORDER_TYPE,TYPE); -- BORDER_TYPE_NONE, BORDER_TYPE_INNER, BORDER_TYPE_OUTER
	set_Colour(ELEMENT.ID,PROP_BORDER_COLOUR,COLOUR);
end;

function isMouseOverElement(element)
	return SGUI_mouseoverelement(element.ID);
end;

function getMouseOverElementX(element)
	return SGUI_mouseoverelementx(element.ID);
end;

function getMouseOverElementY(element)
	return SGUI_mouseoverelementy(element.ID);
end;

function setMouseCallback_MoveLeave(element,callback)
	set_Callback(element.ID,CALLBACK_MOUSEMOVE,callback);
	set_Callback(element.ID,CALLBACK_MOUSELEAVE,callback);
end;

function scrollbar_scroll(element, value)
        SGUI_scrollbar_scroll(element.ID, value);
end;

function elementBottom(element)
	return element.y+element.height;
end;

function elementRight(element)
	return element.x+element.width;
end;

function getElementRight(element)
	return getX(element)+getWidth(element);
end;

function getElementBottom(element)
	return getY(element)+getHeight(element);
end;

function bringToFront(element)
	sgui_bringtofront(element.ID);
end;

function IgnoreKeyboard(value)
        OW_SET_OW_IGNORE_KEYBOARD(value);
end;

function CTAPI_newTexture(WIDTH,HEIGHT)
	return OW_CTEXAPI_NEWTEXTURE(WIDTH,HEIGHT);
end;

function CTAPI_drawBox(ID,X,Y,WIDTH,HEIGHT,COLOUR)
	X = div(X,1);
	Y = div(Y,1);
	WIDTH = div(WIDTH,1);
	HEIGHT = div(HEIGHT,1);

	if WIDTH <1 then
		WIDTH = 1;
	end;

	if HEIGHT < 1 then
		HEIGHT =1;
	end;

	OW_CTEXAPI_DRAWBOX(ID,X,Y,WIDTH,HEIGHT,COLOUR.red,COLOUR.green,COLOUR.blue,COLOUR.alpha);
end;

function CTAPI_drawLine(ID,X1,Y1,X2,Y2,COLOUR)
	OW_CTEXAPI_DRAWLINE(ID,X1,Y1,X2,Y2,COLOUR.red,COLOUR.green,COLOUR.blue,COLOUR.alpha);
end;

function CTAPI_finishTexture(ID)
	OW_CTEXAPI_FINISHTEXTURE(ID);
end;
function CTAPI_updateTexture(ID)
	OW_CTEXAPI_UPLOADTEXTURE(ID);
end;
function CTAPI_setElementTexture(ID,ELEMENT)
	OW_CTEXAPI_SETELEMENT(ID,ELEMENT.ID);
end;

function CTAPI_freeTexture(ID)
	OW_CTEXAPI_FREETEXTURE(ID);
end;

function boolToStr(VALUE)
        if VALUE then
                return 'true';
        else
                return 'false';
        end;
end;

function bInt(var)
  return var and 1 or 0;
end

function regTickCallback(VALUE)
        SGUI_register_tick_callback(VALUE);
end;

function merge(t1, t2) --http://stackoverflow.com/questions/1283388/lua-merge-tables
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end

function odd(number)
	if (math.mod(number,2) == 0) then
		return false;
	else
		return true;
	end
end;

function even(number)
	if (math.mod(number,2) == 0) then
		return true;
	else
		return false;
	end
end;

function roundup(value)
	return math.ceil(value);
end;

function min(A,B)
	if (A < B) then
		return A;
	else
		return B;
	end;
end;

function max(A,B)
	if (A > B) then
		return A;
	else
		return B;
	end;
end;

function mod(A,B)
	return math.mod(A,B);
end;

function minmax(VALUE,MIN,MAX)
	return max(min(VALUE,MAX),MIN);
end;

function div(A,B)
    return math.floor(A/B);
end;

function sign(x)
  return (x<0 and -1) or 1;
end

function isInArray(value, thearray)
	for _, v in ipairs(thearray) do
		if v == value then
			return true;
		end;
	end;

	return false;
end;

function loc_val(LOC,VALUE)
	return string.format(loc(LOC),VALUE);
end;

function copytable(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[copytable(orig_key)] = copytable(orig_value)
        end
        setmetatable(copy, copytable(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end;

-- replace <value1> .. <valueN> in loc string for VALUES[1] .. VALUES[N]
function loc_format(LOC,VALUES)
	local str = loc(LOC);
	for i = 1, table.getn(VALUES) do
		str = string.gsub(str, "<value" ..i ..">", VALUES[i]);
	end;

	str = string.gsub(str, "\\n", CHAR13);--"\n");
	return str;
end;

function getFirstRest(DATA,VALUE)
	return {FIRST=splitstringfirst(DATA,VALUE),REST=splitstringrest(DATA,VALUE)};
end;

function SetRotate(AXIS,ANGLE,FLIP)
	if (ANGLE > -0.0001) and (ANGLE < 0.0001) then
		ANGLE = 0.0001;
        end;
	return {axis=AXIS,angle=ANGLE,flip=FLIP};
end;

function setRotation(ELEMENT,VALUE)
	set_PropRotate(ELEMENT.ID,VALUE);
end;
