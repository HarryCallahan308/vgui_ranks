
local rankOrder = {"Owner", "Admin", "Developer", "Moderator", "Sentinel", "Gallant", "Exalted", "Ardent", "Devotee", "Regular", "User"}

local ranks = {
	["Owner"] = {
		Summary = "Only the owner of the server gets this rank.",
		Description = "Owner is a Staff rank that represents players who own all CFC services, and has total control over them. This rank can not be obtained by normal means.",
		TimeBased = false,
		TimeRequired = 0,
		PlayerCount = "1"
	},
	["Admin"] = {
		Summary = "Admins are the head of the staff.",
		Description = "Admin is a Staff rank granted to players who apply to CFC upper management primarily through ‘Staff Applications’ that happen annually, or may be offered to a player who is recognised as a possible candidate but did not apply. Admins handle situations that are out of the scope of Moderators, oftentimes issues that require the use of third party services or research to keep the peace. Despite there only being a single title of “Admin”, each Admin serves a specialized role or task, and their permissions may vary on a per person basis.",
		TimeBased = false,
		TimeRequired = 0,
		PlayerCount = "5-10"
	},
	["Developer"] = {
		Summary = "Developers are there to fix, edit and create addons in order to make the gameplay better.",
		Description = "Developer is a Technical rank granted to our players who work with CFC on various projects. This rank is used to grant our development team the permissions they need to test content on CFC services. While Developers have no inherent administrative responsibility, they are expected to act with more civility than the average player.",
		TimeBased = false,
		TimeRequired = 0,
		PlayerCount = "5-10"
	},
	["Moderator"] = {
		Summary = "Moderators are the base of the staff.",
		Description = "Moderator is a Staff rank granted to players who apply to CFC upper management primarily through ‘Staff Applications’ that happen annually, or may be offered to a player who is recognised as a possible candidate but did not apply. Moderators differ from sentinels in the sense they are our first true Staff rank, and must comply with a code of demeanor while interacting with our players or Services. Moderators are the primary enforcers for CFC and are equipped to handle most situations that occur in our servers without the need to use external services.",
		TimeBased = false,
		TimeRequired = 0,
		PlayerCount = "1-10"
	},
	["Sentinel"] = {
		Summary = "Sentinels are the newest staff members.",
		Description = "Sentinel is a Staff rank granted to players who apply to CFC upper management primarily through ‘Staff Applications’ that happen annually, or may be offered to a player who is recognised as a possible candidate but did not apply. Sentinels bridge the gap between Player ranks and Staff ranks, they function as regular players with the ability to enact light punishment on violators of the community guidelines and server rules. While sentinels have no inherent administrative responsibility, they are expected to use their granted permissions responsibly.",
		TimeBased = false,
		TimeRequired = 0,
		PlayerCount = "1-5"
	},
	["Gallant"] = {
		Summary = "You can get Gallant if you are considered like a perfect player.",
		Description = "Gallant is a Player rank that is obtained when a player is considered a perfect player by CFC upper management. Gallant boasts the greatest amount of features that a standard ",
		TimeBased = false,
		TimeRequired = 0,
		PlayerCount = "0"
	},
	["Exalted"] = {
		Summary = "You can get Exalted if you are known to be a nice player.",
		Description = "Exalted is a Player rank that is obtained when a player has garnered reputation because of one or more notable qualities, and is recognised by the community for them. Exalted players do not have any administrative responsibility, however, they are expected to act with more civility than the average player. With the title, the rank grants players additional ULX commands, E2 functions, and prestige. It is not uncommon for a player to obtain the rank of Exalted before reaching 1000 hours and subsequently, Ardent.",
		TimeBased = false,
		TimeRequired = 0,
		PlayerCount = "10-20"
	},
	["Ardent"] = {
		Summary = "You get the Ardent rank after 1000 hours on the server.",
		Description = "Ardent is a Player rank that is obtained after playing on CFC for 1000 hours. Ardent players have nearly identical set of permissions to Devotees, and mark the final rank obtained by play time.",
		TimeBased = true,
		TimeRequired = 1000,
		PlayerCount = "20-40"
	},
	["Devotee"] = {
		Summary = "You get the Devotee rank after 300 hours on the server.",
		Description = "Devotee is a Player rank that is obtained after playing on CFC for 300 hours. Devotees gain a large deal of additional features not available to Users or Regulars. Most notably a large quantity of ULX commands and E2 functions.",
		TimeBased = true,
		TimeRequired = 300,
		PlayerCount = "30-60"
	},
	["Regular"] = {
		Summary = "You get the Regular rank after 20 hours on the server.",
		Description = "Regular is a Player rank that is obtained after playing on CFC for 20 hours. Regulars gain some additional permissions not available to Users, notably a much greater prop limit and additional ULX commands.",
		TimeBased = true,
		TimeRequired = 20,
		PlayerCount = "40-80"
	},
	["User"] = {
		Summary = "The default rank given upon first joining CFC.",
		Description = "User is a Player rank given to players who join the server for the first time, and acts as our default rank. They are limited on what types of interactions they are allowed to have in our server. ",
		TimeBased = true,
		TimeRequired = 0,
		PlayerCount = "1-[Only Phatso knows]"
	}
}

local rankColors = {}

for _, teamInfo in pairs( team.GetAllTeams() ) do
	rankColors[teamInfo.Name] = teamInfo.Color
