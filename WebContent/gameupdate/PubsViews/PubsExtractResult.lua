local PubsExtractResult = class("PubsExtractResult", RequireModel.CommonFullSceneUI)

function PubsExtractResult:ctor(prisedata)
	self.super.ctor(self)

	self.gainsdata = prisedata["data"]
	self.m_type = prisedata["m_type"]
	self.m_buytype = prisedata["m_buytype"]

	
	self.winenode = nil
	self.winetab = {}

	self.heronode = nil
	self.herotab = {}

	self.freenum = 0
	self.freetime = 0

	self.goodspostab = {}
	self.gaingoodsdata = {}

	self.freeflag = false  --当前倒计时是否为0
	self.isrestart = false -- 是否重新开始

	self.background = createSprite("jg_bg.png")
	self.background:setPosition(winsize.width/2, winsize.height/2)
	self:addChild(self.background)

	self:initPos()

	self:addCcb()
	

	if self.m_type == 1 or self.m_type == 3 then
		self:getFreeNumAndTime()
	end
	self:getDrawData()
	self:flushData()
	self:setGoodRank(self.gainsdata)	
	
	-- 进来时，分三种情况 1：使用免费机会进来 2：免费机会正在倒计时 3：免费机会已使用完
	-- 当前当前页面时，分三种情况 1：使用免费机会刷新 2：免费机会倒计时刷新 3：免费机会已使用完刷新
	-- 返回时，分三种情况 1：使用免费机会返回 2：免费机会正在倒计时返回 3：免费机会已使用完返回
end

-- 获取剩余次数和时间
function PubsExtractResult:getFreeNumAndTime()
	self.playerdrawprisedata = getPlayerData():getMySelfData():getDrawPriseData()
	self.beforetime = self.playerdrawprisedata:getServerTime()
	if self.m_type == 1 then
		self.freenum = self.playerdrawprisedata:getGoldRemainNum()
	else
		self.freenum = self.playerdrawprisedata:getDiamoundRemainNum()
	end
	if self.m_type == 1 then
		self.freetime = self.playerdrawprisedata:getDrawGoldRemainTime()
	else
		self.freetime = self.playerdrawprisedata:getDrawDiamoundRemainTime()
	end
	if self.freenum <= 0 then
		self.freenum = 0
	end
	if self.m_buytype == 1 then
		self.freetime = 120
	elseif self.m_buytype == 2 then
		local servertime = math.floor(tonumber(self.beforetime)/1000)
		local gaptime = getTimecha(servertime)
		self.freetime = math.floor((tonumber(self.freetime)/1000+gaptime))-3
	elseif self.m_buytype == 3 then
		self.freetime = 0
	end
end

