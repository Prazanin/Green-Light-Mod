local aspect = ScrWidth / ScrHeight;
if aspect <= 1.5 then
	aspect = '_c';
else aspect = '_w';
end;

interface = {};
interface.alien = {};
interface.alien.side = 'Alien';
interface.alien.game = {};
interface.amer = {};
interface.amer.side = 'Amer';
interface.amer.game = {};
interface.arab = {};
interface.arab.side = 'Arab';
interface.arab.game = {};
interface.rus  = {};
interface.rus.side = 'Rus';
interface.rus.game = {};
interface.current = {};

curSide = 'Amer';

interface.amer.dialog = {
	button      = SetupDialogButton(curSide,Tahoma_14,RGB(255,255,255),RGB(255,255,255)),
	buttonDebrief      = SetupDialogButton(curSide,Tahoma_14,RGB(255,255,255),RGB(255,255,255)),
	buttondd    = SetupDialogButtonDD(),
	background  = '/SGUI/'..curSide..'/textura03.png',
	background2 = '/SGUI/'..curSide..'/textura01.png',
	pad         = {texture='/SGUI/'..curSide..'/pad.png',d=XYWH(10,85,320,240),height=420},
	medal       = '/SGUI/'..curSide..'/m',
	medals      = {[1]=XYWH(0,0,115,240),[2]=XYWH(115,0,85,240),[3]=XYWH(200,0,120,240),[4]=XYWH(110,170,100,70),},
	border      = SetupDialogBorderHalf(Coord(63,62),Coord(0,0)),
        combo       = {[1]=RGB(16,32,24),[2]=RGB(34,90,76),[3]=RGB(250,249,254),[4]=RGB(231,255,255),},
}

interface.amer.debrief = {
	win = '/SGUI/' .. curSide .. '/deb_multi_win'.. aspect..'.png',
	lose = '/SGUI/' .. curSide .. '/deb_multi_lose'.. aspect..'.png',
	sideBox = 'SGUI/'.. curSide .. '/deb_debriefbox.png',
};


interface.amer.game.ui = {
	toolBtns   = SetupToolBtns(curSide,140,1,49,23,14), --Side, X, Y, W, H, Step
	commBtns   = SetupCommBtns(curSide,2,0,41,41),
	toolBar    = Coord(517,54),
	pause      = XYWH(13,6,36,39),
	minimap    = {BACK = Coord(248,245), MAP = XYWH(34,43,202,201), COLOUR = RGB(63,78,47)},
	infopanel  = Coord(200,245),
	commpanel  = SetupCommPanel('CommPanel1.png','CommPanel2.png','CommPanel3.png',154,192),
	facepanel  = SetupFacePanel(9,9,192), -- (FacePanelL Width, FacePanelR Width, Height)
	facearea   = XY(10,10),
	hintbar    = SetupHintBar(362,211,22,Coord(12,-3)), -- L Width, R Width, H, X/Y of Hint Placement
	buttons    = '/SGUI/'..curSide..'/buttons.png',
	resbar     = {width=507,x1=57,w1=49,w2=106,y1=6,h1=13,x2=351,w3=135,fontcol1=RGB(200,200,200),fontcol2=RGB(255,0,0)},
	scrollsize = 16,
	boxcols    = {border=RGB(76,148,128),background=RGB(16,31,24)},
	infocolour = RGB(61,204,0), --RGB(86,173,134),
        paramoff   = 0,
        combooff   = -6,
        rewardlist = XYWH(328-15,76,631+30,600),
        rewardinner = XY(17,320),
        rewardhint  = 230,
        rewardcap  = XY(320,18),
        undobutton = XY(14,6),
        redobutton = XY(35,6),
        speed      = XY(10,31),
	dip= {
		frame = 'SGUI/'..curSide..'/dip_sidePanel.png',
		back_req = 'SGUI/'..curSide..'/dip_request_back.png',
		left_req= 'SGUI/'..curSide..'/dip_request_left.png',
		right_req = 'SGUI/'..curSide..'/dip_request_right.png',
	},
        charselect = {enablecol=RGB(71,233,201),disablecol=RGB(127,127,127),butW=77,butH=27,area=XYWH(279,31,732,660),topH=135,
        	      captionarea=XYWH(0,18,320,39),detailsarea=XYWH(15,80,230,50),infoarea=XYWH(17,320,230,400)},
	chat = {
		sidecheckbox = 'SGUI/'.. curSide .. '/deb_debriefbox.png',
		allcheckbox =  'SGUI/'.. curSide .. '/chat_allcheck.png',
		friendcheckbox =  'SGUI/'.. curSide .. '/chat_friendcheck.png',
		allycheckbox =  'SGUI/'.. curSide .. '/chat_allycheck.png',
		customcheckbox =  'SGUI/'.. curSide .. '/chat_customcheck.png',
	},
}



