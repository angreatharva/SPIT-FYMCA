<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
            max-width: 900px;
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
        .job-list {
            margin-top: 20px;
        }
        .job-card {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .job-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .job-title {
            font-size: 1.2rem;
            color: #333;
            margin-bottom: 5px;
            font-weight: 600;
        }
        .job-company {
            font-weight: 500;
            color: #555;
            margin-bottom: 10px;
        }
        .job-details {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
            color: #666;
            font-size: 0.9rem;
        }
        .btn {
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 16px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
            display: inline-block;
        }
        .btn-danger {
            background: #dc3545;
        }
        .btn:hover {
            background: #764ba2;
        }
        .btn-danger:hover {
            background: #c82333;
        }
        .empty-state {
            text-align: center;
            padding: 40px 0;
            color: #666;
        }
        .search-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .search-bar input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 15px;
        }
        .delete-warning {
            text-align: center;
            padding: 15px;
            background-color: #fff3cd;
            color: #856404;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="dashboard">
            <a href="<c:url value='/home'/>" class="back-link">← Back to Dashboard</a>
            <h1 class="welcome-header">Delete Job</h1>
            
            <div class="delete-warning">
                <p><strong>Warning:</strong> Deleting a job is permanent and cannot be undone.</p>
            </div>
            
            <div class="job-list">
                <c:choose>
                    <c:when test="${empty jobs}">
                        <div class="empty-state">
                            <h3>No jobs found</h3>
                            <p>There are no job listings available to delete.</p>
                            <a href="<c:url value='/jobs/post'/>" class="btn">Post a New Job</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="job" items="${jobs}">
                            <div class="job-card">
                                <div class="job-title">${job.title}</div>
                                <div class="job-company">${job.companyName}</div>
                                <div class="job-details">
                                    <span>📍 ${job.location}</span>
                                    <span>💼 ${job.employmentType}</span>
                                    <c:if test="${not empty job.salary}">
                                        <span>💰 ${job.salary}</span>
                                    </c:if>
                                    <span>📅 Posted: ${job.postedDate}</span>
                                </div>
                                <button class="btn btn-danger" onclick="confirmDelete(${job.id}, '${job.title}')">Delete Job</button>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Empty initialization function
        });
        
        function confirmDelete(jobId, jobTitle) {
            if (confirm("Are you sure you want to delete the job \"" + jobTitle + "\"? This action cannot be undone.")) {
                fetch("/api/jobs/" + jobId, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (response.ok) {
                        alert('Job deleted successfully');
                        location.reload();
                    } else {
                        alert('Error deleting job');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while deleting the job');
                });
            }
        }
    </script>
</body>
</html> 