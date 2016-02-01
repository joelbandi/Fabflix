package com.moviemafia.pikflix;

import java.util.HashMap;

public class ShoppingCart {
    
	private HashMap<Integer, Integer> cartItems;
    
    
    public ShoppingCart(){
     cartItems = new HashMap<>();
      
    }
    public HashMap<Integer, Integer> getCartItems(){
        return cartItems;
    }
    
    
    public void add(Integer itemId, int quantity){
    	if(cartItems.containsKey(itemId)){
    		int val = cartItems.get(itemId);
    		val++;
    		cartItems.put(itemId, val);
    	}else{
    		cartItems.put(itemId, quantity);
    	}
    }
    
    public void update(Integer itemId, int quantity){
    	cartItems.put(itemId, quantity);
    }
    
    public void delete(Integer itemId){
        cartItems.remove(itemId);
    }
}