curSide = 'Alien';
interface.alien.dialog = copytable(interface.amer.dialog);

interface.alien.dialog.button = SetupDialogButton(curSide,Tahoma_14,RGB(255,255,255),RGB(255,255,255));
interface.alien.dialog.buttonDebrief = SetupDialogButton(curSide,Tahoma_14,RGB(255,255,255),RGB(255,255,255));
interface.alien.dialog.buttondd    = SetupDialogButtonDD();
interface.alien.dialog.background  = '/SGUI/'..curSide..'/textura03.png';
interface.alien.dialog.background2 = '/SGUI/'..curSide..'/textura01.png';
interface.alien.dialog.border      = SetupDialogBorderHalf(Coord(63,62),Coord(0,0));
interface.alien.dialog.combo       = {[1]=RGB(32,32,32),[2]=RGB(90,90,90),[3]=RGB(250,250,250),[4]=RGB(10,10,10),};


interface.alien.game.ui = copytable(interface.amer.game.ui);

interface.alien.game.ui.boxcols    = {border=RGB(200,200,200),background=RGB(31,31,31)};

interface.alien.debrief = {
	sideBox = 'SGUI/'.. curSide .. '/deb_debriefbox.png',
	win = '/SGUI/' .. curSide .. '/deb_multi_win'.. aspect..'.png',
	lose = '/SGUI/' .. curSide .. '/deb_multi_lose'.. aspect..'.png',
};

curSide = 'Arab';

interface.arab.dialog = {
	button      = SetupDialogButton(curSide,Tahoma_14,RGB(255,255,255),RGB(255,255,255)),
	buttonDebrief      = SetupDialogButtonDebrief(curSide,Tahoma_14,RGB(255,255,255),RGB(255,255,255)),
        buttondd    = SetupDialogButtonDD(),
	background  = '/SGUI/'..curSide..'/textura03.png',
	background2 = '/SGUI/'..curSide..'/pad_back.png',
	pad         = {texture='',d=XYWH(0,101+38-77,350,200),colour1=BLACKA(0),height=343},
	medal       = '/SGUI/'..curSide..'/m',
	medals      = {[1]=XYWH(0,0,111,133),[2]=XYWH(111,-1,117,133),[3]=XYWH(228,0,113,133),[4]=XYWH(111,170+1-38,117,50),},
	border      = SetupDialogBorderALL(Coord(50,50)),
        combo       = {[1]=RGB(0,0,0),[2]=RGB(140,107,55),[3]=RGB(244,228,212),[4]=RGB(255,255,255),},
        border2     = {Side = 'Arab',
                       TL = XYWH(-40,-34,70,70), TR = XYWH(-30,-34,70,70), BL = XYWH(-40,-34,70,70), BR = XYWH(-30,-34,70,70),
                       T = XYWH(30,-34,-60,70), B = XYWH(30,-34,-60,70), L = XYWH(-40,28,70,-60), R = XYWH(-30,28,70,-60),
                      },
}

interface.arab.debrief = {
	sideBox = 'SGUI/'.. curSide .. '/deb_debriefbox.png',
	win = '/SGUI/' .. curSide .. '/deb_multi_win'.. aspect..'.png',
	lose = '/SGUI/' .. curSide .. '/deb_multi_lose'.. aspect..'.png',
};

