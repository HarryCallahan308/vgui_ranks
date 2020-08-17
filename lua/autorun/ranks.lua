// this better work

if not CLIENT then return end

--[[

	DCOLLAPSIBLECATEGORY WORK

]]





--[[

	DFRAME WORK

]]


local PANEL = {}

local sw, sh = ScrW(), ScrH()

-- Add materials
function PANEL:Init()

	self:SetSize( sw * .7, sh * .6)
	self:Center()
	self:SetSizable( true )
	self:SetFont( "Roboto" )
	self:SetTitle( "CFC Ranks" )

end

function PANEL:Paint(w, h)

	draw.RoundedBox( 0, 0, 0, w, h, color_black )

end

function PANEL:Add()

	self:Add( "CFC_Rank_Custom_DCollapsibleCategory" )

end

vgui.Register( "CFC_Rank_Custom_DFrame", PANEL, "DFrame" )



