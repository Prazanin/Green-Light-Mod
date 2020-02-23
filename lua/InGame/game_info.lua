game.ui.infopanel.inner = getBlankElementA(game.ui.infopanel,anchorTLBR);
setVisible(game.ui.infopanel.inner,false);

game.ui.infopanel.inner.skillicons    = {};
game.ui.infopanel.inner.skilliconspip = {};
game.ui.infopanel.inner.text          = {};
game.ui.infopanel.inner.values        = {};

game.ui.infopanel.inner.img       = getBlankImage(game.ui.infopanel.inner,anchorLT,false,false);
game.ui.infopanel.inner.img.icon  = getBlankImage(game.ui.infopanel.inner.img,anchorLT,true,true);
game.ui.infopanel.inner.driverimg = getBlankImage(game.ui.infopanel.inner,anchorLT,false,false);

set_Callback(game.ui.infopanel.inner.img.ID,CALLBACK_MOUSECLICK,'OW_INFO_SWAPUNIT()');
set_Callback(game.ui.infopanel.inner.driverimg.ID,CALLBACK_MOUSECLICK,'OW_INFO_SWAPUNIT()');

game_info = {};

function game_info.SetInfoSkillIconsCoords(i,v)
	setSubCoords(game.ui.infopanel.inner.skillicons[i],SUBCOORD(28*v,20*(i-1),28,20));
end;

function game_info.SetInfoSkillIconsPip2(i,w,tex)
	setInterfaceTexture(game.ui.infopanel.inner.skilliconspip[i],tex);
	setSubCoordsWH(game.ui.infopanel.inner.skilliconspip[i],SUBCOORD(0,0,w,9),w,9);
end;

function game_info.SetInfoSkillIconsPip(i,v,sk)
	if (v == 0) then
		game_info.SetInfoSkillIconsPip2(i,3*sk,'Human SkillBar.png');
	else
		game_info.SetInfoSkillIconsPip2(i,5*sk,'Human SkillBarDouble.png');
	end;
end;

game.ui.infopanel.inner.paramicons    = getBlankElement(game.ui.infopanel.inner,anchorLT);
game.ui.infopanel.inner.budparamicons = getBlankElement(game.ui.infopanel.inner,anchorLT);

for i=1,4 do
	game.ui.infopanel.inner.skillicons[i] = getBlankImage(game.ui.infopanel.inner,anchorLT,true,true);

	game_info.SetInfoSkillIconsCoords(i,0);

	game.ui.infopanel.inner.skilliconspip[i] = getBlankImage(game.ui.infopanel.inner,anchorLT,true,true);
	game_info.SetInfoSkillIconsPip(i,0,0);
end;

game.ui.infopanel.inner.health     = makeHealthBar(game.ui.infopanel.inner);
game.ui.infopanel.inner.health2    = makeHealthBar(game.ui.infopanel.inner);

game.ui.infopanel.inner.params     = {};

for i=1,5 do
	game.ui.infopanel.inner.params[i] = getBlankLabel(game.ui.infopanel.inner,anchorLT,Tahoma_12,'');
        setTextHAlign(game.ui.infopanel.inner.params[i],ALIGN_MIDDLE);
end;

for i=1,5 do
	game.ui.infopanel.inner.text[i]   = getBlankLabel(game.ui.infopanel.inner,anchorLT,Tahoma_12,'');
	game.ui.infopanel.inner.values[i] = getBlankLabel(game.ui.infopanel.inner,anchorLT,Tahoma_12,'');
	setTextHAlign(game.ui.infopanel.inner.values[i],ALIGN_RIGHT);
end;

game.ui.infopanel.inner.skillsover = getBlankElementA(game.ui.infopanel.inner,anchorNone);
setMouseCallback_MoveLeave(game.ui.infopanel.inner.skillsover,'game_info.updateInfoMouseOver();');
set_Callback(game.ui.infopanel.inner.skillsover.ID,CALLBACK_MOUSECLICK,'game.ui.infopanel.inner.skillsover.onClick();');
game.ui.infopanel.inner.paramsover = getBlankElementA(game.ui.infopanel.inner,anchorNone);
setMouseCallback_MoveLeave(game.ui.infopanel.inner.paramsover,'game_info.updateInfoMouseOver();');

