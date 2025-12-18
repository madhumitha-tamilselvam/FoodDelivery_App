package com.tap.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items = new HashMap<>();

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void addItem(CartItem item) {
        if(items.containsKey(item.getId())) {
            CartItem existing = items.get(item.getId());
            existing.setQuantity(existing.getQuantity() + item.getQuantity());
        } else {
            items.put(item.getId(), item);
        }
    }

    public void updateItem(int id, int quantity) {
        if(items.containsKey(id)) {
            if(quantity <= 0) {
                items.remove(id);
            } else {
                items.get(id).setQuantity(quantity);
            }
        }
    }

    public void removeItem(int id) {
        items.remove(id);
    }

    public double getTotal() {
        return items.values().stream().mapToDouble(CartItem::getTotal).sum();
    }
}