interface.arab.game.ui = {
	toolBtns   = SetupToolBtns(curSide,77,3,53,19,5), --Side, X, Y, W, H, Step
	commBtns   = SetupCommBtns(curSide,8,26,41,41),
	toolBar    = Coord(667,74),
	pause      = XYWH(0,0,77,74),
	minimap    = {BACK = Coord(240,241), MAP = XYWH(22,40,203,200), COLOUR = RGB(63,78,47)},
	infopanel  = Coord(187,241),
	commpanel  = SetupCommPanel('CommPanel1.png','CommPanel2.png','CommPanel3.png',142,197),
	facepanel  = SetupFacePanel(160,53,197), -- (FacePanelL Width, FacePanelR Width, Height)
	facearea   = XY(10,10),
	hintbar    = SetupHintBar(301,267,43,Coord(187-19*2,18)), -- L Width, R Width, H, X/Y of Hint Placement
	buttons    = '/SGUI/'..curSide..'/buttons.png',
	resbar     = {width=394,x1=35,w1=33,w2=87,y1=2,h1=13,x2=287,w3=101,fontcol1=RGB(200,200,200),fontcol2=RGB(255,0,0)},
	scrollsize = 10,
	boxcols    = {border=RGB(181,146,90),background=RGB(41,23,23)},
	infocolour = RGB(255,229,189),
        paramoff   = -8,
        combooff   = 4,
        rewardlist = XYWH(328+30,76+14+3,631,600),
        rewardinner = XY(17+20,320+40),
        rewardhint  = 230+35,
        rewardcap  = XY(320-20,18+14),
        undobutton = XY(14,6),
        redobutton = XY(18,6),
        speed      = XY(14,26),
	dip= {
		frame = 'SGUI/'..curSide..'/dip_sidePanel.png',
		back_req = 'SGUI/'..curSide..'/dip_request_back.png',
		left_req= 'SGUI/'..curSide..'/dip_request_left.png',
		right_req = 'SGUI/'..curSide..'/dip_request_right.png',
	},
        charselect = {enablecol=WHITE(),disablecol=WHITE(),butW=85,butH=32,area=XYWH(357+5,91,626,607),topH=165,
        	      captionarea=XYWH(13,42,273,33),detailsarea=XYWH(13,81,273,186),infoarea=XYWH(19,346,269,374)},
	chat = {
		sidecheckbox = 'SGUI/'.. curSide .. '/deb_debriefbox.png',
		allcheckbox =  'SGUI/'.. curSide .. '/chat_allcheck.png',
		friendcheckbox =  'SGUI/'.. curSide .. '/chat_friendcheck.png',
		allycheckbox =  'SGUI/'.. curSide .. '/chat_allycheck.png',
		customcheckbox =  'SGUI/'.. curSide .. '/chat_customcheck.png',
	},
}

curSide = 'Rus';

interface.rus.dialog = {
	button      = SetupDialogButton(curSide,Tahoma_14,RGB(255,255,255),RGB(255,255,255)),
	buttonDebrief      = SetupDialogButton(curSide,Tahoma_14,RGB(255,255,255),RGB(255,255,255)),
        buttondd    = SetupDialogButtonDD(),
	background  = '/SGUI/'..curSide..'/textura03.png',
	background2 = '/SGUI/'..curSide..'/pad_back.png',
	pad         = {texture='',d=XYWH(0,101+38-77,350,200),colour1=BLACKA(0),height=343},
	medal       = '/SGUI/'..curSide..'/m',
	medals      = {[1]=XYWH(0,0,111,133),[2]=XYWH(111,0,117,133),[3]=XYWH(228,0,113,133),[4]=XYWH(111,170+1-38,117,50),},
	border      = SetupDialogBorderALL(Coord(50,50)),
        combo       = {[1]=RGB(0,0,0),[2]=RGB(128,7,14),[3]=RGB(244,228,212),[4]=RGB(255,205,200),},
        border2     = {Side = 'Rus',
                       TL = XYWH(-40,-34,70,70), TR = XYWH(-30,-34,70,70), BL = XYWH(-40,-34,70,70), BR = XYWH(-30,-34,70,70),
                       T = XYWH(30,-34,-60,70), B = XYWH(30,-34,-60,70), L = XYWH(-40,28,70,-60), R = XYWH(-30,28,70,-60),
                      },
}