function game.ui.infopanel.inner.skillsover.onClick()
	local inner = game.ui.infopanel.inner;

	if (not getVisible(inner) or InfoPanelLastData.ID == 0) then
		return;
	end;

	if isMouseOverElement(inner.skillsover) then
		OW_INFO_SKILLHINTCLICK(minmax(roundup(getMouseOverElementY(inner.skillsover)/21),1,4));
	end;
end;

function game_info.getImgText(theparent,w,h,tw)
	local element;

	element = getBlankElementA(theparent,anchorTL);
	setWHV(element,w+tw+5,h);
	element.img = getBlankImage(element,anchorLT,true,false);
	setWHV(element.img,w,h);
	element.text = getBlankLabel(element,anchorLT,Tahoma_13,'');
	setXYWHV(element.text,w+5,0,tw,h);

	setNoMouseEvent(element.img,true);
	setNoMouseEvent(element.text,true);

	return element;
end;

game.ui.infopanel.inner.budinfo = {};

for i=1,4 do
	game.ui.infopanel.inner.budinfo[i] = game_info.getImgText(game.ui.infopanel.inner,16,16,20);
end;

setHint(game.ui.infopanel.inner.budinfo[1],loc(TID_IP_Building_Level));
setHint(game.ui.infopanel.inner.budinfo[2],loc(TID_IP_Building_Defend));
setHint(game.ui.infopanel.inner.budinfo[3],loc(TID_IP_Building_Occupation));
setHint(game.ui.infopanel.inner.budinfo[4],loc(TID_IP_Building_Power));

game.ui.infopanel.inner.budbars = {};

for i=1,5 do
	game.ui.infopanel.inner.budbars[i] = makeImageBarWithCaption(game.ui.infopanel.inner,ADMUI3S,'');
	setXYWHV(game.ui.infopanel.inner.budbars[i].progress,0,15,148,9);
	setXYWHV(game.ui.infopanel.inner.budbars[i].label,0,0,148,15);
end;

setText(game.ui.infopanel.inner.budbars[1].label,loc(TID_IP_Build_progress));
setText(game.ui.infopanel.inner.budbars[2].label,loc(TID_IP_Construct_progress));
setText(game.ui.infopanel.inner.budbars[3].label,loc(TID_IP_Construct_progress));
--setText(game.ui.infopanel.inner.budbars[4].label,'');
setText(game.ui.infopanel.inner.budbars[5].label,loc(TID_IP_Upgrade_progress));

game.ui.infopanel.inner.icon_lab1 = getBlankImage(game.ui.infopanel.inner,anchorLT,true,true);
game.ui.infopanel.inner.icon_lab2 = getBlankImage(game.ui.infopanel.inner,anchorTR,true,true);

game.ui.infopanel.inner.queue = getBlankElementA(game.ui.infopanel.inner,anchorLBR);
game.ui.infopanel.inner.queue.progress = makeImageBar(game.ui.infopanel.inner.queue);
setXYWHV(game.ui.infopanel.inner.queue.progress,2,32,148,9);
game.ui.infopanel.inner.queue.icons = {};

for i=1,5 do
 game.ui.infopanel.inner.queue.icons[i] = getBlankImage(game.ui.infopanel.inner.queue,anchorLT,true,false);

 if (i == 1) then
  setXYWHV(game.ui.infopanel.inner.queue.icons[i],0,0,38,30);
 else
  setXYWHV(game.ui.infopanel.inner.queue.icons[i],(i-2)*38,30+14,38,30);
 end;
end;

game.ui.infopanel.inner.queue.labels = {};

for i=1,3 do
        game.ui.infopanel.inner.queue.labels[i] = getBlankLabel(game.ui.infopanel.inner.queue,anchorLT,Tahoma_10,'');

	setScrollText(game.ui.infopanel.inner.queue.labels[i],true);
	setScissor(game.ui.infopanel.inner.queue.labels[i],true,0);

        setXYWHV(game.ui.infopanel.inner.queue.labels[i],40,(i-1)*10-2,113,15);
