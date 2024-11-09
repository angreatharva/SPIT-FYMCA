import React, { useState } from "react";
import "./ToDoApp.css";

function ToDoApp() {
  const [task, setTask] = useState("");
  const [tasks, setTasks] = useState([]);
  const [editIndex, setEditIndex] = useState(null);
  const [editTaskValue, setEditTaskValue] = useState("");
  const [activeTab, setActiveTab] = useState("Pending");

  const addTask = () => {
    if (task.trim() !== "") {
      setTasks([...tasks, { text: task, status: "Pending" }]);
      setTask("");
    }
  };

  const startEditTask = (index) => {
    setEditIndex(index);
    setEditTaskValue(tasks[index].text);
  };

  const saveEditTask = () => {
    const updatedTasks = [...tasks];
    updatedTasks[editIndex].text = editTaskValue;
    setTasks(updatedTasks);
    setEditIndex(null);
    setEditTaskValue("");
  };

  const removeTask = (indexToRemove) => {
    setTasks(tasks.filter((_, index) => index !== indexToRemove));
  };

  const toggleTaskStatus = (index) => {
    const updatedTasks = [...tasks];
    updatedTasks[index].status =
      updatedTasks[index].status === "Pending" ? "Completed" : "Pending";
    setTasks(updatedTasks);
  };

  const filteredTasks = tasks.filter((task) => task.status === activeTab);

  return (
    <div className="mainContent">
      <h1>ToDo App</h1>

      {/* Task Input */}
      <div
        style={{
          margin: "20px",
          display: "flex",
          width: "580px",
          justifyContent: "space-between",
        }}
      >
        <input
          type="text"
          value={task}
          onChange={(e) => setTask(e.target.value)}
          placeholder="Enter a task"
        />
        <button onClick={addTask}>Add Task</button>
      </div>

      {/* Tabs for Pending and Completed */}
      <div
        style={{
          display: "flex",
          marginBottom: "20px",
          justifyContent: "space-around",
        }}
      >
        <button
          onClick={() => setActiveTab("Pending")}
          style={{
            backgroundColor: activeTab === "Pending" ? "#007bff" : "#ccc",
            color: activeTab === "Pending" ? "#fff" : "#000",
            marginRight: "10px",
            padding: "10px 20px",
          }}
        >
          Pending
        </button>
        <button
          onClick={() => setActiveTab("Completed")}
          style={{
            backgroundColor: activeTab === "Completed" ? "#007bff" : "#ccc",
            color: activeTab === "Completed" ? "#fff" : "#000",
            padding: "10px 20px",
          }}
        >
          Completed
        </button>
      </div>

      {/* Task List */}
      <ul>
        {filteredTasks.map((task, index) => (
          <li key={index} style={{ display: "flex", alignItems: "center" }}>
            {editIndex === index ? (
              <input
                type="text"
                value={editTaskValue}
                onChange={(e) => setEditTaskValue(e.target.value)}
                style={{ marginRight: "10px" }}
              />
            ) : (
              <span
                style={{
                  textDecoration:
                    task.status === "Completed" ? "line-through" : "none",
                }}
              >
                {task.text}
              </span>
            )}
            <div style={{ display: "flex" }}>
              {editIndex === index ? (
                <button onClick={saveEditTask} style={{ marginLeft: "10px" }}>
                  Save
                </button>
              ) : (
                <button
                  onClick={() => startEditTask(index)}
                  style={{ marginLeft: "10px" }}
                >
                  Edit
                </button>
              )}
              <button
                onClick={() => removeTask(index)}
                style={{ marginLeft: "10px" }}
              >
                Remove
              </button>
              <button
                onClick={() => toggleTaskStatus(index)}
                style={{ marginLeft: "10px" }}
              >
                {task.status === "Pending"
                  ? "Mark as Completed"
                  : "Mark as Pending"}
              </button>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default ToDoApp;
