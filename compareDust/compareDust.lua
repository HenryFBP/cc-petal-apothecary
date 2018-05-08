os.loadAPI("/disk/henryLib");

local hfbp = henryLib
local r = redstone
local c = colors
local sideList = hfbp.sideList
local monitor = peripheral.wrap("right")
      monitor.setTextScale(0.5)

local cArr = {c.white, c.orange, c.magenta, c.lightBlue, c.yellow, c.lime, c.pink, c.gray, c.lightGray, c.cyan, c.purple, c.blue, c.brown, c.green, c.red, c.black}

local dustListA = hfbp.splitString(hfbp.readFile("/disk/data/dustListA.txt"),"\n")
local dustListB = hfbp.splitString(hfbp.readFile("/disk/data/dustListB.txt"),"\n")
local dustLists = {dustListA, dustListB}

local dustTypes = 0

for itemA in #dustLists do
  for itemB in #dustLists[itemA] do
    dustTypes = dustTypes + 1 --count up all our types of dust from our arrays
  end
end

local dustPorts = {"top", "left"}

local pasta = {"#"," "}
local spaghet = {"INACTIVE", " ACTIVE "}

local sleepTime = 180

local numFull = 0

monitor.clear()
term.setCursorPos(1,1)

sleep(1) --so redstone updates


while true do

  numFull = 0 --so we reset it

  for itemA = 1, #dustPorts do --loop through num of dustPorts

    for itemB = 1, #dustLists[itemA] do --loop through dust list corresponding to current dustPorts

      local isFull = c.test(r.getBundledInput(dustPort[itemA]), cArr[item]) --set isfull to redstone(side[i],color[i])
      local ourStr = "[" .. hfbp.boolToStr(isFull,pasta) .. "]"

      if isFull == true then numFull = numFull + 1 end --to increment what's full or not

      print(ourStr .. dust) --print if we got dust + dustName

    end

    sleep(1)
    print("\n" .. hfbp.stringLine(monitor.getSize(),"=") .. "\n") --separator
    sleep(1)

  end

      print("Using " .. numFull .. " / ".. dustTypes .." slots.")

      halted = hfbp.boolToStr((numFull >= dustTypes),{"INACTIVE","ACTIVE"})
      print("Production is currently: ".. halted)

      if numFull >= dustTypes then
          r.setOutput("front",true)
      else
          r.setOutput("front",false)
      end
      --stop that fuckin item conduit broe!!!

      print("Sleeping for ".. sleepTime .." seconds.")
      sleep(sleepTime)

      monitor.clear()
      term.setCursorPos(1,1)

  end
end

--monitor.clear()
