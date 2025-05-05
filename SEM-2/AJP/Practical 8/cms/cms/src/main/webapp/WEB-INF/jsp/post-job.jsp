<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            width: 100%;
            max-width: 800px;
            padding: 20px;
        }
        .dashboard {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            margin: 0 auto;
        }
        .welcome-header {
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #667eea;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 15px;
        }
        textarea {
            min-height: 120px;
            resize: vertical;
        }
        .btn {
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        .btn:hover {
            background: #764ba2;
        }
        .form-row {
            display: flex;
            gap: 15px;
        }
        .form-row .form-group {
            flex: 1;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="dashboard">
            <a href="<c:url value='/home'/>" class="back-link">← Back to Dashboard</a>
            <h1 class="welcome-header">Post a New Job</h1>
            
            <form id="postJobForm">
                <div class="form-group">
                    <label for="job-title">Job Title</label>
                    <input type="text" id="job-title" name="title" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="company-name">Company Name</label>
                        <input type="text" id="company-name" name="companyName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="employment-type">Employment Type</label>
                        <select id="employment-type" name="employmentType" required>
                            <option value="">Select Type</option>
                            <option value="Full-time">Full-time</option>
                            <option value="Part-time">Part-time</option>
                            <option value="Contract">Contract</option>
                            <option value="Internship">Internship</option>
                            <option value="Freelance">Freelance</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="location">Location</label>
                        <input type="text" id="location" name="location" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="salary">Salary/Compensation</label>
                        <input type="text" id="salary" name="salary" placeholder="e.g. $50,000 - $70,000 per year">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="description">Job Description</label>
                    <textarea id="description" name="description" required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="requirements">Job Requirements</label>
                    <textarea id="requirements" name="requirements" required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="expiry-date">Application Deadline</label>
                    <input type="date" id="expiry-date" name="expiryDate">
                </div>
                
                <button type="submit" class="btn">Post Job</button>
            </form>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const postJobForm = document.getElementById('postJobForm');
            
            postJobForm.addEventListener('submit', async (e) => {
                e.preventDefault();
                
                const formData = {
                    title: document.getElementById('job-title').value,
                    companyName: document.getElementById('company-name').value,
                    employmentType: document.getElementById('employment-type').value,
                    location: document.getElementById('location').value,
                    salary: document.getElementById('salary').value,
                    description: document.getElementById('description').value,
                    requirements: document.getElementById('requirements').value,
                    expiryDate: document.getElementById('expiry-date').value
                };
                
                try {
                    const response = await fetch('/api/jobs', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(formData)
                    });
                    
                    if (response.ok) {
                        alert('Job posted successfully!');
                        window.location.href = '/home';
                    } else {
                        const errorData = await response.json();
                        alert(`Error: ${errorData}`);
                    }
                } catch (error) {
                    alert('An error occurred while posting the job.');
                    console.error(error);
                }
            });
        });
    </script>
</body>
</html> 