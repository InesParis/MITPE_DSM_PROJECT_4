# MITPE DSM Project

## Overview
The MITPE DSM Project is designed to simulate and visualize the cost evolution of components based on a Dependency Structure Matrix (DSM). The project includes a graphical user interface (GUI) for user interaction and visualization of results.

## Project Structure
```
MITPE_DSM_PROJECT_4
├── src
│   ├── init_DSM.m          % Initializes the Dependency Structure Matrix (DSM)
│   ├── main.m              % Entry point for the project; initializes parameters and opens the GUI
│   ├── partition.m         % Generates random partitions for cost distribution
│   ├── RecipeGUI.m         % Contains the GUI code for user interaction
│   ├── seematrix.m         % Visualizes the DSM as an image
│   ├── shuffle.m           % Randomly shuffles elements of an array
│   ├── simulateRecipeModel.m % Simulates cost evolution based on the DSM
│   └── fig_costEvolution.m  % Computes and plots theoretical cost evolution
├── gui
│   └── RecipeGUI.fig       % GUI layout file created with a design tool
├── assets
│   └── styles
│       └── MITPE_Style.css % CSS styles for enhancing the GUI appearance
├── README.md               % Documentation for the project
└── LICENSE                 % Licensing information
```

## Getting Started

### Prerequisites
- MATLAB environment
- Required toolboxes for GUI development

### Installation
1. Clone or download the project repository.
2. Ensure all files are in the correct directory structure as shown above.

### Running the Project
To run the project, execute the `main.m` file in MATLAB. This will initialize the DSM and open the GUI for user interaction.

### Usage
- Use the GUI to interact with the DSM and visualize the cost evolution.
- Select different methods for initializing the DSM and observe the results.

## Customization
To customize the appearance of the GUI, modify the `MITPE_Style.css` file located in the `assets/styles` directory. Ensure that the styles are correctly linked in the `RecipeGUI.m` file.

## License
This project is licensed under the terms specified in the LICENSE file. Please refer to it for details on usage and distribution rights.