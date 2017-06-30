local PubsExtract = class("PubsExtract", RequireModel.CommonFullSceneUI)

function PubsExtract:ctor(data)
	self.super.ctor(self)

	self.m_type = data["m_type"]

	self.pubsnode = nil
	self.pubstab = {}

	self.wineglassnode = nil 
	self.wineglasstab = {}

	self.drawprisetype = nil

	self.background = createSprite("jg_bg.png")
	self.background:setPosition(winsize.width/2, winsize.height/2)
	self:addChild(self.background)

	self.freenum = 0  -- 免费次数
	self.backtype = 0 -- 返回类型
 	self:addCcb()

	
	self:addChild(self.goldlayer)
	
	self:getExtractData()
	self:getFreeNumAndTime()
end

-- 获取剩余次数和时间
function PubsExtract:getFreeNumAndTime()
	self.playerdrawprisedata = getPlayerData():getMySelfData():getDrawPriseData()
	self.beforetime = self.playerdrawprisedata:getServerTime()
	if self.m_type == 1 then
		self.freenum = tonumber(self.playerdrawprisedata:getGoldRemainNum()) 
	else
		self.freenum = self.playerdrawprisedata:getDiamoundRemainNum()
	end

	if self.m_type == 1 then
		self.freetime = self.playerdrawprisedata:getDrawGoldRemainTime()
	else
		self.freetime = self.playerdrawprisedata:getDrawDiamoundRemainTime()
	end
	if self.freenum < 0 then
		self.freenum = 0
	end
	
	if self.freetime > 0 then
		local servertime = math.floor(tonumber(self.beforetime)/1000)
		local gaptime = getTimecha(servertime)
		self.freetime = math.floor((tonumber(self.freetime)/1000+gaptime))-3
	end
	if self.freetime < 0 then
		self.freetime = 0
	end

	self:flushData()
end

-- 划分三种情况
-- 分为三种情况 1：如果上次从免费开始计时器从头开始 2：如果上次正在计时，计算时间戳 3：若没有免费次数，没有时间
function PubsExtract:getSituation()
	local currenttime = tonumber(self:getRemainTime()) 
	if self.freenum > 0 and currenttime == 0 then
		self.buytype = 1 
	elseif self.freenum > 0 and currenttime ~= 0 then
		self.buytype = 2 
	elseif self.freenum == 0 then
		self.buytype = 3
	end
end


-- 获取当前时间
function PubsExtract:getRemainTime()
	if self.timenode then
		return tonumber(self.timenode:getCurrentTime()) 
	else
		return 0
	end
end

-- 获取抽取数据
function PubsExtract:getExtractData()
	if self.m_type == 1 then
		self.oncetimeedata = getSystemData():getSystemTavernData(1)
		self.tentimedata = getSystemData():getSystemTavernData(2)
	elseif self.m_type == 2 then
		self.oncetimeedata = getSystemData():getSystemTavernData(3)
		self.tentimedata = getSystemData():getSystemTavernData(4)
	end
	-- self.freetime = self.oncetimeedata:getCd()
	self.onceextrafreenum = self.oncetimeedata:getExtraFreeNum()
	self.oncebasicfreenum = self.oncetimeedata:getBasicsFreeNum()
	self.oncecustomdata = self.oncetimeedata:getCost()

	self.tenextrafreenum = self.tentimedata:getExtraFreeNum()
	self.tenbasicfreenum = self.tentimedata:getBasicsFreeNum()
	self.tencustomdata = self.tentimedata:getCost()

	self:setDrinkTenPubs(self.tencustomdata[2])
	self:setMoneyTypeIcon()
end

-- 刷新数据
function PubsExtract:flushData()
	self:setFreeNum()
	self:setExtractIsFree()
	self:setDrinkOncePubs()
end

