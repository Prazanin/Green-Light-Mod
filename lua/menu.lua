-----------------------------------------------------------------------------
---  Orig. File : /lua/menu.lua
---  Version    : 49
---
---  Summary    : First Lua - inicializing
---
---  Created    : Stuart 'Stucuk' Carey, OW Support
---               Petr 'Sali' Salak, Freya Group
------------------------------------------------------------------------------

--| Includes |--

default_font = 'Trebuchet MS_70_Fixed_16_2.DFF;0.5;0.2;0.6;0';

include('ident'); -- Localization IDs

include('Utils/utils','constants','Utils/interface_utils','Utils/dialog_utils','Utils/callbacks','Utils/element_skinned','Utils/sound'); --helper
tempelement={};


include('Utils/radios','Utils/combobox','Utils/sliders','Utils/elementevent','Utils/timer','Utils/elements'); --helper functions

include('Utils/deprecated');

include('mod_utils'); -- If you want change something (like constants) before building interface

include('interface'); --interface settings

include('customcommandsystem');
include('Menu/loadsave');
include('InGame/dialogs');

include('Menu/window_mainmenu','Menu/window_options','Menu/window_credits','Menu/window_campaigns','Menu/window_skirmish','Menu/window_profiles','Menu/window_mods', 'Menu/window_tutorial', 'Menu/window_achievements',
        'Menu/window_multiplayer','Menu/window_lobby','Menu/window_multiroom','Menu/window_multidebrief');
include('InGame/game_main','InGame/game_diplomacy','InGame/game_waitfor','InGame/game_resourcebar','InGame/game_info','InGame/game_loading','InGame/game_score','InGame/game_team_skills','InGame/game_team_select','InGame/game_alt_factory',
        'InGame/game_team_review','InGame/game_options','InGame/game_mission_debriefing','floating_hints','cutscene','logos');

include('tutorial_hints');
if DeveloperMode then
	include('devmode');
end;

--| Misc |--

bringToFront(profilebar);
bringToFront(profileAvatar);
ChangeInterface(0);

fpscounter = getLabelEX(nil,anchorLTR,XYWH(0,0,LayoutWidth,20),Tahoma_10B,'',{text_halign=ALIGN_MIDDLE,special=true,font_style_outline=true,shadowtext=false,font_colour=RGB(250,250,250)});

function FROMOW_FPSCOUNTER(DATA)
    setText(fpscounter,DATA);
end;


regTickCallback('CreditsTick(%frametime);');
regTickCallback('ElementEventTick(%frametime);');
regTickCallback('TimerTick(%frametime);');
regTickCallback('MultiplayerLobby_Idle();');
regTickCallback('InGameChatTick(%frametime);');
regTickCallback('Multiplayer_WAITFOR(%frametime);');

-- After SGUI is loaded this is called.
function Init()
	-- Note: gettext is now deprecated use getvalue instead.
	-- getvalue(OWV_ISMOD) returns true/false if a mod is loaded
	-- getvalue(OWV_MODVER) gives the mod version as a string
	-- getvalue(OWV_DEVMODE) returns true/false if developer mode is on
	-- getvalue(OWV_ISEDITOR) returns true/false if we are in the Editor or game
	-- getvalue(OWV_STEAMUSERNAME) returns Steam Username
	-- getvalue(OWV_USERNAME) returns OWV_STEAMUSERNAME if set or OWV_PROFILE if not
	-- getvalue(OWV_PROTOCOLVERSION) returns Multiplayer Protocol Version

	if getvalue(OWV_ISMOD) then
		setText(version,loc_format(TID_Main_Menu_Version,{getvalue(OWV_VERSION)}) );
                setFontName(version, Neuropol)
                setFontScale(version, 0.45)
                setFontColour(version, GREEN())

                setText(mod_version,loc_format(TID_Main_Menu_ModVersion,{getvalue(OWV_MODVER)}) );
                setFontName(mod_version, Neuropol)
                setFontScale(mod_version, 0.45)
                setFontColour(mod_version, GREEN())
	else
		setText(version,loc_format(TID_Main_Menu_Version,{getvalue(OWV_VERSION)}) );
	end;

	setText(profile_label, string.sub(getvalue(OWV_PROFILE), 0, 20));

	--setTexture(profile_avatar, 'Avatars/'.. selectedAvatar .. '.png');
	--setTexture(Multi_Room.Profile.Avatar, 'Avatars/'.. selectedAvatar .. '.png');
end;

function Err(text)
	OW_ERROR(text);
end;

function backToMenu_lite()
		setVisible(game,false);
		setVisible(menu,true);
		OW_menumusic(true);
end;

function backToMenu()
		backToMenu_lite();
		-- Add Each Menu Area's "backToMenu" here!
		backToMenu_Campaign();
		--backToMenu_Multiplayer();
end;

function FROMOW_BACKTOMENU()
        backToMenu();
end;

function FROMOW_DOLOGOS() -- Called by game when Skip is false
	setVisible(menu,false)
	setVisible(logos,true);
	OW_menumusic(false);
	OW_hidemouse(true);
	setFocus(logos);
	playLogo(0); -- See logos.lua
        OW_SET_VSYNC_VIDEOMODE(true);
end;

function endLogos() -- Called by lua when logos are over
	clearFocus();
	setVisible(logos,false);
	setVisible(menu,true);
	OW_menumusic(true);
	OW_hidemouse(false);
        OW_SET_VSYNC_VIDEOMODE(false);
end;

function FROMOW_STEAM_FIRSTFRAME() -- Called by game after the first frame
	steam_init();
        ReloadAvatar();
end;

function FROMOW_SGUI_RESTART() -- Called just before SGUI is restarted
        changeHero.freeAvatarTexture();
        MULTIROOM_FREEAVATARS();
end;

--AddSingleUseTimer(0.1,'ReloadAvatar();');
ReloadAvatar();

include('mod'); -- MUST BE LAST LINE!