end;

game.ui.infopanel.inner.extensions = getBlankElementA(game.ui.infopanel.inner,anchorTLR);
game.ui.infopanel.inner.extensions.icons = {};

for i=1,5 do
 game.ui.infopanel.inner.extensions.icons[i] = getBlankImage(game.ui.infopanel.inner.extensions,anchorLT,true,true);

 setXYWHV(game.ui.infopanel.inner.extensions.icons[i],(i-1)*28,0,28,28);
end;

function getIconTypeIndex(IT)
        if (IT == nil) or (IT <= -1) then
                return -1;
        else
                return OW_GETICONTYPEINDEX(IT);
        end;
end;

function BudLab2IT(KIND)
        if (KIND <= -1) then
                return -1;
        end;

        BTID = -1;

        switch(KIND) : caseof {
			[bud_lab_basic]             = function (x) BTID = IT_B_BasicLab; end,
                        [bud_lab_weapon]            = function (x) BTID = IT_LabWeapon; end,
                        [bud_lab_siberium]          = function (x) BTID = IT_LabSiberium; end,
                        [bud_lab_computer]          = function (x) BTID = IT_LabComputer; end,
                        [bud_lab_biological]        = function (x) BTID = IT_LabBio; end,
                        [bud_lab_spacetime]         = function (x) BTID = IT_LabSpace; end,
                        [bud_lab_optoelectronics]   = function (x) BTID = IT_LabOpto; end,
		};

        return BTID;
end;

function GetExtensionIcon(KIND)
        if (KIND <= -1) then
                return -1;
        end;

        BTID = -1;

        switch(KIND) : caseof {
			[bud_ext_track]             = function (x) BTID = IT_FE_Track; end,
                        [bud_ext_gun]               = function (x) BTID = IT_FE_Gun; end,
                        [bud_ext_rocket]            = function (x) BTID = IT_FE_Rocket; end,
                        [bud_ext_noncombat]         = function (x) BTID = IT_FE_NonCombat; end,
                        [bud_ext_radar]             = function (x) BTID = IT_FE_Radar; end,
                        [bud_ext_siberium]          = function (x) BTID = IT_FE_Siberium; end,
                        [bud_ext_radio]             = function (x) BTID = IT_FE_Radio; end,
                        [bud_ext_stitch]            = function (x) BTID = IT_FE_Stitching; end,
                        [bud_ext_computer]          = function (x) BTID = IT_FE_Computer; end,
                        [bud_ext_laser]             = function (x) BTID = IT_FE_Laser; end,
		};

        return BTID;
end;

function SetLabIcon(ELEMENT,KIND,KINDNAME)
        ICON = getIconTypeIndex(BudLab2IT(KIND));
        if (ICON >= 0) then
                setSubCoords(ELEMENT,SUBCOORD(0,ICON*28,28,28));
 	        setVisible(ELEMENT,true);
                setHint(ELEMENT,KINDNAME);
        end;
end;

function SetLabIcons(KIND1,KIND2,KIND1NAME,KIND2NAME)
        SetLabIcon(game.ui.infopanel.inner.icon_lab1,KIND1,KIND1NAME);
        SetLabIcon(game.ui.infopanel.inner.icon_lab2,KIND2,KIND2NAME);
end;

function GetLabQueueIcon(ID)
        if (ID <= -1) then
                return getIconTypeIndex(BudLab2IT(-ID));
        else
                return getIconTypeIndex(_Tech2ITTable[ID]);
        end;
end;

