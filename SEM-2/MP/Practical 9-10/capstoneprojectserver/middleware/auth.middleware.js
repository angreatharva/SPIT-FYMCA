const jwt = require('jsonwebtoken');
const Session = require('../models/session.model');

exports.verifyToken = async (req, res, next) => {
  try {
    // Get token from header
    const token = req.header('Authorization')?.replace('Bearer ', '');
    
    if (!token) {
      return res.status(401).json({ 
        success: false, 
        message: 'No token provided, authorization denied' 
      });
    }

    try {
      // Verify token
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      
      // Check if token exists in active sessions
      const session = await Session.findOne({ token, userId: decoded.userId });
      
      if (!session) {
        return res.status(401).json({ 
          success: false, 
          message: 'Token is not valid or session has expired' 
        });
      }
      
      // Add user info to request
      req.user = {
        userId: decoded.userId,
        role: decoded.role
      };
      
      next();
    } catch (err) {
      res.status(401).json({ 
        success: false, 
        message: 'Token is not valid' 
      });
    }
  } catch (err) {
    console.error('Error in auth middleware:', err);
    res.status(500).json({ 
      success: false, 
      message: 'Server error' 
    });
  }
}; 