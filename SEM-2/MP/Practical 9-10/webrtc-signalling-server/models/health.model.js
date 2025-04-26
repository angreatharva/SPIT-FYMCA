const mongoose = require("../config/db");
const { Schema } = mongoose;

// Define the health question schema
const healthQuestionSchema = new Schema({
  question: {
    type: String,
    required: true,
  },
  isDefault: {
    type: Boolean,
    default: false,
  },
  order: {
    type: Number,
    default: 0,
  }
}, { timestamps: true });

// Define the user health tracking schema
const healthTrackingSchema = new Schema({
  userId: {
    type: String,
    required: true,
    index: true
  },
  date: {
    type: Date,
    default: Date.now,
    required: true
  },
  questions: [{
    questionId: {
      type: Schema.Types.ObjectId,
      ref: 'HealthQuestion'
    },
    question: {
      type: String,
      required: true
    },
    completed: {
      type: Boolean,
      default: false
    },
    completedAt: {
      type: Date,
      default: null
    }
  }]
}, { timestamps: true });

// Create compound index on userId and date to ensure one record per user per day
healthTrackingSchema.index({ userId: 1, date: 1 }, { unique: true });

// Create models
const HealthQuestion = mongoose.model("HealthQuestion", healthQuestionSchema);
const HealthTracking = mongoose.model("HealthTracking", healthTrackingSchema);

// Default questions to be created on system initialization
const defaultQuestions = [
  {
    question: "Did you drink 3 liters of water today?",
    isDefault: true,
    order: 1
  },
  {
    question: "Did you work out today?",
    isDefault: true,
    order: 2
  },
  {
    question: "Did you take your medications?",
    isDefault: true,
    order: 3
  },
  {
    question: "Did you eat healthy today?",
    isDefault: true,
    order: 4
  }
];

// Initialize default questions
const initializeDefaultQuestions = async () => {
  try {
    // Check if default questions already exist
    const count = await HealthQuestion.countDocuments({ isDefault: true });
    
    if (count === 0) {
      // Create default questions
      await HealthQuestion.insertMany(defaultQuestions);
      console.log('Default health questions initialized');
    } else {
      console.log(`${count} default health questions already exist`);
    }
  } catch (error) {
    console.error('Error initializing default health questions:', error);
  }
};

// Call initialization function
initializeDefaultQuestions();

module.exports = {
  HealthQuestion,
  HealthTracking
}; 