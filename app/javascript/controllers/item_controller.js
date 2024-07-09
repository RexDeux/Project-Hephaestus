// app/javascript/controllers/item_controller.js

import { Controller } from "stimulus";

export default class extends Controller {
  addToCart() {
    const itemId = this.itemId;
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    fetch("/line_items", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ item_id: itemId })
    })
    .then(response => {
      if (response.ok) {
        console.log("Item added to cart successfully");
        // Optionally update UI or show a message
      } else {
        console.error("Failed to add item to cart");
        // Handle error scenario
      }
    })
    .catch(error => {
      console.error("Error adding item to cart:", error);
      // Handle network error
    });
  }

  // Getters for data attributes
  get itemId() {
    return this.data.get("itemId");
  }

  // Action to see cart
  seeCart() {
    const cartPath = this.cartPath;
    window.location.href = cartPath;
  }

  // Getters for data attributes
  get itemId() {
    return this.data.get("itemId");
  }

  get cartPath() {
    return this.data.get("cartPath");
  }
}
