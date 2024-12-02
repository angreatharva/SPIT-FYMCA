import React from "react";
import { useLocation, useNavigate } from "react-router-dom";

const OrderConfirmationPage = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { formData } = location.state || {};

  return (
    <div style={{ textAlign: "center", padding: "20px" }}>
      <h1>Order Confirmation</h1>
      {formData ? (
        <div>
          <p style={{ fontSize: "18px", margin: "20px 0" }}>
            <strong>Thank you for your order, {formData.name}!</strong>
          </p>
          <p>Your order has been placed successfully and will be shipped to:</p>
          <div
            style={{
              border: "1px solid #ddd",
              padding: "15px",
              margin: "10px auto",
              maxWidth: "400px",
              borderRadius: "8px",
              textAlign: "left",
            }}
          >
            <p>
              <strong>Address:</strong> {formData.address}, {formData.city},{" "}
              {formData.state}, {formData.zip}
            </p>
            <p>
              <strong>Phone:</strong> {formData.phone}
            </p>
            <p>
              <strong>Payment Method:</strong> {formData.paymentMethod}
            </p>
          </div>
          <p style={{ margin: "20px 0" }}>
            You will receive an email confirmation shortly. Your order will
            arrive within 5-7 business days.
          </p>
          <button
            style={{
              backgroundColor: "#28a745",
              color: "white",
              border: "none",
              padding: "10px 20px",
              borderRadius: "5px",
              cursor: "pointer",
              fontSize: "16px",
            }}
            onClick={() => navigate("/")}
          >
            Continue Shopping
          </button>
        </div>
      ) : (
        <div>
          <p>No order details found.</p>
          <button
            style={{
              backgroundColor: "#007bff",
              color: "white",
              border: "none",
              padding: "10px 20px",
              borderRadius: "5px",
              cursor: "pointer",
              fontSize: "16px",
            }}
            onClick={() => navigate("/cart")}
          >
            Go to Cart
          </button>
        </div>
      )}
    </div>
  );
};

export default OrderConfirmationPage;
