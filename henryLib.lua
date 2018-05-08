--henryLib.lua

function stringToCharArray(string)

  local ret = {}

  for i = 1, #string do
    local c = string:sub(i,i)

    table.insert(ret, c)

  end
  return ret
end

local r = redstone
local c = colors
local sideList = {"left","right","front","back","bottom","top"}
local digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local upperLett = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local lowerLett = "abcdefghijklmnopqrstuvwxyz"

local upperLettArr = stringToCharArray(upperLett)
local lowerLettArr = stringToCharArray(lowerLett)
local lettCaseDict = {}

for item = 1, #upperLettArr do
  lettCaseDict[upperLettArr[item]] = lowerLettArr[item] --set arr["A"] = "a"
end

for item = 1, #lowerLettArr do
  lettCaseDict[lowerLettArr[item]] = upperLettArr[item] --set arr["b"] = "B"
end


local colorArray = {c.white, c.orange, c.magenta, c.lightBlue, c.yellow, c.lime, c.pink, c.gray, c.lightGray, c.cyan, c.purple, c.blue, c.brown, c.green, c.red, c.black}
local colorStringArr = {"White","Orange","Magenta","Light Blue","Yellow","Lime","Pink","Gray","Light Gray","Cyan","Purple","Blue","Brown","Green","Red","Black"}
for item = 1, #colorArray do
  colorDict[colorStringArr[item]] = colorArray[item] --cd["White"] = colors.white, etc...
end

function toUpper(string)
  local stringArr = stringToCharArray(string)
  
  for item = 1, #stringArr do
    if isLower(stringArr[item]) then --we must convert bc it is lowercase
      stringArr[item] = lettCaseDict[stringArr[item]]
    end
  end
  
  return flattenStringArray(stringArr,"")
end

function toLower(string)
  local stringArr = stringToCharArray(string)
  
  for item = 1, #stringArr do
    if isUpper(stringArr[item]) then --we must convert bc it is uppercase
      stringArr[item] = lettCaseDict[stringArr[item]]
    end
  end
  
  return flattenStringArray(stringArr,"")
end

