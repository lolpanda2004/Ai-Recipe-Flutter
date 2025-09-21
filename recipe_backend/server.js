const express = require("express");
const cors = require("cors");

// Import routes
const recipeRoutes = require("./routes/recipeRoutes");

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use("/recipes", recipeRoutes); 
// now all recipe routes will be prefixed with /recipes

// Start server
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
