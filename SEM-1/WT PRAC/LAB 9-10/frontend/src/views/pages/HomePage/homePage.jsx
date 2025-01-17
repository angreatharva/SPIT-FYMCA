import React from "react";
import Header from "../../components/Header";
import About from "../../components/About";
import Footer from "../../components/Footer";
import HeroSection from "../../components/HeroSection";
import ServiceCard from "../../components/ServiceCard";

function HomePage() {
  return (
    <div>
      <Header />
      <HeroSection />
      <About />
      <div className="content-box">
        <ServiceCard
          icon="bx bx-child bx-lg"
          title="Child Therapy"
          description="Our child therapy services provide a safe and supportive environment for children."
        />
        <ServiceCard
          icon="bx bx-heart bx-lg"
          title="Couple Therapy"
          description="We provide couple therapy to help partners improve communication and resolve conflicts."
        />
        <ServiceCard
          icon="bx bx-brain bx-lg"
          title="Stress Management"
          description="Our stress management services help you manage anxiety and stress."
        />
        <ServiceCard
          icon="bx bx-face bx-lg"
          title="Depression Counseling"
          description="Expert counseling for those dealing with depression, offering personalized solutions."
        />
        <ServiceCard
          icon="bx bx-fear bx-lg"
          title="Phobia Therapy"
          description="Overcome your fears with our specialized phobia therapy services."
        />
        <ServiceCard
          icon="bx bx-user-circle bx-lg"
          title="Personal Development"
          description="Our personal development programs help you achieve your personal and professional goals."
        />
      </div>
      <Footer />
    </div>
  );
}

export default HomePage;
