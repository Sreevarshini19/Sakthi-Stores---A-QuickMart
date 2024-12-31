package com.varshini;
public class CartItem {
  private int quantity;
  private float price;
private String product_name;
  public CartItem(String pname,int quantity, float price) {
      this.quantity = quantity;
      this.price = price;
      this.product_name=pname;
  }

  public int getQuantity() {
      return quantity;
  }
  public String getProductName() {
      return product_name;
  }
  public void setQuantity(int quantity) {
      this.quantity = quantity;
  }

  public float getPrice() {
      return price;
  }

  public void setPrice(float price) {
      this.price = price;
  }
}