<%@ page import="java.util.List,java.util.ArrayList,com.example.model.Job" %>
<%
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String location = request.getParameter("location");

    List<Job> jobs = (List<Job>) application.getAttribute("jobs");
    if (jobs == null) {
        jobs = new ArrayList<Job>();
    }
    Job job = new Job(title, description, location);
    jobs.add(job);
    application.setAttribute("jobs", jobs);

    response.sendRedirect("index.jsp");
%> 