const request = require('supertest');
const mongoose = require('mongoose');
const app = require('../index');
const UserModel = require('../models/user.model');
const DrModel = require('../models/doctor.model');
const SessionModel = require('../models/session.model');

// Mock user data
const testUser = {
  userName: 'Test User',
  email: 'testuser@example.com',
  password: 'Password123!'
};

// Mock doctor data
const testDoctor = {
  doctorName: 'Test Doctor',
  email: 'testdoctor@example.com',
  password: 'Password123!',
  specialization: 'General'
};

let userToken;
let userId;

// Connect to a test database before running tests
beforeAll(async () => {
  // Clear existing test data 
  await UserModel.deleteMany({ email: testUser.email });
  await DrModel.deleteMany({ email: testDoctor.email });
  await SessionModel.deleteMany({});
});

// Clean up after tests
afterAll(async () => {
  await UserModel.deleteMany({ email: testUser.email });
  await DrModel.deleteMany({ email: testDoctor.email });
  await SessionModel.deleteMany({});
  await mongoose.connection.close();
});

describe('Authentication API', () => {
  // Test user registration
  describe('User Registration', () => {
    it('should register a new user', async () => {
      const res = await request(app)
        .post('/api/auth/register/user')
        .send(testUser);
      
      expect(res.statusCode).toEqual(201);
      expect(res.body).toHaveProperty('success', true);
      expect(res.body).toHaveProperty('userId');
      userId = res.body.userId;
    });

    it('should not register a user with an existing email', async () => {
      const res = await request(app)
        .post('/api/auth/register/user')
        .send(testUser);
      
      expect(res.statusCode).toEqual(400);
      expect(res.body).toHaveProperty('success', false);
    });
  });

  // Test doctor registration
  describe('Doctor Registration', () => {
    it('should register a new doctor', async () => {
      const res = await request(app)
        .post('/api/auth/register/doctor')
        .send(testDoctor);
      
      expect(res.statusCode).toEqual(201);
      expect(res.body).toHaveProperty('success', true);
    });
  });

  // Test login functionality
  describe('Login', () => {
    it('should login a user with valid credentials', async () => {
      const res = await request(app)
        .post('/api/auth/login')
        .send({
          email: testUser.email,
          password: testUser.password
        });
      
      expect(res.statusCode).toEqual(200);
      expect(res.body).toHaveProperty('success', true);
      expect(res.body).toHaveProperty('token');
      expect(res.body).toHaveProperty('role', 'patient');
      
      // Save token for subsequent tests
      userToken = res.body.token;
    });

    it('should not login with invalid credentials', async () => {
      const res = await request(app)
        .post('/api/auth/login')
        .send({
          email: testUser.email,
          password: 'wrongpassword'
        });
      
      expect(res.statusCode).toEqual(401);
      expect(res.body).toHaveProperty('success', false);
    });
  });

  // Test protected routes
  describe('Protected Routes', () => {
    it('should access protected route with valid token', async () => {
      const res = await request(app)
        .get('/api/auth/users')
        .set('Authorization', `Bearer ${userToken}`);
      
      expect(res.statusCode).toEqual(200);
    });

    it('should not access protected route without token', async () => {
      const res = await request(app)
        .get('/api/auth/users');
      
      expect(res.statusCode).toEqual(401);
    });

    it('should get user by ID', async () => {
      const res = await request(app)
        .get(`/api/auth/user/${userId}`)
        .set('Authorization', `Bearer ${userToken}`);
      
      expect(res.statusCode).toEqual(200);
      expect(res.body).toHaveProperty('userName', testUser.userName);
    });
  });

  // Test logout functionality
  describe('Logout', () => {
    it('should logout successfully', async () => {
      const res = await request(app)
        .post('/api/auth/logout')
        .set('Authorization', `Bearer ${userToken}`);
      
      expect(res.statusCode).toEqual(200);
      expect(res.body).toHaveProperty('success', true);
    });

    it('should not access protected route after logout', async () => {
      const res = await request(app)
        .get('/api/auth/users')
        .set('Authorization', `Bearer ${userToken}`);
      
      expect(res.statusCode).toEqual(401);
    });
  });
}); 