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
        .btn:hover {
            background: #764ba2;
        }
        .empty-state {
            text-align: center;
            padding: 40px 0;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="dashboard">
            <a href="<c:url value='/home'/>" class="back-link">← Back to Dashboard</a>
            <h1 class="welcome-header">Select Job to Update</h1>
            
            <div class="job-list">
                <c:choose>
                    <c:when test="${empty jobs}">
                        <div class="empty-state">
                            <h3>No jobs found</h3>
                            <p>There are no job listings available to update.</p>
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
                                </div>
                                <a href="<c:url value='/jobs/update/${job.id}'/>" class="btn">Select for Update</a>
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
    </script>
</body>
</html> 