--[[
	ID
	ID2                  - Driver
	TEXTURE
	TEXTURE2             - Driver
	TYP
	HEALTH
	HEALTH2              - Driver
	MAXHEALTH
	MAXHEALTH2           - Driver
	SIDE
	NATION
	ACTIVITY
	MORALDR              - Moral Flag Damage Reduction Percent
	CLASS                - Human
	SKILLICONS           - Human
	SKILLS               - Human
	SKILLSTEXT           - Human
        INSIDEUNIT           - Human (contains either building/vehicle data identical to the params found in this comment section)
	VALUES
	VALUESTEXT           - [1..5][1..4].TEXT & [1..5][1..4].VALUE (Buildings are [1..3][1..4])
	INFO                 - [1..5]
	KIND                 - Building
	KIND1                - Building (Lab 1)
	KIND2                - Building (Lab 2)
        KINDNAME             - Building (Kind Name)
        KIND1NAME            - Building (Kind1 Name)
        KIND2NAME            - Building (Kind2 Name)
	CONTROLLER           - Vehicle (Driver Type)
	BUDINFO              - Building [1..4]
	BUDISUPGRADE         - Building (Is it an upgraded building)
	PHASE                - Building
        CANATTACK
        RESEARCH             - Building (Current Research ID)
        RESEARCHNAME         - Building (Current Research Name)
        QUEUE                - Building
        QUEUECOUNT           - Building (Number in Queue)
        FACTORYCURRENTBUILD  - Building ([1..3] of String)
        PATROL               - Building (Used for Factory)
        EXTENSIONS           - Building ([1..5] of Kind)
        EXTENSIONSCOUNT      - Building (Amount of Extentions)
--]]


-- Human = 1, Vehicle = 2, Building = 3

infoimgsizes = {[1]={w=64,h=80},[2]={w=80,h=64},[3]={w=64,h=64}};
infoimgdsize = {w=51,h=64};

InfoPanelLastData = nil;
InfoPanelIsMouseOver = false;
InfoPanelBudBar = -1;

paramswidth = {[true]=49,[false]=29};
paramsdiv   = {[true]=5,[false]=3};

function game_info.updateInfoMouseOver()
	inner      = game.ui.infopanel.inner;

	if (not getVisible(inner) or InfoPanelLastData.ID == 0) then
		return;
	end;

	IsHuman    = InfoPanelLastData.TYP == 1;
    IsVehicle  = InfoPanelLastData.TYP == 2;
	IsBuilding = InfoPanelLastData.TYP == 3;
	InfoPanelIsMouseOver = true;

	setText(inner.text[1],'');

	if IsHuman and isMouseOverElement(inner.skillsover) then
			y = roundup(getMouseOverElementY(inner.skillsover)/21);

			if y < 1 then
				y = 1;
			end;

			for i=1,4 do
				setText(inner.text[i+1],InfoPanelLastData.SKILLSTEXT[y][i].TEXT);
				setText(inner.values[i+1],InfoPanelLastData.SKILLSTEXT[y][i].VALUE);
			end;
		else

			if (isMouseOverElement(inner.paramsover) and (not IsBuilding)) or (isMouseOverElement(inner.paramsover) and getVisible(inner.budparamicons)) then
				x = roundup(getMouseOverElementX(inner.paramsover)/paramswidth[IsBuilding]);

                                if IsBuilding then
                                	x = min(max(x,1),3);
                                else
                                	x = min(max(x,1),5);
                                end;

				if x < 1 then
					x = 1;
				end;

				for i=1,4 do
						setText(inner.text[i+1],InfoPanelLastData.VALUESTEXT[x][i].TEXT);
						setText(inner.values[i+1],InfoPanelLastData.VALUESTEXT[x][i].VALUE);
				end;
			else
				InfoPanelIsMouseOver = false;

				for i=1,5 do
                                	if (i == 2) and (InfoPanelLastData.KIND == bud_breast) then
						setText(inner.text[i],'');
                                	else
                                		setText(inner.text[i],InfoPanelLastData.INFO[i]);
                                	end;
				end;
			end;
		end;

	for i=1,5 do
		setVisible(inner.values[i],InfoPanelIsMouseOver);
	end;

	if InfoPanelBudBar > -1 then
		setVisible(inner.budbars[InfoPanelBudBar],not InfoPanelIsMouseOver);
	end;
end;

function setHealthColour(element,health)
	if health > 0.5 then
			setColour1(element,RGB(72,216,69));
	else
		if health >= 0.25 then
			setColour1(element,RGB(231,242,86));
		else
			setColour1(element,RGB(202,18,30));
		end;
	end;
end;

