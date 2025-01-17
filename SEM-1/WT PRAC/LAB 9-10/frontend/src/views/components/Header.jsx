import React from "react";
import "./header.css"; // Import the correct CSS
import { useNavigate } from "react-router-dom";

const Header = () => {
  const navigate = useNavigate();
  const role = localStorage.getItem("role");
  const userId = localStorage.getItem("userId");

  const handleLogout = () => {
    localStorage.removeItem("role");
    localStorage.removeItem("userId");
    navigate("/registrationPage");
  };

  return (
    <>
      {/* ======= Top Bar ======= */}
      <div id="topbar" className="topbar">
        <div className="topbar-container">
          <div className="contact-info">
            <i className="bi bi-envelope"></i>{" "}
            <a style={{ marginRight: "10px" }}>Mind@Sensei.com</a>
            <i className="bi bi-phone"></i>+91 9876543212
          </div>
          <div className="social-links">
            <a href="#" className="twitter">
              <i className="bi bi-twitter"></i>
            </a>
            <a href="#" className="facebook">
              <i className="bi bi-facebook"></i>
            </a>
            <a href="#" className="instagram">
              <i className="bi bi-instagram"></i>
            </a>
            <a href="#" className="linkedin">
              <i className="bi bi-linkedin"></i>
            </a>
          </div>
        </div>
      </div>

      {/* ======= Header ======= */}
      <header id="header" className="header">
        <div className="header-container">
          <h1 className="logo">
            <a href="/">MindSensei</a>
          </h1>

          <nav id="navbar" className="navbar">
            <ul>
              <li>
                <a className="nav-link" href="/">
                  Home
                </a>
              </li>
              <li>
                <a className="nav-link" href="#about">
                  About
                </a>
              </li>
              <li>
                <a className="nav-link" href="#services">
                  Services
                </a>
              </li>
              <li>
                <a className="nav-link" href="/doctors">
                  Doctors
                </a>
              </li>
              <li>
                <a className="nav-link" href="/blog">
                  Blogs
                </a>
              </li>
              {/* Conditionally render options for doctors */}
              {role === "doctor" && (
                <>
                  <li>
                    <a className="nav-link" href="/CreateBlog">
                      Create Blog
                    </a>
                  </li>
                  <li>
                    <a className="nav-link" href="/my-blog">
                      My Blog
                    </a>
                  </li>
                </>
              )}
            </ul>
          </nav>

          {/* Login and Register Buttons */}
          <div>
            {userId ? (
              <button className="button" onClick={handleLogout}>
                Logout
              </button>
            ) : (
              <button
                className="button"
                onClick={() => navigate(`/registrationPage`)}
              >
                Register
              </button>
            )}
          </div>
        </div>
      </header>
    </>
  );
};

export default Header;
