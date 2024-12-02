// import React from "react";
// import HomePage from "./components/Homepage";

// function App() {
//   return (
//     <div className="App">
//       <HomePage />
//     </div>
//   );
// }

// export default App;

import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import HomePage from "./components/Homepage";
import ProductDetailPage from "./components/productDetailsPage";
import CartPage from "./components/CartPage";
import Checkout from "./components/CheckoutPage";
import OrderConfirmation from "./components/OrderConfirmationPage";
import Error from "./components/Error";

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/" element={<HomePage />} />
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
