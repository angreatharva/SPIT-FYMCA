import React, { useState, useEffect } from "react";
import brandLogo from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/brand_logo.png";
import { useNavigate } from "react-router-dom";

const CartPage = () => {
  const navigate = useNavigate();

  const [cartItems, setCartItems] = useState([]);

  useEffect(() => {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    setCartItems(cart);
  }, []);

  const removeFromCart = (id, size) => {
    const updatedCart = cartItems.filter(
      (item) => !(item.id === id && item.size === size)
    );
    localStorage.setItem("cart", JSON.stringify(updatedCart));
    setCartItems(updatedCart);
  };

  return (
    <div className="cart-page">
      {/* Header Section */}
      <header className="cart-header">
        <div className="logo-container">
          <img src={brandLogo} alt="Brand Logo" className="brand-logo" />
          <p className="tagline">JUST DO IT!</p>
        </div>

        {cartItems.length > 0 && (
          <button
            className="checkout-button"
            onClick={() => navigate("/checkout")}
          >
            Checkout
          </button>
        )}
      </header>

      <h1 className="cart-title">Your Cart</h1>
      {cartItems.length === 0 ? (
        <p className="empty-cart">Your cart is empty.</p>
      ) : (
        <ul className="cart-list">
          {cartItems.map((item, index) => (
            <li key={`${item.id}-${item.size}-${index}`} className="cart-item">
              <img src={item.img} alt={item.name} className="cart-item-img" />
              <div className="cart-item-details">
                <strong className="cart-item-name">{item.name}</strong>
                <span className="cart-item-price">
                  ₹{item.price.toLocaleString()}
                </span>
                <span className="cart-item-size">Size: {item.size}</span>
              </div>
              <button
                className="remove-button"
                onClick={() => removeFromCart(item.id, item.size)}
              >
                Remove
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default CartPage;
