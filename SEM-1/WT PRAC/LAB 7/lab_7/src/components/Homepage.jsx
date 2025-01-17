import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faMapMarkerAlt,
  faPhone,
  faEnvelope,
  faComments,
} from "@fortawesome/free-solid-svg-icons";
import { faInstagram, faFacebook } from "@fortawesome/free-brands-svg-icons";
import "../components/style.css";
import brandLogo from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/brand_logo.png";
import shoeMain from "D:/SPIT-FYMCA/WT PRAC/LAB 7/lab_7/src/assets/images/NIKE+REVOLUTION+7.jpeg";
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

const HomePage = () => {
  const navigate = useNavigate();
  return (
    <div>
      {/* Header Section */}
      <header>
        <div className="logo-container">
          <img src={brandLogo} alt="Brand Logo" />
          <p id="jdi">JUST DO IT!</p>
        </div>

        <nav className="nav-menu">
          <p className="header-item">
            <a
              href="#products"
              style={{
                textDecoration: "none",
                color: "#000",
                fontWeight: "500",
              }}
            >
              Products
            </a>
          </p>
          <p className="header-item">
            <a
              href="#outlets"
              style={{
                textDecoration: "none",
                color: "#000",
                fontWeight: "500",
              }}
            >
              Outlets
            </a>
          </p>
          <p className="header-item">
            <a
              href="#contactUs"
              style={{
                textDecoration: "none",
                color: "#000",
                fontWeight: "500",
              }}
            >
              Contact
            </a>
          </p>
        </nav>

        <div className="auth-buttons">
          <button id="reg">Register</button>
          <button id="sig">Sign In</button>
        </div>
      </header>

      {/* Home Section */}
      <section id="Home">
        <div style={{ marginLeft: "7.5%" }}>
          <div style={{ display: "flex" }}>
            <div style={{ width: "50%" }}>
              <div style={{ fontSize: "80px", fontWeight: "900" }}>
                <p>
                  YOUR FEET
                  <br />
                  DESERVE
                  <br />
                  THE BEST
                </p>
              </div>
              <div
                style={{
                  fontSize: "larger",
                  width: "50%",
                  fontWeight: "500",
                  marginTop: "0.5%",
                }}
              >
                Experience unmatched comfort and style with shoes crafted for
                every step. Because your feet deserve nothing but the best.
              </div>
            </div>
            <div style={{ marginTop: "5%", transform: "rotate(-20deg)" }}>
              <img id="shoe" src={shoeMain} alt="Shoe" />
            </div>
          </div>

          <div style={{ marginTop: "2%" }}>
            <a href="https://www.nike.com/in/" target="_blank" rel="noreferrer">
              <button id="shopNow">Shop Now</button>
            </a>
          </div>
          <div style={{ marginTop: "2%" }}>
            Also available on
            <br />
            <br />
            <div
              style={{
                display: "flex",
                width: "100px",
                justifyContent: "space-between",
              }}
            >
              <a
                href="https://www.flipkart.com/mens-footwear/nike~brand/pr?sid=osp%2Ccil&p%5B%5D=facets.brand%255B%255D%3DNIKE"
                target="_blank"
                rel="noreferrer"
              >
                <img src={flipkartLogo} alt="Flipkart" />
              </a>
              <a
                href="https://www.amazon.in/s?k=nike+shoes"
                target="_blank"
                rel="noreferrer"
              >
                <img id="amazon" src={amazonLogo} alt="Amazon" />
              </a>
            </div>
          </div>
        </div>
      </section>

      {/* Products Section */}
      <section id="products">
        <div style={{ margin: "7.5%" }}>
          <h1>Products</h1>
          <br />
          <div
            style={{
              display: "flex",
              overflowX: "auto",
              width: "100%",
              maxHeight: "400px",
              padding: "10px",
            }}
          >
            {[
              {
                id: 1,
                name: "Nike Downshifter 13",
                price: 4295,
                img: shoe1,
                descSmall: "Men's Road Running Shoes",
              },
              {
                id: 2,
                name: "Nike Dunk Low Retro",
                price: 8295,
                img: shoe2,
                descSmall: "Men's Shoes",
              },
              {
                id: 3,
                name: "Nike Air Max Ishod",
                price: 9207,
                img: shoe3,
                descSmall: "Men's Shoes",
              },
              {
                id: 4,
                name: "Nike Legend Essential 3 Next Nature",
                price: 4995,
                img: shoe4,
                descSmall: "Men's Workout Shoes",
              },
              {
                id: 5,
                name: "Nike Impact 4",
                price: 8067,
                img: shoe5,
                descSmall: "Men's Workout Shoes",
              },
              {
                id: 6,
                name: "Nike Free RN NN",
                price: 8257,
                img: shoe6,
                descSmall: "Men's Road Running Shoes",
              },
              {
                id: 9,
                name: "Nike Pegasus 41 Premium",
                price: 12795,
                img: shoe7,
                descSmall: "Men's Road Running Shoes",
              },
              {
                id: 8,
                name: "Nike ISPA Link Axis",
                price: 12795,
                img: shoe8,
                descSmall: "Men's Road Running Shoes",
              },
            ].map((shoe) => (
              <div
                key={shoe.id}
                className="shoeContainer"
                style={{ display: "inline-block", marginRight: "20px" }}
                onClick={() => navigate(`/productsDetailsPage?id=${shoe.id}`)}
              >
                <div style={{ textAlign: "center", width: "100%" }}>
                  <img
                    src={shoe.img}
                    style={{ width: "280px" }}
                    alt={shoe.name}
                  />
                  <h4>{shoe.name}</h4>
                  <p>{shoe.descSmall}</p>
                  <p>MRP : ₹ {shoe.price.toLocaleString()}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section id="outlets">
        <div style={{ margin: "7.5%" }}>
          <h1>Visit Our Stores</h1>
          <br />
          <p style={{ fontSize: "larger", fontWeight: 500 }}>
            Step into one of our stores to experience our shoe collection in
            person! Whether you're looking for the latest styles, expert fitting
            advice, or just want to browse, our friendly team is here to help
            you find your perfect pair.
          </p>
          <br />
          <div style={{ display: "flex", justifyContent: "space-around" }}>
            {[
              {
                title: "Nike Jio World Drive",
                address: `G-32 & F-30, Jio World Drive Mall, Makers Maxity Avenue,
                  Near Family court, Bandra Kurla Complex, Bandra East Mumbai,
                  Maharashtra, 400051.`,
                hours: "Opens at 9:00 am • Closes at 10:00 pm",
              },
              {
                title: "Nike Colaba 1",
                address: `Shahid Bhagat Singh Marg, Colaba, Mumbai, Maharashtra, 400001.`,
                hours: "Opens at 9:00 am • Closes at 10:00 pm",
              },
              {
                title: "Nike Colaba 4",
                address: `Shop No. 2, Harbour View Bridge, 29 Colaba Causeway,
                  SBS Marg, Colaba Mumbai, Maharashtra, 400005.`,
                hours: "Opens at 9:00 am • Closes at 10:00 pm",
              },
              {
                title: "Nike Mumbai",
                address: `Unit No: G-3B, Block 17 G1, Courtyard, High Street Phoenix
                  Mall, Lower Parel West, Mumbai, Maharashtra, 400013.`,
                hours: "Opens at 9:00 am • Closes at 10:00 pm",
              },
              {
                title: "Nike Linking 6",
                address: `Ground floor, Plot No 85, Ramee Emerald-II Linking Road,
                  Opp. ICICI Bank Mumbai, Maharashtra, 400054.`,
                hours: "Opens at 9:00 am • Closes at 10:00 pm",
              },
              {
                title: "Nike Seawood",
                address: `F-2-SH, SeaWoods Grand Central R-1, Sector-40 Node Nerul,
                  Seawood Railway station Navi Mumbai, Maharashtra, 400706.`,
                hours: "Opens at 9:00 am • Closes at 10:00 pm",
              },
            ].map((store, index) => (
              <div
                key={index}
                style={{
                  display: "flex",
                  width: 200,
                  border: "1px solid #000",
                  borderRadius: 5,
                  padding: 10,
                  alignItems: "center",
                }}
              >
                <div style={{ textAlign: "center", width: "100%" }}>
                  <FontAwesomeIcon
                    icon={faMapMarkerAlt}
                    style={{ fontSize: 30, display: "block", margin: "0 auto" }}
                  />
                  <h4>{store.title}</h4>
                  <p>{store.address}</p>
                  <p>{store.hours}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section id="contactUs">
        <div style={{ margin: "7.5%" }}>
          <h1>Get in Touch with Us</h1>
          <br />
          <p style={{ fontSize: "larger", fontWeight: 500 }}>
            We’re here to help you step into your perfect pair! Whether you have
            questions about sizing, need assistance with an order, or want to
            know more about our latest styles, our team is ready to assist.
            Don’t hesitate to get in touch—we’d love to hear from you!
          </p>
          <br />
          <p style={{ fontSize: "large", fontWeight: 300 }}>Customer Care:</p>
          <br />
          <div style={{ display: "flex", justifyContent: "space-evenly" }}>
            {[
              {
                icon: faPhone,
                title: "Call Us",
                details: ["0008009190566", "9:00 - 22:00", "7 days a week"],
              },
              {
                icon: faEnvelope,
                title: "Email Us",
                details: ["We'll reply in five business days"],
              },
              {
                icon: faComments,
                title: "Chat With Us",
                details: ["9:00 - 22:00", "7 days a week"],
              },
            ].map((contact, index) => (
              <div key={index} style={{ textAlign: "center" }}>
                <FontAwesomeIcon
                  icon={contact.icon}
                  style={{ color: "black", fontSize: "30px" }}
                />
                <p>{contact.title}</p>
                {contact.details.map((line, idx) => (
                  <p key={idx}>{line}</p>
                ))}
              </div>
            ))}
          </div>
          <br />
          <div style={{ display: "flex", justifyContent: "center" }}>
            <p>
              Connect on Social Media: Stay in the loop with our latest
              collections, exclusive promotions, and customer stories. Follow us
              on social media:
            </p>
          </div>
          <br />
          <div style={{ display: "flex", justifyContent: "space-evenly" }}>
            {[
              {
                icon: faInstagram,
                description:
                  "For sneak peeks, style inspiration, and behind-the-scenes action.",
              },
              {
                icon: faFacebook,
                description:
                  "Join our community for product updates and exclusive deals.",
              },
            ].map((social, index) => (
              <div key={index} style={{ textAlign: "center" }}>
                <FontAwesomeIcon
                  icon={social.icon}
                  style={{ fontSize: "30px", color: "black" }}
                />
                <p>{social.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
};

export default HomePage;
