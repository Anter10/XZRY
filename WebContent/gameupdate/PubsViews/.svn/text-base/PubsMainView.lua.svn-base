local PubsMainView = class("PubsMainView", RequireModel.CommonFullSceneUI)

function PubsMainView:ctor()
	self.super.ctor(self)

	sendMessageToServer(SENDMESSAGEIDS.RequestDrawPrise) 

	local mainview = RequireModel.CommonMainView.new(4)
    self:addChild(mainview)
end

function PubsMainView:init()
	
end

return PubsMainView