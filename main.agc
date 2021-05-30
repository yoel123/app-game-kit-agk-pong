
// Project: pong 
// Created: 2021-05-11

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "pong" )
SetWindowSize( 500, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 500, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

//ids

global ph = 1
global ball = 1
global paddle1 = 2
global paddle2 = 3

//load images
LoadImage(ph,"ph.png")

//create sprites
createsprite(ball,ph)
createsprite(paddle1,ph)
createsprite(paddle2,ph)

//set sprite pos
SetSpritePosition(ball,200,200)
SetSpritePosition(paddle1,10,0)
SetSpritePosition(paddle2,460,20)

//paddle sizes
pw = 20
ph = 70

setspritesize(paddle1,pw,ph)
setspritesize(paddle2,pw,ph)

//ball vars
global bsx = -5
global bsy = 5


do
	
	control_paddle(paddle1,1)
	control_paddle(paddle2,0)
	 ball_movment()
	
	sync()
loop

function control_paddle(sid,is_p)
	
	if is_p
		py = GetPointerY()
		SetSpritePosition(sid,GetSpriteX(sid),py)
	else
		by = GetSpriteY(ball)
		SetSpritePosition(sid,GetSpriteX(sid),by)
	endif
	
endfunction

function ball_movment()
	
	bx = GetSpriteX(ball) 
	by = GetSpriteY(ball) 
	
	//collition detection
	if GetSpriteCollision(paddle1,ball) or GetSpriteCollision(paddle2,ball)
		bsx = bsx*-1
		rndy = random(1,10)
		if rndy>5 then bsy = bsy *-1
	endif
	
	//if hits boottom or top
	if by >GetScreenBoundsBottom() or by < GetScreenBoundsTop()
		bsy = bsy*-1	
	endif
	
	SetSpritePosition(ball,bx+bsx,by+bsy)
	
	//if it gets out of sscreen
	
	if bx<0 or bx > GetScreenBoundsRight()
	
		SetSpritePosition(ball,Random(50,200),by)
		
	endif	
	
endfunction



