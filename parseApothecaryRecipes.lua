--parseApothecaryRecipes.lua

--os.loadAPI("/disk/henryLib");

hfbp = henryLib


function parse_recipe_file(rawFile)
  
  print("hey henry, please fix the [ 1234] bug...please...fiiiix plsszszs")
  sleep(1)
  
  local rawString = hfbp.readFile(rawFile)--just an ugly string, \n and whitespace, etc...
  
  local stringArrCR = hfbp.splitString(rawString,"\n") --separated by "\n"
        stringArrCR = hfbp.remove_items(stringArrCR,"") --now we have a proper list...
        
  local parsedRecipes = {}
  
  
  for data = 1, #stringArrCR do --loop through all single, unparsed recipes
    local pos = 1
    local singleRecipe = {}
    local ourString = stringArrCR[data]
    
--    sleep(1)
--    print("processing "..ourString)
--    sleep(1)
     
    singleRecipe = hfbp.splitString(ourString,">") -- read in the > sign
    singleRecipe = hfbp.flattenStringArray(singleRecipe,",") --flatten so we can take in commas
    singleRecipe = hfbp.splitString(singleRecipe,",") --read in commas if any
    
    --handle pos 1, aka the output
    singleRecipe[1] = {hfbp.strip_whitespace(singleRecipe[1]),1}
    
    for item = 2, #singleRecipe do --handle the recipe ingredients
      local tempRecipe = {}
      singleRecipe[item] = hfbp.strip_whitespace(singleRecipe[item]) --to split across remaining space, i.e. "[1] AssPetal" is output
      tempRecipe = hfbp.splitString(singleRecipe[item],"]") --remove the rbracket
      
    
      tempRecipe[2] = hfbp.strip_whitespace(tempRecipe[2]) --remove whitespace
      
      tempRecipe[1] = string.sub(tempRecipe[1],2,#tempRecipe) --remove lbracket
      
      tempRecipe[1] = tonumber(tempRecipe[1])
      
      singleRecipe[item] = tempRecipe --apply le changes
      
    end
    
    table.insert(parsedRecipes,singleRecipe) --insert our pretty recipeArr into our recipeList
    
--    sleep(1)
--    print(textutils.serialize(singleRecipe))
--    sleep(1)
    end
  
  --print("about to write file to "..outputFile)
  return parsedRecipes
end
  
  function write_recipe_file(path, parsedFile)
    hfbp.writeFile(path,textutils.serialize(parsedFile))
  end
  
  function read_recipe_file(path)
    return textutils.unserialize(hfbp.readFile(path))
  end
  
  
  
end

