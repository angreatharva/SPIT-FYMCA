import React from 'react';
import './ServiceCard.css'; // Assuming you have the CSS in a separate file

const ServiceCard = ({ iconClass, title, description, hoverImage }) => {
  return (
    <div className="card" style={{ backgroundImage: `url(${hoverImage})` }}>
   
      <h2>{title}</h2>
      <p>{description}</p>
    </div>
  );
};

export default ServiceCard;
