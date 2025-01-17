import React, { useState } from "react";
import { useNavigate } from "react-router-dom"; // Ensure you have react-router-dom installed
import axios from "axios";
import "./registration.css";

const RegistrationLogin = () => {
  const [mode, setMode] = useState("register");
  const [formType, setFormType] = useState("user");
  const [formData, setFormData] = useState({
    userName: "",
    phone: "",
    age: "",
    gender: "",
    email: "",
    password: "",
    confirm_password: "",
    specialization: "",
    qualification: "",
    licenseNumber: "",
  });
  const [errors, setErrors] = useState({});
  const navigate = useNavigate();

  const validate = () => {
    const newErrors = {};

    if (mode === "register") {
      if (!formData.userName.trim()) newErrors.userName = "Name is required";
      if (!formData.phone.trim()) {
        newErrors.phone = "Phone number is required";
      } else if (!/^\d{10}$/.test(formData.phone)) {
        newErrors.phone = "Phone number must be 10 digits";
      }
      if (!formData.age.trim()) {
        newErrors.age = "Age is required";
      } else if (isNaN(formData.age) || formData.age <= 0) {
        newErrors.age = "Age must be a positive number";
      }
      if (!formData.gender.trim()) newErrors.gender = "Gender is required";
      if (!formData.email.trim()) {
        newErrors.email = "Email is required";
      } else if (
        !/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(formData.email)
      ) {
        newErrors.email = "Invalid email format";
      }
      if (!formData.password.trim()) {
        newErrors.password = "Password is required";
      } else if (formData.password.length < 6) {
        newErrors.password = "Password must be at least 6 characters";
      }
      if (formData.password !== formData.confirm_password) {
        newErrors.confirm_password = "Passwords do not match";
      }
      if (formType === "doctor") {
        if (!formData.specialization.trim())
          newErrors.specialization = "Specialization is required";
        if (!formData.qualification.trim())
          newErrors.qualification = "Qualification is required";
        if (!formData.licenseNumber.trim())
          newErrors.licenseNumber = "License Number is required";
      }
    }

    if (mode === "login") {
      if (!formData.email.trim()) {
        newErrors.email = "Email is required";
      } else if (
        !/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(formData.email)
      ) {
        newErrors.email = "Invalid email format";
      }
      if (!formData.password.trim()) {
        newErrors.password = "Password is required";
      }
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!validate()) return;

    const apiUrl =
      mode === "register"
        ? formType === "user"
          ? "http://localhost:3001/registerUser"
          : "http://localhost:3001/registerDr"
        : "http://localhost:3001/login";

    try {
      const payload =
        mode === "register"
          ? { ...formData, confirm_password: undefined }
          : { email: formData.email, password: formData.password };

      const response = await axios.post(apiUrl, payload);
      const data = response.data;

      if (mode === "login" && data.success) {
        localStorage.setItem("role", data.role);
        localStorage.setItem("userId", data.userId);
        localStorage.setItem("name", data.name);
        alert(data.message);
        navigate("/");
      } else if (mode === "register" && data.registered) {
        localStorage.setItem("role", formType === "user" ? "user" : "doctor");
        localStorage.setItem("userId", data.data._id);
        localStorage.setItem("name", data.data.userName);
        alert("Registration successful");
        navigate("/");
      }
    } catch (error) {
      console.error("Error:", error);
      alert(`An error occurred during ${mode}. Please try again.`);
    }
  };

  return (
    <div className="container">
      <div className="main">
        <h2 className="header">
          {mode === "register"
            ? formType === "user"
              ? "User Registration"
              : "Doctor Registration"
            : "Login"}
        </h2>
        <form onSubmit={handleSubmit} className="form">
          {mode === "register" && (
            <>
              <div className="input-group">
                <input
                  type="text"
                  name="userName"
                  placeholder="Name"
                  value={formData.userName}
                  onChange={handleChange}
                  className="input"
                />
                {errors.userName && (
                  <span className="error">{errors.userName}</span>
                )}
              </div>
              <div className="input-group">
                <input
                  type="text"
                  name="phone"
                  placeholder="Phone"
                  value={formData.phone}
                  onChange={handleChange}
                  className="input"
                />
                {errors.phone && <span className="error">{errors.phone}</span>}
                <input
                  type="number"
                  name="age"
                  placeholder="Age"
                  value={formData.age}
                  onChange={handleChange}
                  className="input"
                />
                {errors.age && <span className="error">{errors.age}</span>}
              </div>
              <div className="input-group">
                <select
                  name="gender"
                  value={formData.gender}
                  onChange={handleChange}
                  className="select"
                >
                  <option value="">Select Gender</option>
                  <option value="male">Male</option>
                  <option value="female">Female</option>
                  <option value="other">Other</option>
                </select>
                {errors.gender && (
                  <span className="error">{errors.gender}</span>
                )}
              </div>
              {formType === "doctor" && (
                <>
                  <div className="input-group">
                    <input
                      type="text"
                      name="specialization"
                      placeholder="Specialization"
                      value={formData.specialization}
                      onChange={handleChange}
                      className="input"
                    />
                    {errors.specialization && (
                      <span className="error">{errors.specialization}</span>
                    )}
                  </div>
                  <div className="input-group">
                    <input
                      type="text"
                      name="qualification"
                      placeholder="Qualification"
                      value={formData.qualification}
                      onChange={handleChange}
                      className="input"
                    />
                    {errors.qualification && (
                      <span className="error">{errors.qualification}</span>
                    )}
                  </div>
                  <div className="input-group">
                    <input
                      type="text"
                      name="licenseNumber"
                      placeholder="License Number"
                      value={formData.licenseNumber}
                      onChange={handleChange}
                      className="input"
                    />
                    {errors.licenseNumber && (
                      <span className="error">{errors.licenseNumber}</span>
                    )}
                  </div>
                </>
              )}
            </>
          )}
          <div className="input-group">
            <input
              type="email"
              name="email"
              placeholder="Email"
              value={formData.email}
              onChange={handleChange}
              className="input"
            />
            {errors.email && <span className="error">{errors.email}</span>}
          </div>
          <div className="input-group">
            <input
              type="password"
              name="password"
              placeholder="Password"
              value={formData.password}
              onChange={handleChange}
              className="input"
            />
            {errors.password && (
              <span className="error">{errors.password}</span>
            )}
          </div>
          {mode === "register" && (
            <div className="input-group">
              <input
                type="password"
                name="confirm_password"
                placeholder="Confirm Password"
                value={formData.confirm_password}
                onChange={handleChange}
                className="input"
              />
              {errors.confirm_password && (
                <span className="error">{errors.confirm_password}</span>
              )}
            </div>
          )}
          <button id="btn" type="submit" className="button">
            {mode === "register" ? "Register" : "Login"}
          </button>
        </form>
        <p id="toggle_mode">
          {mode === "register" ? (
            <span onClick={() => setMode("login")} className="toggle-link">
              Already registered? Login
            </span>
          ) : (
            <span onClick={() => setMode("register")} className="toggle-link">
              New user? Register
            </span>
          )}
        </p>
        {mode === "register" && (
          <p id="toggle_form">
            {formType === "user" ? (
              <span
                onClick={() => setFormType("doctor")}
                className="toggle-link"
              >
                Are you a doctor? Click here
              </span>
            ) : (
              <span onClick={() => setFormType("user")} className="toggle-link">
                Not a doctor? Click here
              </span>
            )}
          </p>
        )}
      </div>
    </div>
  );
};

export default RegistrationLogin;
