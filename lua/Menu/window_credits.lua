credits = AddElement({
	type=TYPE_ELEMENT,
	parent=menu,
	anchor={top=true,bottom=true,left=true,right=true},
	visible=false,
	x=menu.side.width,
	y=LayoutHeight+20,
	width=LayoutWidth-menu.side.width,
	height=0,
	colour1=BLACKA(0),
});

creditsspace = 10;

function AddToCredits(element)
	element.parent = credits;
	element.y      = credits.height;
	credits.height = credits.height+element.height+2;
	--Inc(credits.height,element.height+2);
	return AddElement(element);
end;

function MakeCreditLabel(TEXT,FONTNAME,FONTSCALE)
	if FONTNAME == nil then
		FONTNAME = Tahoma_20B;
	end;

	local s = {
		type=TYPE_LABEL,
		anchor={top=true,bottom=false,left=true,right=true},
		x=0-1,
		width=credits.width,
		height=24,
		text=TEXT,
		font_colour=BLACKA(127),
		colour1=BLACKA(0),
		text_halign=ALIGN_MIDDLE,
		font_name=Tahoma_20B,
		shadowtext=true,
	}

	if FONTSCALE ~= nil then
		s.font_scale = FONTSCALE;
                s.height = s.height*(FONTSCALE/0.64);
	else
        	s.font_scale = 0.64;
	end;

	return s;
end;

function GetCreditCustom(TEXT,FONTNAME,FONTSCALE)
	local s = MakeCreditLabel(TEXT,FONTNAME,FONTSCALE);

	s=AddToCredits(s);
	s.x=s.x+1;
	s.y=s.y-1;
	s.font_colour = WHITE();
	AddElement(s);
end;

function AddCredit(text)
	GetCreditCustom(ProcessLanguage(text),nil,nil);
end;

function AddCreditImage(texture,width,height)
	local s = {
		type=TYPE_ELEMENT,
		anchor={top=true,bottom=false,left=false,right=false},
		x=credits.width/2-width/2,
		width=width,
		height=height,
		texture=texture,
		colour1=WHITE(),
	}

	AddToCredits(s);
end;

function AddCreditImageOffset(texture,width,height,rightalign,offset,creditheight)
	local xo = 0;
	if (rightalign) then
		xo = credits.width-offset-width;
	else
		xo = offset;
	end;

	local s = {
		type=TYPE_ELEMENT,
		anchor={top=true,bottom=false,left=not rightalign,right=rightalign},
		x=xo,
		width=width,
		height=height,
		texture=texture,
		colour1=WHITE(),
	}

	AddToCredits(s);
	credits.height = credits.height-height+creditheight;
end;

function AddCreditSpace()
	credits.height = credits.height+creditsspace;
end;

function CreditGetLoc(VALUE)
	CreditLocValue = loc(VALUE);
end;

CreditLocValue = '';
function CreditExtractLoc(DATA)
    runstring('CreditGetLoc('..DATA..')');
	return CreditLocValue;
end;

function ProcessLanguage(DATA)
	local value = '';
	d = {FIRST='',REST=DATA};
	repeat
		d = getFirstRest(d.REST,' ');
		if SGUI_widesub(d.FIRST,1,3) == 'TID' then
			d.FIRST = CreditExtractLoc(d.FIRST);
		end;

		if value == '' then
			value = value..d.FIRST;
		else
			value = value..' '..d.FIRST;
		end;

	until (d.REST == '');

    return value;
end;

-- AddCreditCustom() should be modified to handle any custom credits you want.
-- usage is :C> and then the LUA code you want to send to AddCreditCustom()
function AddCreditCustom(DATA)
		local d = getFirstRest(DATA,' ');

		if d.FIRST == 'T' then
			GetCreditCustom('#C65ccd4'..ProcessLanguage(d.REST)..'#C-00001',nil,nil);
		elseif d.FIRST == 'TB' then
			GetCreditCustom('#C65ccd4'..ProcessLanguage(d.REST)..'#C-00001',nil,0.8);
		elseif d.FIRST == 'RT' then
			GetCreditCustom('#CFFFFFF'..ProcessLanguage(d.REST)..'#C-00001',nil,nil);
		elseif d.FIRST == 'R' then
			GetCreditCustom('#CDDDDDD'..ProcessLanguage(d.REST)..'#C-00001',nil,0.4);
		end;
end;

credits.ticktime = 0;

function CreditsTick(FRAMETIME)
	if (getVisible(credits)) then
        	credits.ticktime = credits.ticktime + FRAMETIME;

                while credits.ticktime > 0.02 do
                	credits.ticktime = credits.ticktime - 0.02;
                        credits.y = credits.y - 1;
                end;

		if (credits.y < 0-credits.height) then
			credits.y=ScrHeight+20;
		end;

		sgui_set(credits.ID,PROP_Y,credits.y);
	end;
end;

--[[
function CreditsTick(FrameTime)
	if (getVisible(credits)) then
		credits.y=credits.y-(FrameTime*100);

		if (credits.y < 0-credits.height) then
			credits.y=ScrHeight+20;
		end;

		sgui_set(credits.ID,PROP_Y,Int(credits.y));
	end;
end;
--]]

function ShowCredits()
	credits.y = ScrHeight+20;
	sgui_set(credits.ID,PROP_Y,credits.y);
        setVisible(logo,false);
        setVisible(credits,true);
        showVersion(false);
end;

function HideCredits()
        setVisible(logo,true);
        setVisible(credits,false);
        showVersion(true);
end;

function ClearCredits()
	credits.height = 0;
	credits.y      = ScrHeight+20;
end;

AddCreditImage('logo.png',150,39);
AddCreditSpace();
AddCreditSpace();
AddCredit('My Test');
AddCreditSpace();
AddCredit('Some Guy');
AddCredit('Someone Else');
AddCredit('Another Person');
AddCreditSpace();
AddCreditSpace();
AddCredit('My Test2');
AddCreditSpace();
AddCredit('Some Guy2');
AddCredit('Someone Else2');
AddCredit('Another Person2');

OW_loadcredits(credits.ID,'credits/test');