function selectComPanel(UNIT)
  local cp1 = false;
  local cp2 = false;
  local cp3 = false;

  if UNIT.KIND == nil then
    UNIT.KIND = -1;
  end;

  if UNIT.SIDE == getvalue(OWV_MYSIDE) then
   if UNIT.ACTIVITY == act_build then
    cp1 = true;
   else
    if isInArray(UNIT.KIND,bud_types_factory) then
     cp2 = true
    else
     if isInArray(UNIT.KIND,bud_types_bunker_weapon) then
       cp3 = true;
     else
       cp1 = true;
     end;
    end;
   end;
  else
   cp1 = true;
  end;

  setVisible(game.ui.commpanel1,cp1);
  setVisible(game.ui.commpanel2,cp2);
  setVisible(game.ui.commpanel3,cp3);
end;

function game_info.Update(Data)
	if (Data == nil) then InfoPanelLastData = nil; return; end;

	inner = game.ui.infopanel.inner;
	InfoPanelLastData = Data;

	if Data.INSIDEUNIT ~= nil then
		selectComPanel(Data.INSIDEUNIT);
	else
		selectComPanel(Data);
	end;

	if (Data.ID == 0) then
		setVisible(inner,false);
	else
		setVisible(inner,true);

		IsHuman    = Data.TYP == 1;
		IsNature   = IsHuman and Data.SIDE == 0 and isInArray(Data.CLASS,{class_tiger, class_baggie, class_fish, class_phororhacos, class_prakun, class_apeman});
		IsVehicle  = Data.TYP == 2;
		IsBuilding = Data.TYP == 3;

        IsLab = IsBuilding and (isInArray(Data.KIND,bud_types_lab));

		innerw = getWidth(inner)-20;
		innerh = getHeight(inner);

        OW_COMMCOMBOS_UPDATE();

		setTextureFromID(inner.img,Data.TEXTURE,infoimgsizes[Data.TYP].w,infoimgsizes[Data.TYP].h,infoimgsizes[Data.TYP].w,infoimgsizes[Data.TYP].h);

		start = innerh-202;

		if (IsVehicle and (Data.ID2 > 0)) then
			setTextureFromID(inner.driverimg,Data.TEXTURE2,infoimgsizes[1].w,infoimgsizes[1].h,infoimgsizes[1].w,infoimgsizes[1].h);
			setXYWHV(inner.driverimg,13+infoimgsizes[Data.TYP].w+5,start+5,infoimgdsize.w,infoimgdsize.h);
		end;

		setXYWHV(inner.img,13,start+5,infoimgsizes[Data.TYP].w,infoimgsizes[Data.TYP].h);

		setXYWHV(inner.health,13,start,infoimgsizes[Data.TYP].w,5);
		setHealthBarProgress(inner.health,Data.HEALTH/Data.MAXHEALTH);

		if (IsVehicle and (Data.ID2 > 0)) then
			setXYWHV(inner.health2,13+infoimgsizes[Data.TYP].w+5,start,infoimgdsize.w,5);
			setHealthBarProgress(inner.health2,Data.HEALTH2/Data.MAXHEALTH2);
			setHealthColour(inner.health2.bar,Data.HEALTH2/Data.MAXHEALTH2);
		end;

		if (IsVehicle and Data.CONTROLLER == controller_remote) then
			setSubCoords(inner.img.icon,SUBCOORD(0,28*33,28,28));
			setVisible(inner.img.icon,true);
		else
			setVisible(inner.img.icon,false);
		end;

		if IsHuman then
			for i=1,4 do
				setXYWHV(inner.skillicons[i],13+infoimgsizes[Data.TYP].w,start+1+20*(i-1),28,20);
				setXYWHV(inner.skilliconspip[i],13+infoimgsizes[Data.TYP].w+28,start+1+20*(i-1)+5,Data.SKILLS[i]*(3+Data.SKILLICONS[i]*2),9);
			end;

			setXYWHV(inner.skillsover,13+infoimgsizes[Data.TYP].w,start,28+50,83);
		end;

		for i=1,5 do
			setVisible(inner.budbars[i],false);
			setXYWHV(inner.budbars[i],13,start+infoimgsizes[Data.TYP].h+50,148,9+15);
		end;

		InfoPanelBudBar = -1;

                setVisible(game.ui.infopanel.inner.icon_lab1,false);
                setVisible(game.ui.infopanel.inner.icon_lab2,false);

                setVisible(game.ui.infopanel.inner.queue,false);
                setVisible(game.ui.infopanel.inner.extensions,false);

		if IsBuilding then
			for i=1,4 do
				setXYV(inner.budinfo[i],13+infoimgsizes[Data.TYP].w+10,start+1+16*(i-1));
                               	setText(inner.budinfo[i].text,Data.BUDINFO[i]);
				setVisible(inner.budinfo[i],Data.BUDINFO[i] ~= '');
			end;

                        if (Data.EXTENSIONSCOUNT >= 1) and isInArray(Data.KIND,bud_types_factory) then
                                setVisible(game.ui.infopanel.inner.extensions,true);
                                local d = 1;
                                for i=1,5 do
                                        setVisible(game.ui.infopanel.inner.extensions.icons[i],i <= Data.EXTENSIONSCOUNT);

                                        if (Data.EXTENSIONS[i].ID >= 0) then
                                                setSubCoords(game.ui.infopanel.inner.extensions.icons[d],SUBCOORD(0,getIconTypeIndex(GetExtensionIcon(Data.EXTENSIONS[i].ID))*28,28,28));
                                                setHint(game.ui.infopanel.inner.extensions.icons[d],Data.EXTENSIONS[i].NAME);
                                                d = d + 1;
                                        end;
                                end;
                        end;

			if isInArray(Data.ACTIVITY,{act_build,act_wait_for_weapon}) then
				if Data.ACTIVITY == act_build then
					if Data.BUDISUPGRADE then
							InfoPanelBudBar = 5;
						else
							InfoPanelBudBar = 1;
					end;
				else
					if Data.ACTIVITY == act_wait_for_weapon then
						InfoPanelBudBar = 3;
					else
                                                if Data.ACTIVITY == act_factory_construct then
                                                    InfoPanelBudBar = 1;
                                                else
						    InfoPanelBudBar = 4;
                                                end;
					end;
				end;

				setImageBarProgress(inner.budbars[InfoPanelBudBar].progress,Data.PHASE);
			else
        	                if IsLab then
	                                SetLabIcons(Data.KIND1,Data.KIND2,Data.KIND1NAME,Data.KIND2NAME);

                                	setText(game.ui.infopanel.inner.queue.labels[1],'');

                                        if (Data.ACTIVITY == 0) then
                                        	Data.RESEARCHNAME = '';
                                                Data.PHASE = 0;
                                        end;

                        	        setText(game.ui.infopanel.inner.queue.labels[2],Data.RESEARCHNAME);
                	                setText(game.ui.infopanel.inner.queue.labels[3],'');

        	                        if (Data.QUEUECOUNT >= 1) then
	                                        setText(game.ui.infopanel.inner.queue.labels[1],loc(TID_IP_Msg_Researching));
                                        	setVisible(game.ui.infopanel.inner.queue,true);
                                	        for i=1,5 do
                        	                  if (Data.QUEUE[i].ID == -1) or (Data.QUEUE[i].ID == 0) then
                	                                  setVisible(game.ui.infopanel.inner.queue.icons[i],false);
        	                                  else
	                                                  setVisible(game.ui.infopanel.inner.queue.icons[i],true);
                                        	          setInterfaceTexture(game.ui.infopanel.inner.queue.icons[i],'Buttons Small.png');
                                                	  setHint(game.ui.infopanel.inner.queue.icons[i],Data.QUEUE[i].NAME);
                                	                  setSubTexture(game.ui.infopanel.inner.queue.icons[i],true);
                        	                          setSubCoords(game.ui.infopanel.inner.queue.icons[i],SUBCOORD(0,GetLabQueueIcon(Data.QUEUE[i].ID)*28,28,28));
                	                                  setWHV(game.ui.infopanel.inner.queue.icons[i],28,28);
        	                                  end;
		        		        end;

                                        	if (Data.ACTIVITY == act_wait_for_material) then
                                	                Data.PHASE = 0;
                        	                end;

                	                        setImageBarProgress(game.ui.infopanel.inner.queue.progress,Data.PHASE);
        	                        end;
	                        else
                        	        if (Data.QUEUECOUNT >= 1) then
                	                        setVisible(game.ui.infopanel.inner.queue,true);
        	                                for i=1,5 do
	                                          if (Data.QUEUE[i].IMG == '') then
                                        	          setVisible(game.ui.infopanel.inner.queue.icons[i],false);
                                	          else
                        	                          setVisible(game.ui.infopanel.inner.queue.icons[i],true);
                	                                  if Data.QUEUE[i].IMG == 'PLACEWEAPON' then
        	                                                  setInterfaceTexture(game.ui.infopanel.inner.queue.icons[i],'Buttons Small.png');
	                                                          setSubTexture(game.ui.infopanel.inner.queue.icons[i],true);
                                                        	  setSubCoords(game.ui.infopanel.inner.queue.icons[i],SUBCOORD(0,getIconTypeIndex(GetExtensionIcon(bud_ext_gun))*28,28,28));
                                                	  else
                                        	                  setInterfaceTexture(game.ui.infopanel.inner.queue.icons[i],'1024/'..Data.QUEUE[i].IMG);
                                                                  setInterfaceTextureFallback(game.ui.infopanel.inner.queue.icons[i],'1024/none.png');
                                	                          setSubTexture(game.ui.infopanel.inner.queue.icons[i],false);
                        	                          end;
                	                                  setHint(game.ui.infopanel.inner.queue.icons[i],'');
        	                                          setWHV(game.ui.infopanel.inner.queue.icons[i],38,30);
	                                          end;
	        		        	end;

                                	        if Data.PATROL and (Data.QUEUECOUNT < 5) then
                        	                          --setVisible(game.ui.infopanel.inner.queue.icons[i],true);
                	                                  --setInterfaceTexture(game.ui.infopanel.inner.queue.icons[i],'1024/'..Data.QUEUE[i].IMG);
        	                                end;

	                                        setText(game.ui.infopanel.inner.queue.labels[1],Data.FACTORYCURRENTBUILD[1]);
	                                        setText(game.ui.infopanel.inner.queue.labels[2],Data.FACTORYCURRENTBUILD[2]);
	                                        setText(game.ui.infopanel.inner.queue.labels[3],Data.FACTORYCURRENTBUILD[3]);


	                                        if Data.ACTIVITY == act_wait_for_material then
	                                                Data.PHASE = 0;
                                	        end;

                        	                setImageBarProgress(game.ui.infopanel.inner.queue.progress,Data.PHASE);
                	                        InfoPanelBudBar = -1;
        	                        end;
	                        end;
                        end;
		else
			for i=1,4 do
				setVisible(inner.budinfo[i],false);
			end;
		end;

		setHealthColour(inner.health.bar,Data.HEALTH/Data.MAXHEALTH);

		start = start + 5 + infoimgsizes[Data.TYP].h + 3;

                setXYWHV(game.ui.infopanel.inner.extensions,13,start+15,innerw,28);

                setXYWHV(game.ui.infopanel.inner.icon_lab1,16,start+15,28,28);
                setXYWHV(game.ui.infopanel.inner.icon_lab2,16+28,start+15,28,28);

                --if IsLab then
                --        start = start + 30;
                --end;

		for i=1,5 do
			setXYWHV(inner.text[i],13,start+15*(i-1),innerw-(13*2),15);
			setXYWHV(inner.values[i],13,start+15*(i-1),innerw-(13*2),15);
		end;

		game_info.updateInfoMouseOver();

		showSkills = IsHuman and not IsNature;

		if showSkills then
			for i=1,4 do
				game_info.SetInfoSkillIconsCoords(i,Data.SKILLICONS[i]);
				game_info.SetInfoSkillIconsPip(i,Data.SKILLICONS[i],Data.SKILLS[i]);
			end;
		end;

		IsHumanOrVehicle = (Data.TYP ~= 3);

		setVisible(inner.paramicons,IsHumanOrVehicle);

		setVisible(inner.driverimg,IsVehicle and (Data.ID2 > 0));

		for i=1,4 do
			setVisible(inner.skillicons[i],showSkills);
			setVisible(inner.skilliconspip[i],showSkills);
		end;

		setVisible(inner.skillsover,showSkills);
		setVisible(inner.health2,IsVehicle and (Data.ID2 > 0));
		setVisible(inner.paramsover,IsHumanOrVehicle or Data.CANATTACK);

		setVisible(inner.budparamicons,not IsHumanOrVehicle and Data.CANATTACK);


		w = 145/paramsdiv[IsHumanOrVehicle];
		y = innerh-15+interface.current.game.ui.paramoff;
		x = 13+5;

		for i=1,5 do
                        if (Data.CANATTACK or IsHumanOrVehicle) then
			   setText(inner.params[i],Data.VALUES[i]);
                        else
			   setText(inner.params[i],'');
                        end;
			setXYWHV(inner.params[i],x,y,w,15);
			x = x + w;
		end;
	end;
