MOAISim.openWindow ( "test", 480, 320 )


--kbd
--
--[[ move to thread
--
function onKeyboardEvent ( key, down )

	if down == true then
		skelefoo:start ()

		if key == 97 then
			bgx = -10
		end
		if key == 100 then
			bgx = 10
		end

		prop:moveLoc ( bgx, 0, MOAIEaseType.LINEAR )
		treeprop:moveLoc (bgx*2, 0, MOAIEaseType.LINEAR)

	else
		skelefoo:stop ()
	end

end
]]

--[[ moved to thread
--MOAIInputMgr.device.keyboard:setCallback ( onKeyboardEvent )
--]]

layer = MOAILayer2D.new ()
MOAISim.pushRenderPass ( layer )

viewport = MOAIViewport.new ()
viewport:setSize ( 2400, 320 )
viewport:setScale ( 2400, 320 )
layer:setViewport ( viewport )

camera = MOAITransform.new ()
layer:setCamera ( camera )

quad = MOAIGfxQuad2D.new()
quad:setTexture( "stars-bg.png" )
quad:setRect(-1200,160,1200,-160)

trees = MOAIGfxQuad2D.new()
trees:setTexture( "trees.png" )
trees:setRect(-2400,160,2400,-160)


prop = MOAIProp2D.new()
prop:setDeck ( quad )
prop:setLoc ( 0, 0 )
prop:setScl ( 1.0, -1.0 )

treeprop = MOAIProp2D.new()
treeprop:setDeck ( trees )
treeprop:setLoc ( 0, 0 )
treeprop:setScl ( 1.0, -1.0 )


layer:insertProp ( prop )
layer:insertProp ( treeprop )


skeletileLib = MOAITileDeck2D.new ()
skeletileLib:setTexture ( "bones.png" )
skeletileLib:setSize ( 9, 1 )
skeletileLib:setRect ( -64, -64, 64, 64 )

skeleprop = MOAIProp2D.new ()
skeleprop:setDeck ( skeletileLib )
skeleprop:setLoc (-940,-40)
skeleprop:setScl (1.0, 1.0)
layer:insertProp ( skeleprop )

skelefoocurve = MOAIAnimCurve.new ()

skelefoocurve:reserveKeys ( 9 )
skelefoocurve:setKey ( 1, 0.0625, 1, MOAIEaseType.FLAT )
skelefoocurve:setKey ( 2, 0.1250, 2, MOAIEaseType.FLAT )
skelefoocurve:setKey ( 3, 0.1875, 3, MOAIEaseType.FLAT )
skelefoocurve:setKey ( 4, 0.2500, 4, MOAIEaseType.FLAT )
skelefoocurve:setKey ( 5, 0.3125, 5, MOAIEaseType.FLAT )
skelefoocurve:setKey ( 6, 0.4375, 6, MOAIEaseType.FLAT )
skelefoocurve:setKey ( 7, 0.5000, 7, MOAIEaseType.FLAT )
skelefoocurve:setKey ( 8, 0.5625, 8, MOAIEaseType.FLAT )
skelefoocurve:setKey ( 9, 0.6250, 9, MOAIEaseType.FLAT )

skelefoo = MOAIAnim:new ()
skelefoo:reserveLinks ( 1 )
skelefoo:setLink ( 1, skelefoocurve, skeleprop, MOAIProp2D.ATTR_INDEX )
skelefoo:setMode ( MOAITimer.LOOP )



skeletileLibL = MOAITileDeck2D.new ()
skeletileLibL:setTexture ( "bones-l.png" )
skeletileLibL:setSize ( 9, 1 )
skeletileLibL:setRect ( -64, -64, 64, 64 )

skelepropL = MOAIProp2D.new ()
skelepropL:setDeck ( skeletileLibL )
skelepropL:setLoc (-940,-1040)
skelepropL:setScl (1.0, 1.0)
layer:insertProp ( skelepropL )

skelefoocurveL = MOAIAnimCurve.new ()

skelefoocurveL:reserveKeys ( 9 )
skelefoocurveL:setKey ( 1, 0.0625, 1, MOAIEaseType.FLAT )
skelefoocurveL:setKey ( 2, 0.1250, 2, MOAIEaseType.FLAT )
skelefoocurveL:setKey ( 3, 0.1875, 3, MOAIEaseType.FLAT )
skelefoocurveL:setKey ( 4, 0.2500, 4, MOAIEaseType.FLAT )
skelefoocurveL:setKey ( 5, 0.3125, 5, MOAIEaseType.FLAT )
skelefoocurveL:setKey ( 6, 0.4375, 6, MOAIEaseType.FLAT )
skelefoocurveL:setKey ( 7, 0.5000, 7, MOAIEaseType.FLAT )
skelefoocurveL:setKey ( 8, 0.5625, 8, MOAIEaseType.FLAT )
skelefoocurveL:setKey ( 9, 0.6250, 9, MOAIEaseType.FLAT )



--[[it no worky :(
MOAIUntzSystem.initialize ()

soundsystem = MOAIUntzSound:new ()
soundsystem:setLooping(true)
soundsystem:load ("spokky96.mp3")
soundsystem:play()
]]

bgx = 0
gameOver = false
mainThread = MOAIThread.new ()
mainThread:run (
	function () 
		while not gameOver do
			coroutine.yield ()

			if MOAIInputMgr.device.keyboard:keyDown(97) then 
				skelefoo:setLink ( 1, skelefoocurve, skeleprop, MOAIProp2D.ATTR_INDEX )
				skeleprop:setLoc (-940,-40)
				skelepropL:setLoc (-940,-1040)
				skelefoo:start ()
				bgx = -1
			end
			if MOAIInputMgr.device.keyboard:keyDown(100) then 
				skelefoo:setLink ( 1, skelefoocurveL, skelepropL, MOAIProp2D.ATTR_INDEX )
				skelepropL:setLoc (-940,-40)
				skeleprop:setLoc (-940,-1040)
				skelefoo:start ()
				bgx = 1
			end
			if MOAIInputMgr.device.keyboard:keyUp(97) then 
				skelefoo:stop ()
				bgx = 0
			end
			if MOAIInputMgr.device.keyboard:keyUp(100) then 
				skelefoo:stop ()
				bgx = 0
			end

			prop:moveLoc ( bgx, 0, 1, MOAIEaseType.LINEAR )
			treeprop:moveLoc (bgx*2, 0, 1, MOAIEaseType.LINEAR )
		end

	end
)
	

