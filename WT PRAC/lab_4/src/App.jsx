// src/App.jsx
import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Navigation from "./components/Navigation";
import Content from "./components/Content";

const App = () => {
  return (
    <BrowserRouter>
      <Navigation />
      <Routes>
        <Route path="/" element={<Content />} />
        <Route path="/About" element={<Content />} />
        <Route path="/Contact" element={<Content />} />
      </Routes>
    </BrowserRouter>
  );
};

export default App;
