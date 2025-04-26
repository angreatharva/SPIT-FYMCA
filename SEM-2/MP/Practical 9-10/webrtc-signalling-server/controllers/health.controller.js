const { HealthQuestion, HealthTracking } = require('../models/health.model');
const UserModel = require('../models/user.model');
const moment = require('moment');

// Helper function to get today's date (start of day in UTC)
const getTodayDate = () => {
  return moment().startOf('day').toDate();
};

// Helper function to check if date is today
const isToday = (date) => {
  return moment(date).isSame(moment(), 'day');
};

// Get all health questions
exports.getAllQuestions = async (req, res) => {
  try {
    const questions = await HealthQuestion.find().sort({ order: 1 });
    return res.status(200).json({
      success: true,
      data: questions
    });
  } catch (error) {
    console.error('Error getting health questions:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to get health questions'
    });
  }
};

// Get today's health tracking for a user
exports.getUserHealthTracking = async (req, res) => {
  const { userId } = req.params;

  try {
    // Verify user exists
    const user = await UserModel.findById(userId);
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    // Get today's date (start of day)
    const today = getTodayDate();

    // Find or create today's health tracking
    let healthTracking = await HealthTracking.findOne({
      userId,
      date: {
        $gte: today,
        $lt: moment(today).add(1, 'days').toDate()
      }
    });

    // If no tracking exists for today, create a new one with default questions
    if (!healthTracking) {
      // Get default questions
      const questions = await HealthQuestion.find().sort({ order: 1 });
      
      // Create tracking with all questions
      healthTracking = await HealthTracking.create({
        userId,
        date: today,
        questions: questions.map(q => ({
          questionId: q._id,
          question: q.question,
          completed: false,
          completedAt: null
        }))
      });

      console.log(`Created new health tracking for user ${userId} with ${questions.length} questions`);
    }

    return res.status(200).json({
      success: true,
      data: healthTracking
    });
  } catch (error) {
    console.error('Error getting user health tracking:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to get health tracking data'
    });
  }
};

// Complete a health question
exports.completeHealthQuestion = async (req, res) => {
  const { userId, trackingId, questionId } = req.params;

  try {
    // Get today's date
    const today = getTodayDate();

    // Find the tracking record
    const tracking = await HealthTracking.findOne({
      _id: trackingId,
      userId,
      date: {
        $gte: today,
        $lt: moment(today).add(1, 'days').toDate()
      }
    });

    if (!tracking) {
      return res.status(404).json({
        success: false,
        message: 'Health tracking not found or not from today'
      });
    }

    // Find the question in the tracking
    const questionIndex = tracking.questions.findIndex(q => 
      q._id.toString() === questionId
    );

    if (questionIndex === -1) {
      return res.status(404).json({
        success: false,
        message: 'Question not found in tracking'
      });
    }

    // Check if question is already completed
    if (tracking.questions[questionIndex].completed) {
      return res.status(400).json({
        success: false,
        message: 'Question already completed and cannot be undone'
      });
    }

    // Update the question to completed
    tracking.questions[questionIndex].completed = true;
    tracking.questions[questionIndex].completedAt = new Date();

    // Save the tracking
    await tracking.save();
    console.log(`User ${userId} completed question ${questionId}`);

    return res.status(200).json({
      success: true,
      data: tracking
    });
  } catch (error) {
    console.error('Error completing health question:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to complete health question'
    });
  }
};

// Manual utility function to refresh all health tracking records
// This will be called by the scheduler at midnight
exports.refreshAllHealthTracking = async () => {
  try {
    // Create today's date
    const today = getTodayDate();
    
    // Get all users
    const users = await UserModel.find({}, { _id: 1 });
    console.log(`Found ${users.length} users to create health tracking for`);
    
    // Get default questions
    const questions = await HealthQuestion.find().sort({ order: 1 });
    
    // Create new health tracking records for all users
    const operations = users.map(user => {
      return {
        updateOne: {
          filter: { userId: user._id.toString(), date: today },
          update: {
            $setOnInsert: {
              userId: user._id.toString(),
              date: today,
              questions: questions.map(q => ({
                questionId: q._id,
                question: q.question,
                completed: false,
                completedAt: null
              }))
            }
          },
          upsert: true
        }
      };
    });
    
    if (operations.length > 0) {
      const result = await HealthTracking.bulkWrite(operations);
      console.log(`Created health tracking records for ${result.upsertedCount} users`);
    }
    
    return {
      success: true,
      message: `Created health tracking records for ${operations.length} users`
    };
  } catch (error) {
    console.error('Error refreshing health tracking records:', error);
    return {
      success: false,
      message: 'Failed to refresh health tracking records'
    };
  }
}; 