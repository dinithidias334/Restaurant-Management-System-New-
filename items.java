package com.resturent.model;

public class items {

    private int id;
    private String name;
    private double price;
    private String category;
    private String image;
    public int quantity;

    //normal coustructor
    public items() {

    }

    //paramitarize constructor
    public items(int id, String name, double price,String image,String category, int quantity) {

        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.category = category;
        this.quantity = quantity;
    }

    //setters
    public void setId(int id) {
        this.id=id;
    }
    public void setName(String name) {
        this.name=name;
    }
    public void setPrice(double price) {
        this.price=price;
    }
    public void setImage(String image) {
        this.image=image;
    }
    public void setCategory(String category) {
        this.category=category;
    }
    public void setQuantity(int quantity) {
        this.quantity=quantity;
    }

    //getters
    public int getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public double getPrice() {
        return price;
    }
    public String getImage() {
        return image;
    }
    public String getCategory() {
        return category;
    }
    public int getQuantity() {
        return quantity;
    }

}
