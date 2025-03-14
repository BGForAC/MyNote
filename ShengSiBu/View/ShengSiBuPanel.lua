--[[
    Author: guqiulei
    Date: 2025-01-20 16:02:30
    Description: xxx 副页面
]]

require "Core.Module.Common.Panel"
-- 上一级文件夹，一个作为配置文件的lua，还不确认如何使用
local cfg = require "Core.Module.ShengSiBu.shengsibu"

local ShengSiBuPanel = class("ShengSiBuPanel", Panel);

local deathNamePrefix = "_txtDeath";

---获取面板地址
---@return string 面板地址
function ShengSiBuPanel:GetResID()
    return ResID.UI_ShengSiBuPanel
end

---初始化
function ShengSiBuPanel:_Init()
    self:_InitReference();
    self:_InitListener();
end

---初始化UI
function ShengSiBuPanel:_InitReference()
    self._txtChampionDesc = UIUtil.GetChildByName(self._trsContent, "UILabel", "txtChampionDesc");
    self._txtChampion = UIUtil.GetChildByName(self._trsContent, "UILabel", "txtChampion"); 
    for i = 1, cfg.times do
        self[deathNamePrefix .. i] = UIUtil.GetChildByName(self._trsContent, "UILabel", deathNamePrefix .. i);
    end

    self._btnClose = UIUtil.GetChildByName(self._trsContent, "UIButton", "btnClose");
    self._btnJudge = UIUtil.GetChildByName(self._trsContent, "UIButton", "btnJudge");
end

---初始化监听器
function ShengSiBuPanel:_InitListener()
    self:_AddBtnListen(self._btnClose);
    self:_AddBtnListen(self._btnJudge);

    MessageManager.AddListener(ShengSiBuManager, ShengSiBuManager.MESSAGE_SELECTJUDGE, self.UpdatePanel, self);
end

---as.OpenUI穿进来的参数（打开面板时会被调用）
function ShengSiBuPanel:UpdatePanel(data)
    -- 一些运行时获取的数据 通过Manager获取，调用一次和多次的应该分开提高性能，目前都在每次更新时用Manager获取
    -- 类型 1-大天尊 2-大主宰
    self._type = ShengSiBuManager.GetChampionType()
    -- 是否是大天尊/大主宰
    self._isChampion = ShengSiBuManager.IsChampion()
    -- 大天尊/大主宰名字
    self._championName = ShengSiBuManager.GetChampionName()
    -- 目前使用的次数
    self._currentTimes = ShengSiBuManager.GetCurrentTimes()
    -- 死亡名字
    self._deathNames = ShengSiBuManager.GetDeathNames()

    -- 只有大天尊/大主宰才有审判按钮
    if (self._isChampion) then
        self._btnJudge.gameObject:SetActive(true);
    else
        self._btnJudge.gameObject:SetActive(false);
    end

    -- 设置大天尊/大主宰描述
    if (self._type == 1) then
        self._txtChampionDesc.text = "本届大天尊";
    elseif (self._type == 2) then
        self._txtChampionDesc.text = "本届大主宰";
    end

    self._txtChampion.text = self._championName;
    for i = 1, self._currentTimes do
        self[deathNamePrefix .. i].text = deathNames[i];
    end
end

---按钮点击事件
function ShengSiBuPanel:_OnBtnsClick(go)
    if go == self._btnClose.gameobject then
        as.CloseUI(as.FivePearlPanel)
    elseif go == self.btnJudge.gameObject and isChampion then
        as.OpenUI(as.ShengSiBuJudgePanel)
    end
end

---关闭页面
function ShengSiBuPanel:_Dispose()
    self:_DisposeListener()
    self:_DisposeReference()
end

---注销监听器
function ShengSiBuPanel:_DisposeListener()
    MessageManager.RemoveListener(ShengSiBuManager, ShengSiBuManager.MESSAGE_SELECTJUDGE, self.UpdatePanel, self);
end

---注销ui
function ShengSiBuPanel:_DisposeReference()

end

function ShengSiBuPanel:_OnBtnDisplayPlayerInfoClick()
end

return ShengSiBuPanel