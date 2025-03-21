--T-天书生死簿基础配置表-shengsibu.xlsx
local shengsibu={
    id = 1,
    times = 7,
    duration = {
        360, 240, 180, 120
    },
    buffId = 901001,
    activity_id = {
        91, 86, 123
    },
    YY_activity_id = 36,
    acitvityTimeLimit = 900,
    message1 = 2964,
    message2 = 2965,
[1]={1,3,360,901001,900,2964,2965}
}
local ks={id=1,times=2,duration=3,buff_id=4,except_activity_time=5,message1=6,message2=7}
local base={__index=function(t,k) if k=='cks' then return ks end local ind=ks[k] local oriContent = ind and t[ind] return oriContent end} for k,v in pairs(shengsibu)do setmetatable(v,base) end base.__metatable=false
return shengsibu
