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
  },
  role: {
    type: String,
    enum: ['patient', 'doctor', 'both'],
    default: 'patient'
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

// Define health activity stats schema for heatmap
const healthActivitySchema = new Schema({
  userId: {
    type: String,
    required: true,
    index: true
  },
  date: {
    type: Date,
    required: true
  },
  completedTasks: {
    type: Number,
    default: 0,
    min: 0
  },
  totalTasks: {
    type: Number,
    default: 0,
    min: 0
  },
  score: {
    type: Number,
    default: 0,
    min: 0,
    max: 100
  }
}, { timestamps: true });

// Create compound index on userId and date to ensure one record per user per day
healthActivitySchema.index({ userId: 1, date: 1 }, { unique: true });

// Create models
const HealthQuestion = mongoose.model("HealthQuestion", healthQuestionSchema);
const HealthTracking = mongoose.model("HealthTracking", healthTrackingSchema);
const HealthActivity = mongoose.model("HealthActivity", healthActivitySchema);

// Default questions to be created on system initialization
const defaultQuestions = [
  {
    question: "Did you drink 3 liters of water today?",
    isDefault: true,
    order: 1,
    role: 'patient'
  },
  {
    question: "Did you work out today?",
    isDefault: true,
    order: 2,
    role: 'patient'
  },
  {
    question: "Did you take your medications?",
    isDefault: true,
    order: 3,
    role: 'patient'
  },
  {
    question: "Did you eat healthy today?",
    isDefault: true,
    order: 4,
    role: 'patient'
  }
];

// Doctor-specific default questions
const doctorDefaultQuestions = [
  {
    question: "Did you stay hydrated and drink enough water today?",
    isDefault: true,
    order: 1,
    role: 'doctor'
  },
  {
    question: "Did you take a break or rest during your shift today?",
    isDefault: true,
    order: 2,
    role: 'doctor'
  },
  {
    question: "Did you eat a balanced meal today?",
    isDefault: true,
    order: 3,
    role: 'doctor'
  },
  {
    question: "Did you do any physical activity or movement today?",
    isDefault: true,
    order: 4,
    role: 'doctor'
  },
  {
    question: "Did you get at least 7 hours of sleep last night?",
    isDefault: true,
    order: 5,
    role: 'doctor'
  }
];

// Initialize default questions
const initializeDefaultQuestions = async () => {
  try {
    // Check if default patient questions already exist
    const patientCount = await HealthQuestion.countDocuments({ isDefault: true, role: 'patient' });
    
    if (patientCount === 0) {
      // Create default patient questions
      await HealthQuestion.insertMany(defaultQuestions);
      console.log('Default patient health questions initialized');
    } else {
      console.log(`${patientCount} default patient health questions already exist`);
    }
    
    // Check if default doctor questions already exist
    const doctorCount = await HealthQuestion.countDocuments({ isDefault: true, role: 'doctor' });
    
    if (doctorCount === 0) {
      // Create default doctor questions
      await HealthQuestion.insertMany(doctorDefaultQuestions);
      console.log('Default doctor health questions initialized');
    } else {
      console.log(`${doctorCount} default doctor health questions already exist`);
    }
  } catch (error) {
    console.error('Error initializing default health questions:', error);
  }
};

// Call initialization function
initializeDefaultQuestions();

module.exports = {
  HealthQuestion,
  HealthTracking,
  HealthActivity
}; 