-- 添加Ccb文件
function PubsExtract:addCcb()
	ccb["winegrassnode"]=self.wineglasstab
    local wineglassbproxy = cc.CCBProxy:create()
    self.wineglassnode = CCBReaderLoad("UI_ccbi/jg1_ui.ccbi",wineglassbproxy,self.wineglasstab)
    self.wineglassnode:setPosition(winsize.width/2,winsize.height/2)
    self:addChild(self.wineglassnode)


	ccb["getbuttonnode"]=self.pubstab
    local pubsbproxy = cc.CCBProxy:create()
    self.pubsnode = CCBReaderLoad("UI_ccbi/jg3_ui.ccbi",pubsbproxy,self.pubstab)
    self.pubsnode:setPosition(winsize.width/2,winsize.height/2)
    self:addChild(self.pubsnode)

    self.pubstab["freelabel2"]:removeFromParent()
    self.pubstab["rightfreelabel"]:removeFromParent()
    self:setPubsbutton()
end

-- 设置钱数类型图标
function PubsExtract:setMoneyTypeIcon()
	local moneytype = tonumber(self.oncecustomdata[1]) 
	local imagename
	if moneytype == 1 then
		imagename = "zc_button_jb.png"
	else
		imagename = "zc_button_zs.png"
	end
	local goldicon1 = createSprite(imagename)
	goldicon1:setPosition(self.pubstab["glodicon1"]:getPositionX(), self.pubstab["glodicon1"]:getPositionY())
	self.pubstab["glodicon1"]:getParent():addChild(goldicon1)
	self.pubstab["glodicon1"]:removeFromParent()

	local goldicon2 = createSprite(imagename)
	goldicon2:setPosition(self.pubstab["glodicon2"]:getPositionX(), self.pubstab["glodicon2"]:getPositionY())
	self.pubstab["glodicon2"]:getParent():addChild(goldicon2)
	self.pubstab["glodicon2"]:removeFromParent()
end

-- 设置免费次数
function PubsExtract:setFreeNum()
	local freenumlabelname = ""
	if self.freenum ~= 0 then
		freenumlabelname = self.freenum.."/5"
	elseif self.freenum == 0 then
		freenumlabelname = "本日免费次数已用尽"
	end
	if self.freenumlabel then
		self.freenumlabel:setString(freenumlabelname)
	else
		self.freenumlabel = createLabel(freenumlabelname, self.pubstab["freetime"]:getParent(),self.pubstab["freetime"]:getPositionX(),self.pubstab["freetime"]:getPositionY())
		self.pubstab["freetime"]:removeFromParent()
	end
end

-- 设置抽取是否免费
function PubsExtract:setExtractIsFree()
	if self.freenum > 0 then
		if self.timenode then
			-- self.freetime = 0
			self.timenode:closeSchedule()
			self.timenode:removeFromParent()
			self.timenode = nil
		end
		local function timeendCallback()
			self:setDrinkOncePubs()
		end
		self.timenode = RequireModel.CalculationTime.new(self.freetime)
	 	self.timenode:setPosition(self.pubstab["freelabel"]:getPositionX(),self.pubstab["freelabel"]:getPositionY())
	 	self.pubstab["freelabel"]:getParent():addChild(self.timenode)

	 	self.timenode:setTimeEndCallback(timeendCallback)
	 	self.timenode:startSchedule()

	 	self.pubstab["freelabel"]:setVisible(false)
	else
		if self.timenode then
			self.timenode:removeFromParent()
			self.timenode = nil
		end
		self.pubstab["freelabel"]:setVisible(false)
	end
end

-- 设置喝一次消耗金币
function PubsExtract:setDrinkOncePubs()
	local goldnum = "" 
	if self.freenum == 0 or self:getRemainTime() > 0 then
		goldnum = self.oncecustomdata[2]
	elseif self.freenum > 0 then
		goldnum = "本次免费"
	end
	if self.oncetimelabel then
		self.oncetimelabel:setString(goldnum)
	else
		self.oncetimelabel = createLabel(goldnum, self.pubstab["oncelabel"]:getParent(),self.pubstab["oncelabel"]:getPositionX(),self.pubstab["oncelabel"]:getPositionY())
		self.pubstab["oncelabel"]:removeFromParent()
	end
end