interface.rus.debrief = {
	sideBox = 'SGUI/'.. curSide .. '/deb_debriefbox.png',
	win = '/SGUI/' .. curSide .. '/deb_multi_win'.. aspect..'.png',
	lose = '/SGUI/' .. curSide .. '/deb_multi_lose'.. aspect..'.png',
};

interface.rus.game.ui = {
	toolBtns   = SetupToolBtns(curSide,77,3,54,19,5), --Side, X, Y, W, H, Step
	commBtns   = SetupCommBtns(curSide,6,16,41,41),
	toolBar    = Coord(667,74),
	pause      = XYWH(0,0,77,74),
	minimap    = {BACK = Coord(240,241), MAP = XYWH(22,40,203,200), COLOUR = RGB(63,78,47)},
	infopanel  = Coord(187,241),
	commpanel  = SetupCommPanel('CommPanel1.png','CommPanel2.png','CommPanel3.png',142,197),
	facepanel  = SetupFacePanel(99,118,197), -- (FacePanelL Width, FacePanelR Width, Height)
	facearea   = XY(20,10),
	hintbar    = SetupHintBar(341,224,34,Coord(187-19-3,8)), -- L Width, R Width, H, X/Y of Hint Placement
	buttons    = '/SGUI/'..curSide..'/buttons.png',
	resbar     = {width=394,x1=35,w1=33,w2=87,y1=4,h1=13,x2=287,w3=101,fontcol1=RGB(200,200,200),fontcol2=RGB(255,0,0)},
	scrollsize = 10,
	boxcols    = {border=RGB(81,121,87),background=RGB(0,0,0)},
	infocolour = RGB(255,229,189),
        paramoff   = -8,
        combooff   = 0,
        rewardlist = XYWH(328+30,76+14,631,600),
        rewardinner= XY(17+20,320+40),
        rewardhint = 230+35,
        rewardcap  = XY(320-20,18+14),
        undobutton = XY(14,6),
        redobutton = XY(18,6),
        speed      = XY(14,26),
	dip= {
		frame = 'SGUI/'..curSide..'/dip_sidePanel.png',
		back_req = 'SGUI/'..curSide..'/dip_request_back.png',
		left_req= 'SGUI/'..curSide..'/dip_request_left.png',
		right_req = 'SGUI/'..curSide..'/dip_request_right.png',
	},
        charselect = {enablecol=WHITE(),disablecol=WHITE(),butW=85,butH=32,area=XYWH(357+5,91,626,607),topH=165,
        	      captionarea=XYWH(13,42,273,33),detailsarea=XYWH(13,81,273,186),infoarea=XYWH(19,346,269,374)},
	chat = {
		sidecheckbox = 'SGUI/'.. curSide .. '/deb_debriefbox.png',
		allcheckbox =  'SGUI/'.. curSide .. '/chat_allcheck.png',
		friendcheckbox =  'SGUI/'.. curSide .. '/chat_friendcheck.png',
		allycheckbox =  'SGUI/'.. curSide .. '/chat_allycheck.png',
		customcheckbox =  'SGUI/'.. curSide .. '/chat_customcheck.png',
	},
}

interface.current = interface.alien;

Loading_SidePos = {};
Loading_SidePos[0] = { -- Alien
	Name  = XYWH(28,35,400,25),
	Coord = XYWH(28,70,400,25),
	Brief = XYWH(781,572,205,168),
}

Loading_SidePos[1] = { -- American
	Name  = XYWH(28,35,400,25),
	Coord = XYWH(28,70,400,25),
	Brief = XYWH(781,572,205,168),
}

Loading_SidePos[2] = { -- Russian
	Name  = XYWH(60,40,365,22),
	Coord = XYWH(60,70,365,22),
	Brief = XYWH(57,575,200,160),
}

Loading_SidePos[3] = { -- Arabian
	Name  = XYWH(60,40,365,22),
	Coord = XYWH(60,70,365,22),
	Brief = XYWH(57,575,200,160),
}