function slice(tbl,first,last,step)
  local ret = {}
  
  for i = first or 1, last or #tbl, step or 1 do --these "or" thingies make ALL ARGS OPTIONAL! YAY!!!!
    ret[#ret + 1] = tbl[i]
  end
  
  return ret
end

function flattenStringArray(stringArray,delim)
  if delim == nil then delim = "" end
  ret = ""
  
  ret = ret .. stringArray[1] --no fuckin annoying leading delim
  
  for item = 2, #stringArray do
    ret = ret .. delim .. stringArray[item]
  end
  return ret
end

function writeFile(path,string)
  local file = fs.open(path,"w")
  if file == nil then error("Could not open file at path "..path) end --error handling
  file.write(string)
  file.close()
end

function print_r(list, size)
  for item = 1, (size or #list) do
    print("[".. item .."]"..list[item])
  end
end

function pulseBundledOutput(side, colors, times, delay, offsetDelay)
  for i = 1, times do
    sleep(delay)
    r.setBundledOutput(side,colors)
    
    sleep(offsetDelay) --to fire RS event
    redstone.setBundledOutput(side,0)
  
  end
end


function pulseAnalogOutput(times, delay, offsetDelay, side, strength)

  for i=1,times do
    
    sleep(delay)
    redstone.setAnalogOutput(side,strength)
    
    sleep(offsetDelay) --so we fire rs event
    redstone.setAnalogOutput(side,0)
  end    

end


function stringToCharArray(string)

  local ret = {}

  for i = 1, #string do
    local c = string:sub(i,i)

    table.insert(ret, c)

  end
  return ret
end

function strip_whitespace(string) --strips whitespace from front and back of string, i.e. "  poo p   " -> "poo p".
  local stringArr = stringToCharArray(string)
  
  local begPos = 0 --our position to stop chopping left side of string
  local endPos = #stringArr --our position to stop chopping right side of string
  
    
  for item = 1, #stringArr do --find our first place to stop 
  
    if stringArr[item] ~= " " then break end --not whitespace, gtfo
    
    begPos = begPos + 1 --if we're here, we've iterated over 1 position and can safely add 1 to begPos
  end
    
  for item = #stringArr, 1, -1 do --find our last place to stop, but loop backwardsy
    if stringArr[item] ~= " " then break end --not whitespace, gtfo
     
    endPos = endPos - 1 --we good one one position from da back from da back
  end
  
  return string:sub(begPos+1,endPos) --snippity snippity got ur...whitespace-ippity
  
end

function binarySearchRec(list,item,bot,top)
  
  if bot == nil then bot = 1 end --these two lines make these args optional! woo!!!!! WOOOOOOOOOO!!!!!
  if top == nil then top = #list end
  
  if (bot >= top) then return nil end --vat te fak??? pls never happen......
  if (top > #list+1) then return nil end --val too high
  if (bot < 1) then return nil end --val too low
  
  local mid = math.floor((top + bot)/2) --6 = 0+12/2 or 5 = 2+12/2
  print("top = "..top..", mid = "..mid..", bot = "..bot)
  
  if list[mid] == item then return list[mid] end --we gots it!!!11
  
  if top == #list and mid == top - 1 then
    if list[top] == item then return list[top] end
    return nil
  end
  
  if list[mid] < item then
    print("list["..mid.."] = "..list[mid]..", it is < "..item) --we need to search the right side...
    return binarySearchRec(list,item,mid,top)
  end
  
  if list[mid] > item then 
    print("list["..mid.."] = "..list[mid]..", it is > "..item) --we need to search the left side...
    return binarySearchRec(list,item,bot,mid)
  end
  
end

function remove_items(haystack,needle)
  local item = 1
  while item < #haystack+1 do
    if haystack[item] == needle then
      table.remove(haystack,item)
      item = item - 1 --our list is 1 smaller, we must check to see if next elem is...poopy...
    end
    item = item + 1 --all good, proceed
  end
  return haystack
end



function reverse_table(list) --because i can't write a toBaseN function like a sane human bean
  local ret = {}

  for item = 1, #list do
    table.insert(ret, list[ (#list-item+1) ]) --flip le shit
  end
  
  return ret
end


function boolToStr(bool, stringPastabilities)

  if bool == true then
    return stringPastabilities[1]
  end

  if bool == false then
    return stringPastabilities[2]
  end

  return "bool aint no bool u fool"

end


function stringLine(length, char)
  local ret = ""
  for item = 1, length do
    ret = ret .. char
  end
  return ret

end

function test(a,b)
  return a+b+1
end

function readFile(path)
  local file = fs.open(path,"r")
  local retStr = file.readAll()
  file.close()
  return retStr
end

function splitStringButOnlyOneCharacterGoddamnit(string, delim) --delim must be ONE CHARACTER OR I WILL SHIT MY PANTS

  local splitArr = stringToCharArray(string)
  local ret = {}
  local retIdx = 1
  local tempStr = ""

  for item = 1, #splitArr do

    if splitArr[item] == delim then --we must split the string, delim encountered!!

      --print("found "..delim)
      table.insert(ret, tempStr)
      tempStr = ""
      retIdx = retIdx + 2
      item = item + 0
    else
      --print("adding "..splitArr[item].." to "..tempStr)
      tempStr = tempStr .. splitArr[item]
    end
  end

  table.insert(ret, tempStr)
  return ret

end



function splitString(string, delim) --now it can be more than one char....i...think...
  local string = string .. delim --to solve that weird error....
  local stringArr = stringToCharArray(string)
  local retArr = {}
  local lastDelim = 1
  
  for item = 1, (#stringArr-#stringToCharArray(delim)+1) do --instead of looking at char, we look at a SLICE...
    local currSlice = slice(stringArr,item,#stringToCharArray(delim)+item-1) --look at string[item:#delim+item]
    print("currSlice = "..flattenStringArray(currSlice)..", item = "..item)
    
    if flattenStringArray(currSlice) == delim then --if we have a delimiter
      print("found us a juicy delimiter!!!!")
      
      local toInsert = flattenStringArray(slice(stringArr,lastDelim,item-1))
      print(toInsert)
      
      lastDelim = item + #stringToCharArray(delim)--so we can put the next val in...
      table.insert(retArr,toInsert)
    end
    
  end
  return retArr
end


function resetBundledOutput()
  for item = 1, #sideList do
    r.setBundledOutput(sideList[item],0)
  end
end

function resetOutput()
  for item = 1, #sideList do
    r.setOutput(sideList[item],false)
  end
end

function numToBaseN(number,base)

  local ret = {}
  local maxBase = 0 --where our highest value is

  while number >= math.pow(base,maxBase) do--while highest column not big enough
    maxBase = maxBase + 1 --init our maxBase
    table.insert(ret,0)
  end

  while number > 0 do --while still leftover number

    if number >= math.pow(base,maxBase) then --while we can still subtract
      ret[maxBase+1] = (ret[maxBase+1] + 1) --add to digits place
      number = number - math.pow(base,maxBase) --take what we just added

    else --we cant subtract :(
      maxBase = maxBase - 1 --take down the base^(baseloc) to base^(baseloc-1)
    end

  end
  ret = reverse_table(ret)
  return ret --returns array wit some numbers
end

function decimalToPercent(number) --probably do that decimal to percent conversion bruh
  return (string.format("%4d",(number*100))).."%" --i.e. take 0.56 get 56.00%
end


