# Domestic Service Robot - Heating Dynamics

## Project Overview
This project models a domestic robot tasked with preparing hot beverages (flavored water, warm tea, hot infusions). The robot interacts with a water dispenser and a heater. Each drink requires a specific temperature range (e.g., $55 < T \le 65^\circ C$ for tea).

## The Domains Explained

### 1. Discrete Model (Standard PDDL)
A foundational numeric model to validate the robot's logic and spatial constraints. 
* **How it works:** Thermodynamics are abstracted into discrete, instantaneous steps. The robot uses a manual `heat-step` action (+10°C per step) to reach the required temperatures. It tests the planner's ability to sequence actions correctly without continuous time limits.

### 2. Continuous Model (PDDL+)
An advanced model that introduces real-world physics, temporal constraints, and environmental autonomy.
* **Continuous Thermodynamics:** Replaces manual steps with time-dependent differential equations. The solver dynamically calculates temperature changes using simultaneous processes (e.g., active heating at +2.5°C/s while passive cooling acts globally at -0.5°C/s).
* **Autonomous Safety Events:** The environment reacts independently. If water boils (100°C) or overflows (1000ml), autonomous `:event` blocks instantly cut the power.
