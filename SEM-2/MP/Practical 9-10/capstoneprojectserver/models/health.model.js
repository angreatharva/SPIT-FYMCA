const mongoose = require("../config/db");
const { Schema } = mongoose;

/**
 * @swagger
 * components:
 *   schemas:
 *     HealthQuestion:
 *       type: object
 *       required:
 *         - question
 *       properties:
 *         _id:
 *           type: string
 *           description: Auto-generated MongoDB ObjectId
 *         question:
 *           type: string
 *           description: The health question text
 *         isDefault:
 *           type: boolean
 *           description: Indicates if this is a default system question
 *           default: false
 *         order:
 *           type: integer
 *           description: Display order of the question
 *           default: 0
 *         role:
 *           type: string
 *           enum: [patient, doctor, both]
 *           description: The target role for this question
 *           default: patient
 *         createdAt:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the question was created
 *         updatedAt:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the question was last updated
 *       example:
 *         _id: 60d0fe4f5311236168a109d0
 *         question: Did you drink 3 liters of water today?
 *         isDefault: true
 *         order: 1
 *         role: patient
 *         createdAt: 2023-05-01T00:00:00.000Z
 *         updatedAt: 2023-05-01T00:00:00.000Z
 */
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

/**
 * @swagger
 * components:
 *   schemas:
 *     HealthTracking:
 *       type: object
 *       required:
 *         - userId
 *         - date
 *       properties:
 *         _id:
 *           type: string
 *           description: Auto-generated MongoDB ObjectId
 *         userId:
 *           type: string
 *           description: ID of the user (patient or doctor)
 *         date:
 *           type: string
 *           format: date
 *           description: Date of the health tracking record
 *         questions:
 *           type: array
 *           description: List of health questions for tracking
 *           items:
 *             type: object
 *             properties:
 *               questionId:
 *                 type: string
 *                 description: ID of the health question
 *               question:
 *                 type: string
 *                 description: Text of the health question
 *               completed:
 *                 type: boolean
 *                 description: Whether the question has been completed
 *                 default: false
 *               completedAt:
 *                 type: string
 *                 format: date-time
 *                 description: Timestamp when the question was completed
 *         createdAt:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the record was created
 *         updatedAt:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the record was last updated
 *       example:
 *         _id: 60d0fe4f5311236168a109d1
 *         userId: 60d0fe4f5311236168a109ca
 *         date: 2023-05-25
 *         questions:
 *           - questionId: 60d0fe4f5311236168a109d0
 *             question: Did you drink 3 liters of water today?
 *             completed: true
 *             completedAt: 2023-05-25T15:30:00.000Z
 *           - questionId: 60d0fe4f5311236168a109d2
 *             question: Did you work out today?
 *             completed: false
 *             completedAt: null
 *         createdAt: 2023-05-25T00:00:00.000Z
 *         updatedAt: 2023-05-25T15:30:00.000Z
 */
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

/**
 * @swagger
 * components:
 *   schemas:
 *     HealthActivity:
 *       type: object
 *       required:
 *         - userId
 *         - date
 *       properties:
 *         _id:
 *           type: string
 *           description: Auto-generated MongoDB ObjectId
 *         userId:
 *           type: string
 *           description: ID of the user (patient or doctor)
 *         date:
 *           type: string
 *           format: date
 *           description: Date of the health activity
 *         completedTasks:
 *           type: integer
 *           description: Number of health tasks completed on this date
 *           default: 0
 *           minimum: 0
 *         totalTasks:
 *           type: integer
 *           description: Total number of health tasks for this date
 *           default: 0
 *           minimum: 0
 *         score:
 *           type: number
 *           description: Health score for this date (0-100)
 *           default: 0
 *           minimum: 0
 *           maximum: 100
 *         createdAt:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the record was created
 *         updatedAt:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the record was last updated
 *       example:
 *         _id: 60d0fe4f5311236168a109d3
 *         userId: 60d0fe4f5311236168a109ca
 *         date: 2023-05-25
 *         completedTasks: 3
 *         totalTasks: 5
 *         score: 60
 *         createdAt: 2023-05-25T00:00:00.000Z
 *         updatedAt: 2023-05-25T23:59:59.000Z
 */
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