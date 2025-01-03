import React, { useEffect, useState } from "react";
import "./doctorList.css";

const Doctors = () => {
  const [doctors, setDoctors] = useState([]);

  useEffect(() => {
    fetch("http://localhost:3001/doctors")
      .then((response) => response.json())
      .then((data) => {
        if (data.success) {
          setDoctors(data.data);
        } else {
          console.error("Error fetching doctor data.");
        }
      })
      .catch((error) => console.error("Error fetching data: ", error));
  }, []);

  return (
    <div className="doctors-container">
      <h1>Doctors List</h1>
      <div className="doctor-list">
        {doctors.map((doctor) => (
          <div className="doctor-card" key={doctor._id}>
            <div
              className="status-indicator"
              style={{ backgroundColor: doctor.status ? "green" : "red" }}
            ></div>
            <div className="doctor-details">
              <div className="dr-details">
                <p>
                  <strong>Name:</strong> {doctor.userName}
                </p>
                <p>
                  <strong>Email:</strong> {doctor.email}
                </p>
              </div>
              <div className="dr-details">
                <p>
                  <strong>Qualification:</strong> {doctor.qualification}
                </p>
                <p>
                  <strong>Specialization:</strong> {doctor.specialization}
                </p>
              </div>
              <p>
                <strong>Status:</strong> {doctor.status ? "Online" : "Offline"}
              </p>
              <button
                className={`video-call-btn ${
                  doctor.status ? "active" : "disabled"
                }`}
                disabled={!doctor.status}
                onClick={() => {
                  if (doctor.status)
                    alert(`Starting video call with ${doctor.userName}`);
                }}
              >
                {doctor.status ? "Start Video Call" : "Unavailable"}
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Doctors;
