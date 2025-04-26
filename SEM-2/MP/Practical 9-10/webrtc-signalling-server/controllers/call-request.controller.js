const CallRequest = require('../models/call-request.model');

// Create a new call request
exports.createCallRequest = async (req, res) => {
  try {
    const {
      patientId,
      patientName,
      patientCallerId,
      doctorId,
      doctorName,
      doctorCallerId,
    } = req.body;

    // Validate required fields
    if (!patientId || !patientName || !patientCallerId || !doctorId || !doctorName || !doctorCallerId) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields',
      });
    }

    // Create new call request
    const callRequest = new CallRequest({
      patientId,
      patientName,
      patientCallerId,
      doctorId,
      doctorName,
      doctorCallerId,
    });

    // Save to database
    await callRequest.save();

    return res.status(201).json({
      success: true,
      message: 'Call request created successfully',
      callRequest,
    });
  } catch (error) {
    console.error('Error creating call request:', error);
    return res.status(500).json({
      success: false,
      message: 'Error creating call request',
      error: error.message,
    });
  }
};

// Get all call requests for a doctor
exports.getDoctorCallRequests = async (req, res) => {
  try {
    const { doctorId } = req.params;

    // Find all call requests for this doctor
    const callRequests = await CallRequest.find({ doctorId })
      .sort({ createdAt: -1 }); // Newest first

    return res.status(200).json({
      success: true,
      callRequests,
    });
  } catch (error) {
    console.error('Error getting doctor call requests:', error);
    return res.status(500).json({
      success: false,
      message: 'Error getting doctor call requests',
      error: error.message,
    });
  }
};

// Get all call requests for a patient
exports.getPatientCallRequests = async (req, res) => {
  try {
    const { patientId } = req.params;

    // Find all call requests for this patient
    const callRequests = await CallRequest.find({ patientId })
      .sort({ createdAt: -1 }); // Newest first

    return res.status(200).json({
      success: true,
      callRequests,
    });
  } catch (error) {
    console.error('Error getting patient call requests:', error);
    return res.status(500).json({
      success: false,
      message: 'Error getting patient call requests',
      error: error.message,
    });
  }
};

// Update call request status
exports.updateCallRequestStatus = async (req, res) => {
  try {
    const { requestId } = req.params;
    const { status } = req.body;

    // Validate status
    const validStatuses = ['pending', 'accepted', 'rejected', 'completed'];
    if (!validStatuses.includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be pending, accepted, rejected, or completed',
      });
    }

    // Find and update the call request
    const callRequest = await CallRequest.findByIdAndUpdate(
      requestId,
      { status, updatedAt: Date.now() },
      { new: true, runValidators: true }
    );

    if (!callRequest) {
      return res.status(404).json({
        success: false,
        message: 'Call request not found',
      });
    }

    return res.status(200).json({
      success: true,
      message: 'Call request status updated successfully',
      callRequest,
    });
  } catch (error) {
    console.error('Error updating call request status:', error);
    return res.status(500).json({
      success: false,
      message: 'Error updating call request status',
      error: error.message,
    });
  }
}; 