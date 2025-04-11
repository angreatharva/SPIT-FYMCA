import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

function Authenticate() {
  const navigate = useNavigate();
  // Use state to switch between "SignUp" and "SignIn" modes.
  const [formMode, setFormMode] = useState('signup'); // 'signup' or 'signin'

  // Check if a user is already logged in; if yes, redirect to home ("/")
  useEffect(() => {
    const userFromStorage = localStorage.getItem('currentUser');
    if (userFromStorage) {
      navigate('/');
    }
  }, [navigate]);

  // Toggle between SignUp and SignIn forms
  const toggleForm = () => {
    setFormMode((prevMode) => (prevMode === 'signup' ? 'signin' : 'signup'));
  };

  return (
    <div className="auth-wrapper">
      <style>
        {`
          @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap');

          * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
          }
          
          body {
            font-family: 'Montserrat', Helvetica, Arial, sans-serif;
            background-color: #f5f5f5;
            color: #111111;
            line-height: 1.5;
          }
          
          .auth-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            background-color: #f5f5f5;
          }
          
          .auth-container {
            width: 100%;
            max-width: 480px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 24px rgba(0, 0, 0, 0.1);
            overflow: hidden;
          }
          
          .auth-brand {
            background-color: #000;
            color: white;
            padding: 24px;
            text-align: center;
          }
          
          .brand-name {
            font-size: 2rem;
            font-weight: 700;
            letter-spacing: 2px;
            margin: 0;
          }
          
          .brand-tagline {
            font-size: 0.8rem;
            letter-spacing: 1.5px;
            margin-top: 4px;
          }
          
          .form-container {
            padding: 32px 40px;
          }
          
          .form-title {
            font-size: 1.5rem;
            font-weight: 700;
            text-transform: uppercase;
            margin-bottom: 16px;
            letter-spacing: 0.5px;
          }
          
          .form-subtitle {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 28px;
          }
          
          .form-group {
            margin-bottom: 20px;
            position: relative;
          }
          
          .form-input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #e1e1e1;
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.3s, box-shadow 0.3s;
            font-family: inherit;
          }
          
          .form-input:focus {
            outline: none;
            border-color: #000;
            box-shadow: 0 0 0 2px rgba(0, 0, 0, 0.1);
          }
          
          .form-input::placeholder {
            color: #999;
          }
          
          .input-error {
            border-color: #e53e3e;
          }
          
          .error-message {
            color: #e53e3e;
            font-size: 0.8rem;
            margin-top: 6px;
            position: absolute;
          }
          
          .success-message {
            background-color: #48bb78;
            color: white;
            font-size: 0.9rem;
            padding: 12px;
            border-radius: 4px;
            margin-top: 16px;
            text-align: center;
          }
          
          .checkbox-group {
            display: flex;
            align-items: flex-start;
            gap: 10px;
          }
          
          .checkbox-group input[type="checkbox"] {
            margin-top: 5px;
          }
          
          .checkbox-group label {
            font-size: 0.85rem;
            color: #444;
            flex: 1;
          }
          
          .form-terms {
            font-size: 0.75rem;
            color: #666;
            margin-bottom: 20px;
          }
          
          .form-terms a, .toggle-form a, .forgot-password {
            color: #000;
            text-decoration: none;
            font-weight: 600;
          }
          
          .form-terms a:hover, .toggle-form a:hover, .forgot-password:hover {
            text-decoration: underline;
          }
          
          .submit-btn {
            width: 100%;
            background-color: #000;
            color: white;
            border: none;
            padding: 16px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 16px;
            transition: background-color 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
          }
          
          .submit-btn:hover {
            background-color: #333;
          }
          
          .toggle-form {
            margin-top: 24px;
            text-align: center;
            font-size: 0.9rem;
          }
          
          .forgot-password {
            margin-left: auto;
            font-size: 0.85rem;
          }
          
          @media (max-width: 480px) {
            .form-container {
              padding: 24px;
            }
            
            .form-title {
              font-size: 1.2rem;
            }
          }
        `}
      </style>
      <div className="auth-container">
        <div className="auth-brand">
          <h2 className="brand-name">NIKE</h2>
          <p className="brand-tagline">BECOME LEGENDARY</p>
        </div>
        {formMode === 'signup' ? (
          <SignUp toggleForm={toggleForm} />
        ) : (
          <SignIn toggleForm={toggleForm} />
        )}
      </div>
    </div>
  );
}

