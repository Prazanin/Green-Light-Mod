---------------------------------------------------
-- For Change exist constants/uztils and add new --
---------------------------------------------------

--include('mymodsutils');

-- Interface for GL by Serpent 2020
-- Fonts
Neuropol = 'Neuropol_70_16_2.DFF;1;0.3;0.7'; -- <FontName>;<Scale>;<MinRange>;<MaxRange>;<Gap>
Neuropol_12 = 'Neuropol_12_16_2.DFF;1;0.40;0.5;1';
Neuropol_16 = 'Neuropol_16_16_2.DFF;1;0.35;0.49;1';
Neuropol_18 = 'Neuropol_18_Fixed_16_2.DFF;1;0.34;0.55;1';

-- Colors
function GREEN()
        return RGB(61,204,0);
end;

function GREENA(A)
        return RGBA(61,204,0,A);
end;

WINDOW_BACKGROUND_GL = {
        bevel=true,
	bevel_colour1=GRAYA(110),
	bevel_colour2=GRAYA(110),
	gradient_colour1=BLACKA(255),
	gradient_colour2=BLACKA(188),
	gradient=true
};

-- Buttons
GradButton_Black_Light = {
	highlight1=GREENA(255),
	highlight2=GRAY(63),
	col1=GREEN(106),
	col2=GRAY(43),
	b_highlight1=BLACK(60),
	b_highlight2=GRAY(90),
	b_shadow1=BLACK(1),
	b_shadow2=BLACK(255),
}