end

// this better work

if not CLIENT then return end

--[[

	DCOLLAPSIBLECATEGORY WORK

]]





surface.CreateFont( "CFC_RankName", {
    font = "DermaLarge",
    size = 48
} )

surface.CreateFont( "CFC_RankInfo", {
	font = "DermaLarge",
	size = 24
} )

--------------------------------------------------
-- Rank panel vgui class

local panelClosedHeight = 120
local panelOpenHeight = 300

local RankInfoPanel = {}

RankInfoPanel.isOpen = false

RankInfoPanel.RankName = ""
RankInfoPanel.RankColor = Color( 255, 255, 255 )
RankInfoPanel.RankSummary = ""
RankInfoPanel.RankDescription = ""

RankInfoPanel.isTimeBased = false
RankInfoPanel.timeToObtain = 0

RankInfoPanel.playerCount = "0"

function RankInfoPanel:Init()
	self:SetHeight( panelClosedHeight )
	
	self.description = vgui.Create( "DLabel", self )
	self.description:SetPos( 12, 132 )
	self.description:SetSize( 900, 144 )
	self.description:SetFont( "CFC_RankInfo" )
	self.description:SetWrap( true )
end

function RankInfoPanel:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 44, 48, 74 ) )
	
	draw.DrawText( self.RankName, "CFC_RankName", 12, 0, self.RankColor, TEXT_ALIGN_LEFT )
	draw.RoundedBox( 0, 12, 64, w - 24, 2, Color( 255, 255, 255 ) )
	draw.DrawText( self.RankSummary, "CFC_RankInfo", 12, 72, Color( 175, 175, 175 ), TEXT_ALIGN_LEFT )
	
	if self.isTimeBased then
		local timeLeft = self.timeToObtain - LocalPlayer():GetUTimeTotalTime()
		
		if timeLeft > 0 then
			local hours = math.floor( timeLeft / 3600 )
			local seconds = math.floor( ( timeLeft / 60 ) % 60 )
			
			draw.DrawText( string.format( "Time left before obtention: %02d:%02d", hours, seconds ), "CFC_RankInfo", 900, 72, Color( 255, 150, 150 ), TEXT_ALIGN_RIGHT )
		else
			draw.DrawText( "Already Obtained!", "CFC_RankInfo", 900, 72, Color( 150, 255, 150 ), TEXT_ALIGN_RIGHT )
		end
	end
		
	local panelWidth, panelHeight = self:GetSize()
	
	if self.isOpen then
		draw.DrawText( "How many players have this rank: " .. self.playerCount, "CFC_RankInfo", 12, 96, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT )
		
		if panelHeight < panelOpenHeight then
			self:SetSize( panelWidth, panelHeight + 400 * FrameTime() )
		elseif panelHeight >= panelOpenHeight then
			self:SetSize( panelWidth, panelOpenHeight )
		end
	else
		if panelHeight > panelClosedHeight then
			self:SetSize( panelWidth, panelHeight - 400 * FrameTime() )
		elseif panelHeight <= panelClosedHeight then
			self:SetSize( panelWidth, panelClosedHeight )
		end
	end
end

function RankInfoPanel:SetDescription( description )
	self.description:SetText( description )
end

function RankInfoPanel:OnMousePressed( keyCode )
	if keyCode ~= 107 then return end
	
	self.isOpen = not self.isOpen
end

vgui.Register( "CFC_RankInfoPanel", RankInfoPanel, "DPanel" )

--------------------------------------------------
-- Test part

local RankInfoFrame = {}

function RankInfoFrame:Init()
	local width, height = ScrW() * 0.52, ScrH() * 0.93
	local paddingHorizontal = ( width * 0.05 ) / 2
	local paddingVertical = ( height * 0.03 ) / 2
	
	self:SetTitle( "" )
	self:SetSize( width, height )
	self:Center()
	self:DockPadding( paddingHorizontal, paddingHorizontal, paddingVertical, paddingVertical )
	self:ShowCloseButton( true )
	self:MakePopup()
	
	self.startTime = SysTime()
	
	self.scrollBar = vgui.Create( "DScrollPanel", self )
	self.scrollBar:Dock( FILL )
	
	for rankPlace, rankName in pairs( rankOrder ) do
		local panel = vgui.Create( "CFC_RankInfoPanel", self.scrollBar )
		panel:DockMargin( 0, 0, 0, 5 )
		panel:Dock( TOP )
		panel:DockPadding( 5, 5, 5, 5 )
		
		local rankInfo = ranks[rankName]
		
		panel.RankName = rankName
		panel.RankSummary = rankInfo.Summary
		panel:SetDescription( rankInfo.Description )
		panel.RankColor = rankColors[rankName]
		
		panel.isTimeBased = rankInfo.TimeBased
		panel.timeToObtain = rankInfo.TimeRequired * 3600
		panel.playerCount = rankInfo.PlayerCount
	end
end
	
function RankInfoFrame:Paint( width, height )
	Derma_DrawBackgroundBlur( self, self.startTime )
	draw.RoundedBox( 8, 0, 0, width, height, Color( 36, 41, 67, 255 ) )
end

vgui.Register( "CFC_RankInfoFrame", RankInfoFrame, "DFrame" )

local MyRankInfoFrame = vgui.Create( "CFC_RankInfoFrame" )