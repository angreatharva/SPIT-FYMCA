import React from "react";
import { Link } from "react-router-dom";
import "./Navigation.css";

const Navigation = () => {
  return (
    <nav className="navbar">
      <ul className="nav-list">
        <li className="nav-item">
          <Link to="/Home" className="nav-link">
            Home
          </Link>
        </li>
        <li className="nav-item">
          <Link to="/About" className="nav-link">
            About
          </Link>
        </li>
        <li className="nav-item">
          <Link to="/Contact" className="nav-link">
            Contact
          </Link>
        </li>
      </ul>
    </nav>
  );
};

export default Navigation;
