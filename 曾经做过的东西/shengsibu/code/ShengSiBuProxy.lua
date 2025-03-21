--[[
    Author: guqiulei
    Date: 2025-01-20 16:14:04
    Description: xxx 交互类
]]

local ShengSiBuProxy =  class("ShengSiBuProxy", BaseNetPacket);
local self = ShengSiBuProxy;

---初始化网络监听方法
function ShengSiBuProxy:_InitCallBackFuncTable()
    self.callBackFuncTable  = {
        --[[
            0x0000
            接口描述
            输入：
            
            输出：
            
        ]]
        [CmdType.TYPE_CODE] = function(cmd, data)
            if(data and data.errCode == nil) then
                
            end
        end
    }
end


function ShengSiBuProxy.FUNC_NAME(careerId)
    SocketClientLua.Get_ins():SendMessage(CmdType.TYPE_CODE, { })
end

return ShengSiBuProxy