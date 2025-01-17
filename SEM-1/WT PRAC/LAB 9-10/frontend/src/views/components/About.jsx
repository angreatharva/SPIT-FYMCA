import React from "react";
import "./About.css";

const About = () => (
  <div>
    <section id="about" className="about">
      <div className="container-fluid">
        <div className="containers">
          <section className="about">
            <div className="about-image">
              <img src="src\assets\images\about.jpg" alt="About" />
            </div>
            <div className="about-content">
              <h2>Expertise and Experience</h2>
              <p>
                We prioritize our clients above all else. Our client-centric
                approach ensures that we truly understand your unique needs,
                challenges, and goals. We work closely with you to develop
                strategies and solutions that are specifically tailored to
                address your requirements and deliver tangible value. Our track
                record speaks for itself. Over the years, we have helped
                numerous clients achieve their objectives and surpass their
                expectations. our consistent track record of success
                demonstrates our ability to deliver results. We believe in
                building strong, collaborative partnerships with our clients.{" "}
              </p>
              <a href="/about" className="read-more">
                Read More
              </a>
            </div>
          </section>
        </div>
      </div>
    </section>
    <section>
      <section id="services" className="services">
        <div class="container">
          <div className="section-title">
            <h2>Our Services</h2>
            <p>
              Explore new avenues of healing and transformation through our
              innovative psychedelic therapy sessions.
            </p>
          </div>
        </div>
      </section>
    </section>
  </div>
);

export default About;
