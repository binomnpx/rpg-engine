-- Equippable weapons, including in-hand behavior.

trident = {
  
  name = "trident",
  
  power = 2,
  range = 4,
  
  invoke = function(self)
    
    if player.hand == self then
    	 
    	 menus:add({unequip})
    	 
    else
    	 
    	 menus:add({equip})
    	 
    end
    
  end,
  
  draw = function(px, py)
    
    if player.s == player_sprite_frontleft then
    	 
    	 local xos = player.flip_x and player_hand_pxl_l or player_hand_pxl_r
    	 
    	 spr(19, px+xos, py)
    	 
    elseif player.s == player_sprite_back then
    	 
    	 local xos = player.flip_x and player_hand_pxl_back_flipped or player_hand_pxl_back
    	 
    	 spr(19, px+xos, py)
    	 
    else
    	 
    	 local xos = player.flip_x and player_hand_pxl_front_flipped or player_hand_pxl_front
    	 
    	 spr(19, px+xos, py)
    	 
    end
    
  end
  
}

