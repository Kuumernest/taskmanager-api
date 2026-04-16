const express = require("express");
const app = express();

app.use(express.json());

let tasks = [];

// CREATE
app.post("/tasks", (req, res) => {
    const task = { id: Date.now(), name: req.body.name };
    tasks.push(task);
    res.json(task);
});

// READ ALL
app.get("/tasks", (req, res) => {
    res.json(tasks);
});

// UPDATE
app.put("/tasks/:id", (req, res) => {
    let task = tasks.find(t => t.id == req.params.id);
    if (task) task.name = req.body.name;
    res.json(task || { message: "Task not found" });
});

// DELETE
app.delete("/tasks/:id", (req, res) => {
    tasks = tasks.filter(t => t.id != req.params.id);
    res.json({ message: "Deleted" });
});

app.listen(5500, () => {
    console.log("Server running on http://localhost:5500");
});