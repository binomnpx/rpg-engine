-- Consumable and usable item definitions.

apple = {
  
  name = "apple",
  
  invoke = function()
    
    messages:add("yum", player.x, player.y)
    
    deli(player.inventory, menus[#menus].index+1)
    
    menus:quit()
    
  end
  
}


orange = {
  
  name = "orange",
  
  invoke = function()
    
    messages:add("yum", player.x, player.y)
    
    deli(player.inventory, menus[#menus].index+1)
    
    menus:quit()
    
  end
  
}


banana = {
  
  name = "banana",
  
  invoke = function()
    
    messages:add("yum", player.x, player.y)
    
    deli(player.inventory, menus[#menus].index+1)
    
    menus:quit()
    
  end
  
}


potion = {
  
  name = "potion",
  
  invoke = function()
    
    menus:add({drink, toss})
    
  end
  
}


