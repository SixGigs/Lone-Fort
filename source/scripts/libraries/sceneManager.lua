-- Playdate Constants
local pd <const> = playdate
local gfx <const> = pd.graphics


local fadedRects = {}
for i=0,1,0.01 do
	local fadedImage = gfx.image.new(400, 240)
	gfx.pushContext(fadedImage)

	local filledRect = gfx.image.new(400, 240, gfx.kColorBlack)
	filledRect:drawFaded(0, 0, i, gfx.image.kDitherTypeBayer8x8)
	gfx.popContext()
	fadedRects[math.floor(i * 100)] = fadedImage
end
fadedRects[100] = gfx.image.new(400, 240, gfx.kColorBlack)

-- Scene Manager Class
class('SceneManager').extends()

function SceneManager:init()
	self.transitionTime = 1000
	self.transitioning = false
end

-- The three dots represent no or many arguments can be passed
function SceneManager:switchScene(scene, ...)
	if self.transition then
		return
	end

	self.newScene = scene
	self.sceneArgs = ...
	self:startTransition()
end

function SceneManager:loadNewScene()
	self:cleanupScene()
	self.newScene(self.sceneArgs)
end

function SceneManager:startTransition()
	-- self:wipeTransition(0, 400)
	local transitionTimer = self:fadeTransition(0, 1)
	transitionTimer.timerEndedCallback = function()
		self:loadNewScene()
		-- self:wipeTransition(400, 0)
		transitionTimer = self:fadeTransition(1, 0)
		transitionTimer .timerEndedCallback = function()
			self.transitioning = false
		end
	end
end

function SceneManager:wipeTransition(startValue, endValue)
	local transitionSprite = self:createTransitionSprite()
	transitionSprite:setClipRect(0, 0, startValue, 240)

	local transitionTimer = pd.timer.new(self.transitionTime, startValue, endValue, pd.easingFunctions.inOutCubic)
	transitionTimer.updateCallback = function(timer)
		transitionSprite:setClipRect(0, 0, timer.value, 240)
	end
	return transitionTimer
end

function SceneManager:fadeTransition(startValue, endValue)
	local transitionSprite = self:createTransitionSprite()
	transitionSprite:setImage(self:getFadedImage(startValue))

	local transitionTimer = pd.timer.new(self.transitionTime, startValue, endValue, pd.easingFunctions.inOutCubic)
	transitionTimer.updateCallback = function(timer)
		transitionSprite:setImage(self:getFadedImage(timer.value))
	end
	return transitionTimer
end

function SceneManager:getFadedImage(alpha)
	return fadedRects[math.floor(alpha * 100)]
end

function SceneManager:createTransitionSprite()
	-- To change this for an image replace "gfx.kColorBlack" with the image
	local filledRect = gfx.image.new(400, 240, gfx.kColorBlack)
	local transitionSprite = gfx.sprite.new(filledRect)
	transitionSprite:moveTo(200, 120)
	transitionSprite:setZIndex(10000)
	transitionSprite:setIgnoresDrawOffset()
	transitionSprite:add()
	return transitionSprite
end

function SceneManager:cleanupScene()
	gfx.sprite.removeAll()
	self:removeAllTimers()
	gfx.setDrawOffset(0, 0)
end

function SceneManager:removeAllTimers()
	local allTimers = pd.timer.allTimers()
	for _, timer in ipairs(allTimers) do
		timer:remove()
	end
end