-- 初始化位置
function PubsExtractResult:initPos()
	for i=1,10 do
		local posx = winsize.width/2 + (i-3)*100
		local posy 
		if i <= 5 then
			posy = winsize.height/2 + 100
		else
			posy = winsize.height/2 - 100
		end
		self.goodspostab[#self.goodspostab+1] = cc.p(posx, posy)
	end
end

-- 添加Ccb文件
function PubsExtractResult:addCcb()
	-- ccb["jiuguan2"]=self.herotab
 --    local wineglassbproxy = cc.CCBProxy:create()
 --    self.heronode = CCBReaderLoad("UI_ccbi/jg2_ui.ccbi",wineglassbproxy,self.herotab)
 --    self.heronode:setPosition(winsize.width/2,winsize.height/2)
 --    self:addChild(self.heronode)

	ccb["getbuttonnode"]=self.winetab
    local pubsbproxy = cc.CCBProxy:create()
    self.winenode = CCBReaderLoad("UI_ccbi/jg3_ui.ccbi",pubsbproxy,self.winetab)
    self.winenode:setPosition(winsize.width/2,winsize.height/2)
    self:addChild(self.winenode)

    self.winetab["freelabel"]:removeFromParent()
    self.winetab["freetime"]:removeFromParent()
    self.winetab["oncelabel"]:removeFromParent()
    self.winetab["glodicon1"]:removeFromParent()

    self:setPubsbutton()
end

-- 刷新数据
function PubsExtractResult:flushData()
	if self.m_type == 1 or self.m_type == 3 then
		self:setFreeNum()
		self:setExtractIsFree()
		self:setDrinkOncePubs()
	else
		self.winetab["rightfreelabel"]:removeFromParent()
		self.winetab["freelabel2"]:removeFromParent()
		self:setDrinkOncePubs()
	end
end

-- 设置钱数类型图标
function PubsExtractResult:setMoneyTypeIcon()
	local moneytype = tonumber(self.customdata[1]) 
	local imagename
	if moneytype == 1 then
		imagename = "zc_button_jb.png"
	else
		imagename = "zc_button_zs.png"
	end
	local goldicon = createSprite(imagename)
	goldicon:setPosition(self.winetab["glodicon2"]:getPositionX(), self.winetab["glodicon2"]:getPositionY())
	self.winetab["glodicon2"]:getParent():addChild(goldicon)
	self.winetab["glodicon2"]:removeFromParent()
end

-- 设置免费次数
function PubsExtractResult:setFreeNum()
	local freenumlabelname = ""
	if self.freenum > 0 then
		freenumlabelname = self.freenum.."/5"
	elseif self.freenum == 0 then
		freenumlabelname = "本日免费次数已用尽"
	end
	if self.freenumlabel then
		self.freenumlabel:setString(freenumlabelname)
	else
		self.freenumlabel = createLabel(freenumlabelname, self.winetab["rightfreelabel"]:getParent(),self.winetab["rightfreelabel"]:getPositionX(),self.winetab["rightfreelabel"]:getPositionY())
		self.winetab["rightfreelabel"]:removeFromParent()
	end
end

-- 设置喝一次消耗金币
function PubsExtractResult:setDrinkOncePubs()
	local goldnum = ""
	if self.freeflag and self.freenum > 0 then
		goldnum = "本次免费"
	else
		goldnum = self.customdata[2]
	end	
	if self.oncetimelabel then
		self.oncetimelabel:setString(goldnum)
	else
		self.oncetimelabel = createLabel(goldnum, self.winetab["tenlabel"]:getParent(),self.winetab["tenlabel"]:getPositionX(),self.winetab["tenlabel"]:getPositionY())
		self.winetab["tenlabel"]:removeFromParent()
	end
end

-- 获取抽奖数据
function PubsExtractResult:getDrawData()
	if self.m_type == 1 then
		self.data = getSystemData():getSystemTavernData(1)
	elseif self.m_type == 2 then
		self.data = getSystemData():getSystemTavernData(2)
	elseif self.m_type == 3 then
		self.data = getSystemData():getSystemTavernData(3)
	elseif self.m_type == 4 then
		self.data = getSystemData():getSystemTavernData(4)
	end
	
	self.extrafreenum = self.data:getExtraFreeNum()
	self.basicfreenum = self.data:getBasicsFreeNum()
	self.customdata = self.data:getCost()

	self:setNeedMoneyNum(self.customdata[2])
	self:setMoneyTypeIcon()
	-- self:setExtractIsFree()
end

-- 添加获取物品图标
function PubsExtractResult:addGainGoodsIcon(data)
	for index,obj in pairs(self.gaingoodsdata) do
		obj:removeFromParent()
		obj = nil
	end
	self.gaingoodsdata = {}
	local heronum = #self.gainherodata 
	if heronum ~= 0 then
		for index,data in pairs(self.gainherodata) do
			local iconnode = RequireModel.IconNode.new(data,IconType.HeroIcon)
			if self.m_type == 1 or self.m_type == 3 then
				iconnode:setPosition(winsize.width/2, winsize.height/2)
			else
				iconnode:setPosition(self.goodspostab[index])
			end
			self:addChild(iconnode)
			self.gaingoodsdata[#self.gaingoodsdata+1] = iconnode
		end
	end

	if #self.gainpropdata ~= 0 then
		for index,data in pairs(self.gainpropdata) do
			local iconnode = RequireModel.IconNode.new(data,IconType.PropIcon)
			if self.m_type == 1 or self.m_type == 3 then
				iconnode:setPosition(winsize.width/2, winsize.height/2)
			else
				iconnode:setPosition(self.goodspostab[heronum+index])
			end
			self:addChild(iconnode)
			self.gaingoodsdata[#self.gaingoodsdata+1] = iconnode
		end
	end
end

-- 设置抽取是否免费
function PubsExtractResult:setExtractIsFree()
	if self.freenum > 0 then
		if self.timenode2 then
			self.freeflag = false
			self.timenode2:closeSchedule()
			self.timenode2:removeFromParent()
			self.timenode2 = nil
		end
		local function timeEndCallback()
			self.freeflag = true
			self.freetime = 0
			self:getSituation()
			self:setDrinkOncePubs()
		end
		self.timenode2 = RequireModel.CalculationTime.new(self.freetime)
	 	self.timenode2:setPosition(self.winetab["freelabel2"]:getPositionX(),self.winetab["freelabel2"]:getPositionY())
	 	self.winetab["freelabel2"]:getParent():addChild(self.timenode2)
	 	self.timenode2:startSchedule()
	 	self.timenode2:setTimeEndCallback(timeEndCallback)
	 	self.winetab["freelabel2"]:setVisible(false)
	else
		if self.timenode2 then
			self.timenode2:removeFromParent()
			self.timenode2 = nil
		end
		self:setNeedMoneyNum("本次免费")
		self.winetab["freelabel2"]:setVisible(false)
	end
end

-- 设置抽取一次所需钱数
function PubsExtractResult:setNeedMoneyNum(moneynun)
	if self.oncetimelabel then
		self.oncetimelabel:setString(moneynun)
	else
		self.oncetimelabel = createLabel(moneynun, self.winetab["tenlabel"]:getParent(),self.winetab["tenlabel"]:getPositionX(),self.winetab["tenlabel"]:getPositionY())
		self.winetab["tenlabel"]:removeFromParent()
	end
end

-- 抽奖后刷新数据
function PubsExtractResult:flushAfterData(data,flag)
	self.isrestart = flag
	if self.isrestart then
		self:getFreeNumAndTime()
	end
	self.goldlayer:flushData()
	self:getSituation()
	self:flushData()
	self:setGoodRank(data)
end

-- 划分三种情况
-- 分为三种情况 1：如果上次从免费开始计时器从头开始 2：如果上次正在计时，计算时间戳 3：若没有免费次数，没有时间
function PubsExtractResult:getSituation()
	if self.freenum > 0 and self.freeflag then
		self.buytype = 1 
	elseif self.freenum > 0 and not self.freeflag then
		self.buytype = 2 
	elseif self.freenum == 0 then
		self.buytype = 3
	end
end

-- 判断钱数是否足够
-- @flag：1：抽奖一次 2：抽奖十次
function PubsExtractResult:isMoneyEnable(flag)
	local playerdata  = getPlayerData():getMySelfData()
	local goldnum     = playerdata:getPlayerGoldNum()
	local diamondsnum = playerdata:getPlayerDiamondsNum()

	if tonumber(self.customdata[1]) == 1 and flag == 1 then
		if goldnum < tonumber(self.customdata[2]) then
			return false
		else
			return true
		end
	elseif tonumber(self.customdata[1]) == 1 and flag == 2 then
		if goldnum < tonumber(self.tencustomdata[2]) then
			return false
		else
			return true
		end
	elseif tonumber(self.customdata[1]) == 2 and flag == 1 then
		if diamondsnum < tonumber(self.customdata[2]) then
			return false
		else
			return true
		end
	elseif tonumber(self.customdata[1]) == 2 and flag == 2 then
		if diamondsnum < tonumber(self.tencustomdata[2]) then
			return false
		else
			return true
		end
	end
end


-- 排序
function PubsExtractResult:setGoodRank(data)
	print("allpropdatanum = ",#self.gainsdata)
	self.gainsdata = data
	self.gainherodata = {}
	self.gainpropdata = {}
	for index,obj in pairs(self.gainsdata) do
		if tonumber(string.sub(tostring(obj:getId()),0,1)) == 1 then
			self.gainherodata[#self.gainherodata+1] = obj
		else
			self.gainpropdata[#self.gainpropdata+1] = obj
		end
	end
	if #self.gainpropdata ~= 0 then
		self:setPropSort()
	end

	-- if #self.gainherodata ~= 0 then
	-- 	self:setHeroSort()
	-- end

	self:addGainGoodsIcon()
end

--装备分类
function PubsExtractResult:setPropSort()
	local function propsort(h1,h2)
		local yes = true
        if not h1 then 
            return true
        elseif not h2 then 
            return false 
        elseif h1 and h2 then 
        	if h1:getType() == h2:getType() then
        		if h1:getQuality() == h2:getQuality() then
                    if h1:getType() == h2:getType() then
                        if h1:getLevel() == h2:getLevel() then
                            return h1:getId() < h2:getId()
                        else
                            return h1:getLevel()>h2:getLevel()
                        end
                    else
                        return h1:getType()>h2:getType()
                    end
                else
                    return h1:getQuality()>h2:getQuality()
                end
        	else
        		return h1:getType() < h2:getType()
        	end
     	end
	end

	table.sort(self.gainpropdata, propsort)
end

-- 英雄分类
function PubsExtractResult:setHeroSort()
	local function herosort(h1,h2)
		local yes = true
        if not h1 then 
            return true
        elseif not h2 then 
            return false 
        elseif h1 and h2 then 
        	if h1:getQuality() == h2:getQuality() then
        		return h1:getId() < h2:getId() 
        	else
        		return h1:getQuality() > h2:getQuality()
        	end
     	end
	end

	table.sort(self.gainherodata, herosort)	
end

-- 设置喝酒按钮
function PubsExtractResult:setPubsbutton()
	local function extract1Callback()
		UIJump:setBackData({buytype = self.m_buytype})
        UIJump:backTo()
	end
	self.button1 = RequireModel.Button.new("ty_button_01.png","ty_button_01.png",nil,"返回")
	self.button1:setAnchorPoint(cc.p(0.5,0.5))
	self.button1:setPosition(self.winetab["oncetimebutton"]:getPositionX(),self.winetab["oncetimebutton"]:getPositionY())
	self.winetab["oncetimebutton"]:getParent():addChild(self.button1)
	self.winetab["oncetimebutton"]:removeFromParent(true)
	self.button1:setCallback(extract1Callback)
	self.button1.selectedSprite:setScale(1.1)

	local function extract2Callback()
		if self.freetime == 0 and self.freenum > 0 and self.m_type == 1 then 
			sendMessageToServer(SENDMESSAGEIDS.StartDrawPrise, self.m_type) 
		elseif self.freetime == 0 and self.freenum > 0 and self.m_type == 3 then
			sendMessageToServer(SENDMESSAGEIDS.StartDrawPrise, self.m_type) 
		elseif self:isMoneyEnable() then
			sendMessageToServer(SENDMESSAGEIDS.StartDrawPrise, self.m_type) 
		end
	end
	self.button2 = RequireModel.Button.new("ty_button_01.png","ty_button_01.png",nil,"再来一次")
	self.button2:setAnchorPoint(cc.p(0.5,0.5))
	self.button2:setPosition(self.winetab["tentimebutton"]:getPositionX(),self.winetab["tentimebutton"]:getPositionY())
	self.winetab["tentimebutton"]:getParent():addChild(self.button2)
	self.winetab["tentimebutton"]:removeFromParent(true)
	self.button2:setCallback(extract2Callback)
	self.button2.selectedSprite:setScale(1.1)

	-- 返回来时，分三种情况，一种是已经进行完，一种是正在进行时，一种是没有免费次数
end

function PubsExtractResult:isMoneyEnable()
	local playerdata  = getPlayerData():getMySelfData()
	local goldnum     = playerdata:getPlayerGoldNum()
	local diamondsnum = playerdata:getPlayerDiamondsNum()

	if tonumber(self.customdata[1]) == 1 and self.m_type == 1 then
		if goldnum < tonumber(self.customdata[2]) then
			return false
		else
			return true
		end
	elseif tonumber(self.customdata[1]) == 1 and self.m_type == 2 then
		if goldnum < tonumber(self.customdata[2]) then
			return false
		else
			return true
		end
	elseif tonumber(self.customdata[1]) == 2 and self.m_type == 3 then
		if diamondsnum < tonumber(self.customdata[2]) then
			return false
		else
			return true
		end
	elseif tonumber(self.customdata[1]) == 2 and self.m_type == 4 then
		if diamondsnum < tonumber(self.customdata[2]) then
			return false
		else
			return true
		end
	end
end


return PubsExtractResult