end;

function FROMOW_INFOPANEL_UPDATE(DATA) -- Called By OW!
	game_info.Update(DATA);
end;

function DoInterfaceChange_Info()
	ui = interface.current.game.ui;
	inner = game.ui.infopanel.inner;

	setWHV(inner,getWidth(game.ui.infopanel),getHeight(game.ui.infopanel)); -- Make sure its the same size!

	setInterfaceTexture(inner.paramicons,'ParamsIcons.png');
	setInterfaceTexture(inner.budparamicons,'Building ParamsIcons.png');
	setInterfaceTexture(inner.img.icon,'Buttons Small.png');
	setWHV(inner.img.icon,28,28);

	for i=1,4 do
		setInterfaceTexture(inner.skillicons[i],'Human SkillsIcons.png');
		setFontColourBoth(inner.budinfo[i].text,ui.infocolour);
	end;

	setInterfaceTexture(inner.budinfo[1].img,'Building Level.png');
	setInterfaceTexture(inner.budinfo[2].img,'Building Defend.png');
	setInterfaceTexture(inner.budinfo[3].img,'Building Occupation.png');
	setInterfaceTexture(inner.budinfo[4].img,'Building Power.png');

	setImageBarTexture(inner.budbars[1].progress,'ProgressBar Build.png');
	setImageBarTexture(inner.budbars[2].progress,'ProgressBar Construct.png');
	setImageBarTexture(inner.budbars[3].progress,'ProgressBar PlaceWeapon.png');
	setImageBarTexture(inner.budbars[4].progress,'ProgressBar Research.png');
	setImageBarTexture(inner.budbars[5].progress,'ProgressBar Upgrade.png');

        setImageBarTexture(game.ui.infopanel.inner.queue.progress,'ProgressBar Construct.png');

        setInterfaceTexture(game.ui.infopanel.inner.icon_lab1,'Buttons Small.png');
        setInterfaceTexture(game.ui.infopanel.inner.icon_lab2,'Buttons Small.png');

	w = 145;
	x = 13+5;
	y = getHeight(inner)-36+interface.current.game.ui.paramoff;
	setXYWHV(inner.paramicons,x,y,w,21);
	setXYWHV(inner.budparamicons,x,y,w,20);
	setXYWHV(inner.paramsover,x,y,w,36);

	for i=1,5 do
		setFontColourBoth(inner.params[i],ui.infocolour);
		setFontColourBoth(inner.text[i],ui.infocolour);
		setFontColourBoth(inner.values[i],ui.infocolour);
		setFontColourBoth(inner.budbars[i].label,ui.infocolour);

                setInterfaceTexture(game.ui.infopanel.inner.extensions.icons[i],'Buttons Small.png');
	end;

        for i=1,3 do
                setFontColourBoth(game.ui.infopanel.inner.queue.labels[i],ui.infocolour);
        end;

        setXYWHV(game.ui.infopanel.inner.queue,13,getHeight(inner)-84,154,79);
end;
