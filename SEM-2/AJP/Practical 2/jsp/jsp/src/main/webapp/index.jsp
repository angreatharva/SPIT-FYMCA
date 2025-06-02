<%@ page contentType="text/html;charset=UTF-8" import="java.util.List,com.example.model.Job" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Job Postings</title>
</head>
<body>
    <h1>Job Postings</h1>
    <%
        List<Job> jobs = (List<Job>) application.getAttribute("jobs");
        if (jobs == null || jobs.isEmpty()) {
    %>
        <p>No jobs posted yet.</p>
    <%
        } else {
            for (Job job : jobs) {
    %>
        <div>
            <h2><%= job.getTitle() %></h2>
            <p><%= job.getDescription() %></p>
            <p><strong>Location:</strong> <%= job.getLocation() %></p>
        </div>
    <%
            }
        }
    %>
    <h2>Post a New Job</h2>
    <form action="postJob.jsp" method="post">
        <label>Title: <input type="text" name="title" required /></label><br />
        <label>Description: <textarea name="description" required></textarea></label><br />
        <label>Location: <input type="text" name="location" required /></label><br />
        <input type="submit" value="Submit" />
    </form>
</body>
</html>
