import React from 'react';
import './Footer.css';  // Assuming you have a separate CSS file for styling the footer

const Footer = () => {
  return (
<footer id="footer">
  <div className="footer-top">
    <div className="container">
      <div className="row">
        <div className="footer-section">
          <div className="footer-contact">
            <h3>MindSensei</h3>
            <p>
              SPIT Adam ROAD <br />
              Munshi Nagar, Andheri(W)<br />
              <strong>Phone:</strong> +91 9876543211<br />
              <strong>Email:</strong> mind@sensei.com<br />
            </p>
          </div>
        </div>
        
        <div className="footer-section">
          <div className="footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i className="bx bx-chevron-right"></i> <a href="#">Home</a></li>
              <li><i className="bx bx-chevron-right"></i> <a href="#">About us</a></li>
              <li><i className="bx bx-chevron-right"></i> <a href="#">Services</a></li>
              <li><i className="bx bx-chevron-right"></i> <a href="#">Blogs</a></li>
              <li><i className="bx bx-chevron-right"></i> <a href="#">Appointment</a></li>
            </ul>
          </div>
        </div>
        
        <div className="footer-section">
          <div className="footer-services">
            <h4>Our Services</h4>
            <ul>
              <li><i className="bx bx-chevron-right"></i> <a href="#">Online Child Therapy</a></li>
              <li><i className="bx bx-chevron-right"></i> <a href="#">Online Couple Therapy</a></li>
              <li><i className="bx bx-chevron-right"></i> <a href="#">Online Therapy For Stress</a></li>
              <li><i className="bx bx-chevron-right"></i> <a href="#">Online Therapy For Depression</a></li>
              <li><i className="bx bx-chevron-right"></i> <a href="#">Personal Growth Therapy</a></li>
            </ul>
          </div>
        </div>
        
        <div className="footer-section">
          <div className="footer-for-doctors">
            <h4>For Doctors</h4>
            <ul>
              <li><i className="bx bx-chevron-right"></i> <a href="/doctorregister">For Registration</a></li>
              <li><i className="bx bx-chevron-right"></i> <a href="/doctorsign">For Log in</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div className="container d-md-flex py-4">
    <div className="me-md-auto text-center text-md-start">
      <div className="copyright">
        &copy; Copyright <strong><span>MindSensei</span></strong>. All Rights Reserved
      </div>
    </div>
    <div className="social-links text-center text-md-right pt-3 pt-md-0">
      <a href="#" className="twitter"><i className="bx bxl-twitter"></i></a>
      <a href="#" className="facebook"><i className="bx bxl-facebook"></i></a>
      <a href="#" className="instagram"><i className="bx bxl-instagram"></i></a>
      <a href="#" className="linkedin"><i className="bx bxl-linkedin"></i></a>
    </div>
  </div>
</footer>

  );
};

export default Footer;