function SignUp({ toggleForm }) {
  const [formData, setFormData] = useState({
    fullname: '',
    email: '',
    password: '',
    confirmPassword: '',
  });
  const [errors, setErrors] = useState({});
  const [success, setSuccess] = useState('');

  const handleChange = (e) => {
    const { id, value } = e.target;
    setFormData({ ...formData, [id]: value });
    if (errors[id]) {
      setErrors({ ...errors, [id]: '' });
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setErrors({});
    setSuccess('');

    const newErrors = {};
    let isValid = true;

    // Validate fullname
    if (formData.fullname.trim().length < 3) {
      newErrors.fullname = 'Name must be at least 3 characters';
      isValid = false;
    }

    // Validate email format
    if (!validateEmail(formData.email)) {
      newErrors.email = 'Please enter a valid email address';
      isValid = false;
    }

    // Validate password length
    // if (formData.password.length < 6) {
    //   newErrors.password = 'Password must be at least 6 characters';
    //   isValid = false;
    // }

    // Validate confirm password
    if (formData.password !== formData.confirmPassword) {
      newErrors.confirmPassword = 'Passwords do not match';
      isValid = false;
    }

    // Check if email already exists in the stored users
    const users = JSON.parse(localStorage.getItem('users') || '[]');
    if (users.some((user) => user.email === formData.email)) {
      newErrors.email = 'This email is already registered';
      isValid = false;
    }

    if (!isValid) {
      setErrors(newErrors);
      return;
    }

    // Save new user data to localStorage (never use plain text in real apps)
    users.push({
      fullname: formData.fullname,
      email: formData.email,
      password: formData.password,
    });
    localStorage.setItem('users', JSON.stringify(users));

    // Show success message and reset form
    setSuccess('Registration successful! You can now sign in.');
    setFormData({
      fullname: '',
      email: '',
      password: '',
      confirmPassword: '',
    });

    // After a short delay, toggle the form mode to sign in
    setTimeout(() => {
      toggleForm();
    }, 2000);
  };

  return (
    <div className="form-container">
      <h1 className="form-title">JOIN US</h1>
      
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <input
            type="text"
            id="fullname"
            className={`form-input ${errors.fullname ? 'input-error' : ''}`}
            value={formData.fullname}
            onChange={handleChange}
            placeholder="Full Name"
            required
          />
          {errors.fullname && <div className="error-message">{errors.fullname}</div>}
        </div>

        <div className="form-group">
          <input
            type="email"
            id="email"
            className={`form-input ${errors.email ? 'input-error' : ''}`}
            value={formData.email}
            onChange={handleChange}
            placeholder="Email"
            required
          />
          {errors.email && <div className="error-message">{errors.email}</div>}
        </div>

        <div className="form-group">
          <input
             type="text"
            id="password"
            className={`form-input ${errors.password ? 'input-error' : ''}`}
            value={formData.password}
            onChange={handleChange}
            placeholder="Password"
            required
          />
          {errors.password && <div className="error-message">{errors.password}</div>}
        </div>

        <div className="form-group">
          <input
            type="text"
            id="confirmPassword"
            className={`form-input ${errors.confirmPassword ? 'input-error' : ''}`}
            value={formData.confirmPassword}
            onChange={handleChange}
            placeholder="Confirm Password"
            required
          />
          {errors.confirmPassword && (
            <div className="error-message">{errors.confirmPassword}</div>
          )}
        </div>

        <div className="form-group checkbox-group">
          <input type="checkbox" id="marketing" />
          <label htmlFor="marketing">Sign up for emails to get updates from NIKE on products, offers, and your Member benefits</label>
        </div>

        

        <button type="submit" className="submit-btn">
          JOIN
        </button>
        {success && <div className="success-message">{success}</div>}
      </form>
      
      <div className="toggle-form">
        Already a member? {' '}
        <a href="#" onClick={(e) => {
          e.preventDefault();
          toggleForm();
        }}>
          Sign In
        </a>
      </div>
    </div>
  );
}

function SignIn({ toggleForm }) {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    email: '',
    password: '',
  });
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  const handleChange = (e) => {
    const { id, value } = e.target;
    setFormData({ ...formData, [id]: value });
    setError('');
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setError('');
    setSuccess('');

    // Retrieve stored users and attempt to find matching credentials
    const users = JSON.parse(localStorage.getItem('users') || '[]');
    const user = users.find(
      (u) => u.email === formData.email && u.password === formData.password
    );

    if (user) {
      // Successful sign in: store user and redirect to home ("/")
      const userData = {
        fullname: user.fullname,
        email: user.email,
      };
      localStorage.setItem('currentUser', JSON.stringify(userData));
      setSuccess('Sign in successful! Redirecting...');
      setTimeout(() => {
        navigate('/homePage');
      }, 1000);
    } else {
      setError('Invalid email or password');
    }
  };

  return (
    <div className="form-container">
      <h1 className="form-title">YOUR ACCOUNT FOR EVERYTHING NIKE</h1>
      
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <input
            type="email"
            id="email"
            className="form-input"
            value={formData.email}
            onChange={handleChange}
            placeholder="Email"
            required
          />
        </div>

        <div className="form-group">
          <input
            type="text"
            id="password"
            className="form-input"
            value={formData.password}
            onChange={handleChange}
            placeholder="Password"
            required
          />
        </div>

        <div className="form-group checkbox-group">
          <input type="checkbox" id="remember" />
          <label htmlFor="remember">Keep me signed in</label>
          <a href="#" className="forgot-password">Forgot Password?</a>
        </div>

        {error && <div className="error-message">{error}</div>}
        {success && <div className="success-message">{success}</div>}

        <button type="submit" className="submit-btn">
          SIGN IN
        </button>
      </form>
      
      <div className="toggle-form">
        Not a member? {' '}
        <a href="#" onClick={(e) => {
          e.preventDefault();
          toggleForm();
        }}>
          Join Us
        </a>
      </div>
    </div>
  );
}

function validateEmail(email) {
  const re =
    /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(String(email).toLowerCase());
}

export default Authenticate;