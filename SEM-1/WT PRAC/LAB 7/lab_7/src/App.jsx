import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import HomePage from "./components/Homepage";
import ProductDetailPage from "./components/productDetailsPage";
import CartPage from "./components/CartPage";
import Checkout from "./components/CheckoutPage";
import Authenticate from "./components/auth";
import OrderConfirmation from "./components/OrderConfirmationPage";
import Error from "./components/Error";

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/homePage" element={<HomePage />} />
          <Route path="/" element={<Authenticate />} />
          <Route path="/productsDetailsPage" element={<ProductDetailPage />} />
          <Route path="/cart" element={<CartPage />} />
          <Route path="/checkout" element={<Checkout />} />
          <Route path="/order-confirmation" element={<OrderConfirmation />} />
          <Route path="/error" element={<Error />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
