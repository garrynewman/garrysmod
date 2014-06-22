--[[
     _
    ( )
   _| |   __   _ __   ___ ___     _ _
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_)

	DRGBPicker

--]]
local PANEL = {}

AccessorFunc( PANEL, "m_RGB", "RGB" )

--[[---------------------------------------------------------
	Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetRGB( Color( 255, 255, 255 ) )

	self.Material = Material( "gui/colors.png" ) -- TODO: Light/Dark

	self.LastX = -100
	self.LastY = -100

end

--[[---------------------------------------------------------
	Name: GetPosColor
-----------------------------------------------------------]]
function PANEL:GetPosColor( x, y )

	local con_x = ( x / self:GetWide() ) * self.Material:Width()
	local con_y = ( y / self:GetTall() ) * self.Material:Height()

	con_x = math.Clamp( con_x, 0, self.Material:Width() - 1 )
	con_y = math.Clamp( con_y, 0, self.Material:Height() - 1 )

	local col = self.Material:GetColor( con_x, con_y )

	return col, con_x, con_y

end

--[[---------------------------------------------------------
	Name: OnCursorMoved
-----------------------------------------------------------]]
function PANEL:OnCursorMoved( x, y )

	if ( !input.IsMouseDown( MOUSE_LEFT ) ) then return end

	local col = self:GetPosColor( x, y )

	if ( col ) then
		self.m_RGB = col
		self.m_RGB.a = 255
		self:OnChange( self.m_RGB );
	end

	self.LastX = x
	self.LastY = y

end

--[[---------------------------------------------------------
	Name: OnChange
-----------------------------------------------------------]]
function PANEL:OnChange( col )

	-- Override me

end

--[[---------------------------------------------------------
	Name: OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mcode )

	self:MouseCapture( true )
	self:OnCursorMoved( self:CursorPos() );

end


--[[---------------------------------------------------------
	Name: OnMouseReleased
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mcode )

	self:MouseCapture( false )
	self:OnCursorMoved( self:CursorPos() );

end

--[[---------------------------------------------------------
	Name: Paint
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( self.Material )
	surface.DrawTexturedRect( 0, 0, w, h )

	surface.SetDrawColor( 0, 0, 0, 250 )
	self:DrawOutlinedRect()

	surface.DrawRect( 0, self.LastY - 2, w, 3 )

	surface.SetDrawColor( 255, 255, 255, 250 )
	surface.DrawRect( 0, self.LastY - 1, w, 1 )

end

derma.DefineControl( "DRGBPicker", "", PANEL, "DPanel" )