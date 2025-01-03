import React from 'react';
import './HeroSection.css';  // Import the combined CSS file

const HeroSection = () => {
  return (
    <div>
      {/* ======= Hero Section ======= */}
      <section id="hero" className="d-flex align-items-center">
        <div className="container text-center">
          <h1>Welcome to MindSensei</h1>
          <h2>Healing Starts Here: Expert Therapy for Mind, Body, and Soul</h2>
          <a href="#appointment" className="btn-get-started scrollto">Book Now</a>
        </div>
      </section>

      {/* ======= Why Us Section ======= */}
      <section id="why-us" className="why-us">
        <div className="container">
          <div className="row">
            <div className="col-lg-4 d-flex align-items-stretch">
              <div className="content">
                <h3>Why Choose MindSensei?</h3>
                <p>
                  At MindSensei, we bring years of experience and expertise to the table. Our team comprises seasoned
                  professionals who have successfully tackled a wide range of challenges in Mental Health Issues. With our
                  deep understanding of psychology, we deliver tailored solutions that drive results.
                </p>
              </div>
            </div>
            <div className="col-lg-8 d-flex align-items-stretch">
              <div className="icon-boxes d-flex flex-column justify-content-center">
                <div className="row">
                  <div className="col-xl-4 d-flex align-items-stretch">
                    <div className="icon-box mt-4 mt-xl-0">
                      <i className='bx bxs-brain'></i>
                      <h4>Services</h4>
                      <p>"Are you a service? Because you've got all the features I've been looking for."</p>
                    </div>
                  </div>
                  <div className="col-xl-4 d-flex align-items-stretch">
                    <div className="icon-box mt-4 mt-xl-0">
                      <i className='bx bx-plus-medical'></i>
                      <h4>Best Expertise</h4>
                      <p>"Are you the best expertise? Because you've got all the answers I need."</p>
                    </div>
                  </div>
                  <div className="col-xl-4 d-flex align-items-stretch">
                    <div className="icon-box mt-4 mt-xl-0">
                      <i className='bx bx-health'></i>
                      <h4>Make Appointment</h4>
                      <p>"Are you free for an appointment? Because I'd love to schedule some time with you."</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default HeroSection;
