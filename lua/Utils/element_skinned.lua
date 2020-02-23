--[[

NOTE: The purpose of this unit is to provide a central framework for skinning elements based on what type of element they
      are (Specified when adding to the element to the skin list) - STUCUK

--]]

SkinnedElementList      = {};
SkinnedElementListCount = 0;

-- NOTE: DO NOT MOVE TO CONSTANTS.LUA. LEAVE THESE HERE!
SKINTYPE_NONE      = -1; -- Use this to ignore skin
SKINTYPE_CHECKBOX  = 0;
SKINTYPE_RADIO     = 1;
SKINTYPE_SLIDER    = 2;
SKINTYPE_COMBO     = 3;
SKINTYPE_BUTTON    = 4;
SKINTYPE_BUTTONDD  = 5;
SKINTYPE_DIALOG1   = 6;
SKINTYPE_DIALOG2   = 7;
SKINTYPE_TEXTURE   = 8;
SKINTYPE_SLIDERINT = 9;
SKINTYPE_BUTTON_DEBRIEF = 10;

SKINTYPE_BUTTON_ROUNDED = 21;

function AddSkinnedElement(ELEMENT,TYPE)
        if TYPE >= 0 then -- Allows us to pass -1 to this to ignore adding it to skin system!
        	SkinnedElementListCount                     = SkinnedElementListCount+1;
                ELEMENT.SKINTYPE                            = TYPE;
                SkinnedElementList[SkinnedElementListCount] = {};
        	SkinnedElementList[SkinnedElementListCount] = ELEMENT;
        end;
	return ELEMENT;
end;

function AddSkinEle_Tex(ELEMENT,TEXTURE)
        ELEMENT.SKINTEXTURE = TEXTURE;
        return AddSkinnedElement(ELEMENT,SKINTYPE_TEXTURE);
end;


function ApplySkinToElement(ELEMENT)
        switch(ELEMENT.SKINTYPE) : caseof {
			[SKINTYPE_CHECKBOX]   = function (x)
                                                        setInterfaceTexture(ELEMENT,'checkbox_unchecked.png');
                                                        setInterfaceTexture2(ELEMENT,'checkbox_checked.png');
                                                end,
			[SKINTYPE_RADIO]      = function (x)
                                                        setInterfaceTexture(ELEMENT,'radio1.png');
                                                        setInterfaceTexture2(ELEMENT,'radio2.png');
                                                end,
			[SKINTYPE_SLIDER]     = function (x)
                                                        setInterfaceTexture(ELEMENT.buttonup,'scrollright.png');
                                                        setInterfaceTexture(ELEMENT.buttondown,'scrollleft.png');
                                                end,
			[SKINTYPE_SLIDERINT]  = function (x)
                                                        setVisible(ELEMENT.buttonup,false);
                                                        setVisible(ELEMENT.buttondown,false);
                                                        setColour1(ELEMENT.bar,BLACKA(0));
                                                        setInterfaceTexture(ELEMENT.slider,'speedbar_slider.png');
                                                end,
			[SKINTYPE_COMBO]      = function (x)
                                                        local settings = interface.current.dialog.combo;
                                                        setEdgeTexture(ELEMENT.label,getInterfaceDir()..'dropdown_corners.png');
                                                        setEdgeTexture(ELEMENT.list,getInterfaceDir()..'dropdown_corners.png');
                                                        setColour1(ELEMENT.label,settings[1]);
                                                        setColour1(ELEMENT.list,settings[1]);
                                                        setHighlightColour(ELEMENT.list,settings[2]);
                                                        setFontColour(ELEMENT.list,settings[3]);
                                                        setFontColourOver(ELEMENT.list,settings[4]);

                                                        setInterfaceTexture(ELEMENT.scroll.bar,'scrollbar_back.png');
                                                        setInterfaceTexture2(ELEMENT.scroll.bar,'scrollbar_slider.png');

                                                        setInterfaceTexture(ELEMENT.scroll.buttonup,'scrollup.png');
                                                        setInterfaceTexture(ELEMENT.scroll.buttondown,'scrolldown.png');
                                                end,

                        [SKINTYPE_BUTTON]     = function (x)
                                                        UpdateDialogButton(ELEMENT,interface.current.dialog.button);
                                                end,
						[SKINTYPE_BUTTON_DEBRIEF] = function (x)
                                                        UpdateDialogButton(ELEMENT,interface.current.dialog.buttonDebrief);
												end;
                        [SKINTYPE_BUTTONDD]   = function (x)
                                                        UpdateDialogButton(ELEMENT,interface.current.dialog.buttondd);
                                                end,
                        [SKINTYPE_DIALOG1]    = function (x)
                                                        UpdateADialog(ELEMENT,interface.current);
                                                end,
                        [SKINTYPE_DIALOG2]    = function (x)
                                                        UpdateADialog2(ELEMENT,interface.current);
                                                end,
                        [SKINTYPE_TEXTURE]    = function (x)
                                                        setInterfaceTexture(ELEMENT,ELEMENT.SKINTEXTURE);
                                                end,
                        ----------------------------------------------
                        default               = function (x)
                                                        -- LEAVE EMPTY
                                                end,
	}
end;

function DoInterfaceChange_SkinElements()
        local ELEMENT    = {};
	if SkinnedElementListCount > 0 then
		for i=1,SkinnedElementListCount do
                    ApplySkinToElement(SkinnedElementList[i]);
		end;
	end;
end;
