const { HealthQuestion, HealthTracking, HealthActivity } = require('../models/health.model');
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

// Helper function to calculate and update health activity for a given tracking record
const updateHealthActivity = async (tracking) => {
  if (!tracking) return;
  
  const totalTasks = tracking.questions.length;
  const completedTasks = tracking.questions.filter(q => q.completed).length;
  const score = totalTasks > 0 ? Math.round((completedTasks / totalTasks) * 100) : 0;
  
  try {
    await HealthActivity.findOneAndUpdate(
      { 
        userId: tracking.userId, 
        date: moment(tracking.date).startOf('day').toDate() 
      },
      {
        completedTasks,
        totalTasks,
        score
      },
      { upsert: true, new: true }
    );
    
    console.log(`Updated health activity for user ${tracking.userId} on ${tracking.date}, score: ${score}`);
  } catch (error) {
    console.error('Error updating health activity:', error);
  }
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
      
      // Initialize health activity for the new tracking
      await updateHealthActivity(healthTracking);
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
    
    // Update health activity stats
    await updateHealthActivity(tracking);

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

// Get health activity heatmap data for a user
exports.getHealthActivityHeatmap = async (req, res) => {
  const { userId } = req.params;
  const { startDate, endDate } = req.query;
  
  try {
    // Verify user exists
    const user = await UserModel.findById(userId);
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }
    
    // Default to last 365 days if no dates provided
    const start = startDate ? moment(startDate).startOf('day').toDate() : moment().subtract(365, 'days').startOf('day').toDate();
    const end = endDate ? moment(endDate).endOf('day').toDate() : moment().endOf('day').toDate();
    
    // Get health activity data for the date range
    const activityData = await HealthActivity.find({
      userId,
      date: { $gte: start, $lte: end }
    }).sort({ date: 1 });
    
    // Transform data for heatmap format
    const heatmapData = activityData.map(activity => ({
      date: moment(activity.date).format('YYYY-MM-DD'),
      completedTasks: activity.completedTasks,
      totalTasks: activity.totalTasks,
      score: activity.score
    }));
    
    return res.status(200).json({
      success: true,
      data: {
        userId,
        startDate: moment(start).format('YYYY-MM-DD'),
        endDate: moment(end).format('YYYY-MM-DD'),
        activities: heatmapData
      }
    });
  } catch (error) {
    console.error('Error getting health activity heatmap:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to get health activity heatmap data'
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
      
      // Initialize health activity for all newly created trackings
      const newTrackings = await HealthTracking.find({
        userId: { $in: users.map(u => u._id.toString()) },
        date: today
      });
      
      for (const tracking of newTrackings) {
        await updateHealthActivity(tracking);
      }
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

// Backfill health activity data from existing health tracking records
exports.backfillHealthActivity = async (req, res) => {
  try {
    // Get the date range to backfill (default to last 365 days)
    const { userId, startDate, endDate } = req.query;
    
    const filter = {};
    
    if (userId) {
      filter.userId = userId;
    }
    
    if (startDate) {
      filter.date = { ...filter.date, $gte: moment(startDate).startOf('day').toDate() };
    } else {
      filter.date = { ...filter.date, $gte: moment().subtract(365, 'days').startOf('day').toDate() };
    }
    
    if (endDate) {
      filter.date = { ...filter.date, $lte: moment(endDate).endOf('day').toDate() };
    } else {
      filter.date = { ...filter.date, $lte: moment().endOf('day').toDate() };
    }
    
    // Find all health tracking records in the date range
    const trackings = await HealthTracking.find(filter);
    console.log(`Found ${trackings.length} health tracking records to backfill`);
    
    // Update health activity for each tracking
    let updatedCount = 0;
    for (const tracking of trackings) {
      await updateHealthActivity(tracking);
      updatedCount++;
    }
    
    return res.status(200).json({
      success: true,
      message: `Backfilled health activity data for ${updatedCount} tracking records`
    });
  } catch (error) {
    console.error('Error backfilling health activity data:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to backfill health activity data'
    });
  }
}; 