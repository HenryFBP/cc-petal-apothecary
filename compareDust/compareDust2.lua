os.loadAPI("/disk/henryLib");

local hfbp = henryLib
local r = redstone
local c = colors
local sideList = hfbp.sideList
local monitor = peripheral.wrap("right")
      monitor.setTextScale(0.5)
      
      
local dustPorts = {"left", "bottom"}
local productionToggle = "front"
local fullThreshOut = "back"
local fullThresh = 8 --zero through 15...

local fullChar =    {"#"," "}
local fullString =  {"INACTIVE", " ACTIVE "}

local sleepTime = 180

local numFull = 0


local function splitRead(file,delim)
    return hfbp.splitString(hfbp.readFile(file),delim)
end
      
local cArr = {c.white, c.orange, c.magenta, c.lightBlue, c.yellow, c.lime, c.pink, c.gray, c.lightGray, c.cyan, c.purple, c.blue, c.brown, c.green, c.red, c.black}

local dustListA = splitRead("/disk/data/dustListA.txt","\n")
local dustListB = splitRead("/disk/data/dustListB.txt","\n")
local dustLists = {dustListA, dustListB}

local dustTypes = 0

for itemA = 1, #dustLists do
  for itemB = 1, #dustLists[itemA] do
    dustTypes = dustTypes + 1 --count up all our types of dust from our arrays
  end
end

redstone.setAnalogOutput(fullThreshOut,fullThresh)

monitor.clear()
term.setCursorPos(1,1)

sleep(1) --so redstone updates


while true do

  numFull = 0 --so we reset it

  for itemA = 1, #dustPorts do --loop through num of dustPorts

    for itemB = 1, #dustLists[itemA] do --loop through dust list corresponding to current dustPorts

      local isFull = c.test(r.getBundledInput(dustPorts[itemA]), cArr[itemB]) --set isfull to redstone(side[islow],color[ifast])
      local ourStr = "[" .. hfbp.boolToStr(isFull,fullChar) .. "]"

      if isFull == true then numFull = numFull + 1 end --to increment what's full or not

      print(ourStr .. dustLists[itemA][itemB]) --print if we got dust + dustName

    end

    sleep(1)
    print("\n" .. hfbp.stringLine(monitor.getSize(),"=") .. "\n") --separator
    sleep(1)

  end

  -----
  -- past the item-checking code...
  -----

    print(numFull .. " / " .. dustTypes .. " are at least ".. fullThresh .." / 15 full")


    halted = hfbp.boolToStr((numFull >= dustTypes),fullString)
    print("Production is currently: ".. halted)

    if numFull >= dustTypes then --stop that fuckin item conduit broe!!!
      r.setOutput(productionToggle,true)
    else
      r.setOutput(productionToggle,false)
    end

    print("Sleeping for ".. sleepTime .." seconds.")
    sleep(sleepTime)

    monitor.clear()
    term.setCursorPos(1,1)

end