import React, { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faMapMarkerAlt,
  faCartShopping,
  faShoppingCart,
} from "@fortawesome/free-solid-svg-icons";
import brandLogo from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/brand_logo.png";
import shoe1 from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/shoe1.png";
import shoe2 from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/shoe2.png";
import shoe3 from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/shoe3.png";
import shoe4 from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/shoe4.png";
import shoe5 from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/shoe5.png";
import shoe6 from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/shoe6.png";
import shoe7 from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/shoe7.png";
import shoe8 from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/shoe8.png";
import flipkartLogo from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/flipkart.png";
import amazonLogo from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/amazon.png";
import { useNavigate } from "react-router-dom";

const ProductsDetailsPage = () => {
  const location = useLocation();
  const navigate = useNavigate();

  const queryParams = new URLSearchParams(location.search);
  const productId = queryParams.get("id");

  // Sample shoe data (replace this with real data fetching)
  const shoes = [
    {
      id: 1,
      name: "Nike Downshifter 13",
      description:
        "Whether you're starting your running journey or an expert eager to switch up your pace, the Downshifter 13 is down for the ride. With a revamped upper, cushioning and durability, it helps you find that extra gear or take that first stride towards chasing down your goals.",
      price: 4295,
      img: shoe1,
      descSmall: "Men's Road Running Shoes",
    },
    {
      id: 2,
      name: "Nike Dunk Low Retro",
      description:
        "Created for the hardwood but taken to the streets, the Nike Dunk Low Retro returns with crisp overlays and original team colours. This basketball icon channels '80s vibes with premium leather in the upper that looks good and breaks in even better. Modern footwear technology helps bring the comfort into the 21st century.",
      price: 8295,
      img: shoe2,
      descSmall: "Men's Shoes",
    },
    {
      id: 3,
      name: "Nike Air Max Ishod",
      description:
        "Infused with elements taken from iconic '90s hoops shoes, the Air Max Ishod is built with all the durability you need to skate hard. This creative twist on the original Ishod design features updated mesh, exposed Nike Air (with Max Air technology) and a cupsole that breaks in easily. Now step in and skate like you mean it.",
      price: 9207,
      img: shoe3,
      descSmall: "Men's Shoes",
    },
    {
      id: 4,
      name: "Nike Legend Essential 3 Next Nature",
      description:
        "Meet the trainer versatile enough to withstand the rigours of a fast-paced group class or a heavy day in the weight room. Equipped with a flat heel, high-abrasion materials and a flexible sole, it provides comfort and support that's ready to hit the gym. See the specks on the outsole? That means it's constructed with at least 8% Nike Grind material, made from scraps from the footwear-manufacturing process.﻿",
      price: 4995,
      img: shoe4,
      descSmall: "Men's Workout Shoes",
    },
    {
      id: 5,
      name: "Nike Impact 4",
      description:
        "Elevate your game and your hops. Charged with Max Air cushioning in the heel, this lightweight, secure shoe helps you get off the ground confidently and land comfortably. Plus, rubber wraps up the sides for added durability and stability.",
      price: 8067,
      img: shoe5,
      descSmall: "Men's Workout Shoes",
    },
    {
      id: 6,
      name: "Nike Free RN NN",
      description:
        "If it's freedom you crave, this road runner can help turn you loose. Feathery and flexible, its barefoot feel and Flyknit upper will have you freewheeling with joy, ready to go a few more strides.",
      price: 8257,
      img: shoe6,
      descSmall: "Men's Road Running Shoes",
    },
    {
      id: 7,
      name: "Nike Pegasus 41 Premium",
      description:
        "Responsive cushioning in the Pegasus provides an energised ride for everyday road running. Experience lighter-weight energy return with dual Air Zoom units and a ReactX foam midsole. Plus, improved engineered mesh on the upper decreases weight and increases breathability. Plus, an engineered lace toggle gives you a quick, adjustable fit.",
      price: 12795,
      img: shoe7,
      descSmall: "Men's Road Running Shoes",
    },
    {
      id: 8,
      name: "Nike ISPA Link Axis",
      description:
        "Continuing our journey to push the needle of Nike innovation, the ISPA Link Axis is an exploration into circular design with 100% recycled materials: Every part can be recycled, says the ISPA team. It represents progress over perfection—creating a product with a second life in mind. Guided by the principles of modularity and waste reduction, the design uses interlocking components of recycled Flyknit and plastic, as few materials as possible and zero glue. Experience the future of design in the present. And if or when you want to help extend the shoes life, simply drop em off at a participating Nike store for recycling.",
      price: 12795,
      img: shoe8,
      descSmall: "Men's Road Running Shoes",
    },
  ];

  // Find the shoe
  const shoe = shoes.find((shoe) => shoe.id.toString() === productId);

  console.log("Details");
  console.log(productId);
  console.log(shoe);

  const [selectedSize, setSelectedSize] = useState(null);

  const selectSize = (size) => {
    setSelectedSize(size);
  };

  const addToCart = () => {
    if (!selectedSize) {
      alert("Please select a size before adding to the cart!");
      return;
    }

    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    const productToAdd = {
      id: shoe.id,
      name: shoe.name,
      price: shoe.price,
      img: shoe.img,
      size: selectedSize,
    };

    cart.push(productToAdd);
    localStorage.setItem("cart", JSON.stringify(cart));
    alert(`${shoe.name} (Size: ${selectedSize}) has been added to your cart!`);
  };

  if (productId == undefined) {
    navigate("/error");
  }

  return (
    <div>
      {/* Header Section */}
      <header>
        <div className="logo-container">
          <img src={brandLogo} alt="Brand Logo" />
          <p id="jdi">JUST DO IT!</p>
        </div>

        <div className="cart-wishlist">
          <button
            id="wishlistbtn"
            onClick={() => {
              navigate("/cart");
            }}
          >
            <FontAwesomeIcon
              icon={faCartShopping}
              style={{
                fontSize: 30,
                display: "block",
                margin: "0 auto",
                color: "black",
              }}
            />
          </button>
        </div>
      </header>

      {/* Product Details Section */}
      <div id="productDetails">
        <div>
          <img
            id="productImage"
            src={shoe.img}
            alt="Product Image"
            style={{ width: "280px" }}
          />
        </div>
        <div>
          <h2 id="productName">{shoe.name}</h2>
          <p id="productDescription">{shoe.descSmall}</p>
          <p id="productPrice">₹ {shoe.price.toLocaleString()}</p>
          <br></br>
          <div id="tax">
            <p>Inclusive of all taxes</p>
            <p>(Also includes all applicable duties)</p>
          </div>
          <br></br>
          <div id="addToBagBtn" onClick={addToCart}>
            Add to Cart
          </div>
          <br></br>
          {/* <div id="favouriteBtn" onClick={addToFavorites}>
            Favourite
          </div> */}
        </div>
      </div>

      {/* Size Selection Section */}
      <div style={{ display: "flex", justifyContent: "space-evenly" }}>
        <div id="shoeDescription">
          <h3>Description</h3>
          <p>{shoe.description}</p>
        </div>
        <div id="sizeDiv">
          <div id="sizeRow">
            <div className="shoeSize" onClick={() => selectSize("UK 6")}>
              <p>UK 6</p>
            </div>
            <div className="shoeSize" onClick={() => selectSize("UK 6.5")}>
              <p>UK 6.5</p>
            </div>
            <div className="shoeSize" onClick={() => selectSize("UK 7")}>
              <p>UK 7</p>
            </div>
          </div>
          <br></br>
          <div id="sizeRow">
            <div className="shoeSize" onClick={() => selectSize("UK 7.5")}>
              <p>UK 7.5</p>
            </div>
            <div className="shoeSize" onClick={() => selectSize("UK 8")}>
              <p>UK 8</p>
            </div>
            <div className="shoeSize" onClick={() => selectSize("UK 8.5")}>
              <p>UK 8.5</p>
            </div>
          </div>
          <br></br>
          <div id="sizeRow">
            <div className="shoeSize" onClick={() => selectSize("UK 9")}>
              <p>UK 9</p>
            </div>
            <div className="shoeSize" onClick={() => selectSize("UK 9.5")}>
              <p>UK 9.5</p>
            </div>
            <div className="shoeSize" onClick={() => selectSize("UK 10")}>
              <p>UK 10</p>
            </div>
          </div>
          <br></br>
          <div id="sizeRow">
            <div className="shoeSize" onClick={() => selectSize("UK 11")}>
              <p>UK 11</p>
            </div>
            <div className="shoeSize" onClick={() => selectSize("UK 11.5")}>
              <p>UK 11.5</p>
            </div>
            <div className="shoeSize" onClick={() => selectSize("UK 12")}>
              <p>UK 12</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ProductsDetailsPage;