-- 设置喝十次消耗金币
function PubsExtract:setDrinkTenPubs(goldnum)
	createLabel(goldnum, self.pubstab["tenlabel"]:getParent(),self.pubstab["tenlabel"]:getPositionX(),self.pubstab["tenlabel"]:getPositionY())
	self.pubstab["tenlabel"]:removeFromParent()
end

-- 设置事件值
function PubsExtract:backToCall()
	self.backdata = UIJump:getBackData()
	print("返回的数据123  = ",self.backdata)
 	-- self.backtype = self.backdata["buytype"]
 	self.goldlayer:flushData()

 	if self.freetime == 0 then
 		self:getFreeNumAndTime()
 	end
 	
 end 

-- 设置喝酒按钮
function PubsExtract:setPubsbutton()
	local function extract1Callback()
		if self.freetime == 0 and self.freenum > 0 then
			self:getSituation()
			print("buytype = ",self.buytype, self.m_type)
			if self.m_type == 1 then
				self.drawprisetype = 1   
			else
				self.drawprisetype = 3
			end
			sendMessageToServer(SENDMESSAGEIDS.StartDrawPrise, self.drawprisetype) 
		elseif self:isMoneyEnable(1) then
			self:getSituation()
			if self.m_type == 1 then
				self.drawprisetype = 1   
			else
				self.drawprisetype = 3
			end
			sendMessageToServer(SENDMESSAGEIDS.StartDrawPrise, self.drawprisetype) 
		end
	end
	self.oncetimebutton = RequireModel.Button.new("ty_button_01.png","ty_button_01.png", nil, "请一杯")
	self.oncetimebutton:setAnchorPoint(cc.p(0.5,0.5))
	self.oncetimebutton:setPosition(self.pubstab["oncetimebutton"]:getPositionX(),self.pubstab["oncetimebutton"]:getPositionY())
	self.pubstab["oncetimebutton"]:getParent():addChild(self.oncetimebutton)
	self.pubstab["oncetimebutton"]:removeFromParent(true)
	self.oncetimebutton:setCallback(extract1Callback)
	self.oncetimebutton.selectedSprite:setScale(1.1)

	local function extract2Callback()
		if self:isMoneyEnable(2) then
			self:getSituation()
			if self.m_type == 1 then
				self.drawprisetype = 2
			else
				self.drawprisetype = 4
			end
			sendMessageToServer(SENDMESSAGEIDS.StartDrawPrise, self.drawprisetype)
		end
		
	end
	self.tentimebutton = RequireModel.Button.new("ty_button_01.png","ty_button_01.png", nil, "请十杯")
	self.tentimebutton:setAnchorPoint(cc.p(0.5,0.5))
	self.tentimebutton:setPosition(self.pubstab["tentimebutton"]:getPositionX(),self.pubstab["tentimebutton"]:getPositionY())
	self.pubstab["tentimebutton"]:getParent():addChild(self.tentimebutton)
	self.pubstab["tentimebutton"]:removeFromParent(true)
	self.tentimebutton:setCallback(extract2Callback)
	self.tentimebutton.selectedSprite:setScale(1.1)
end

-- 判断钱数是否足够
-- @flag：1：抽奖一次 2：抽奖十次
function PubsExtract:isMoneyEnable(flag)
	local playerdata  = getPlayerData():getMySelfData()
	local goldnum     = playerdata:getPlayerGoldNum()
	local diamondsnum = playerdata:getPlayerDiamondsNum()

	if tonumber(self.oncecustomdata[1]) == 1 and flag == 1 then
		if goldnum < tonumber(self.oncecustomdata[2]) then
			return false
		else
			return true
		end
	elseif tonumber(self.oncecustomdata[1]) == 1 and flag == 2 then
		if goldnum < tonumber(self.tencustomdata[2]) then
			return false
		else
			return true
		end
	elseif tonumber(self.oncecustomdata[1]) == 2 and flag == 1 then
		if diamondsnum < tonumber(self.oncecustomdata[2]) then
			return false
		else
			return true
		end
	elseif tonumber(self.oncecustomdata[1]) == 2 and flag == 2 then
		if diamondsnum < tonumber(self.tencustomdata[2]) then
			return false
		else
			return true
		end
	end
end

return PubsExtract