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
    
    
    public void addToCart(Integer itemId, int quantity){
        cartItems.put(itemId, quantity);
    }
    
    public void deleteFromCart(Integer itemId){
        cartItems.remove(itemId);
    }
     
}