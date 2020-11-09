# Alpha-Mu-Fading-Matlab
The \alpha-\mu fading model implemented in Matlab and was created using Matlab 2018a.
Plots the theoretical and simulated, envelope porbability density functions (PDF).

Further details of this model can be found in Yacoub's paper: 
"The \alpha-\mu Distribution: A Physical Fading Model for the Stacy Distribution".

Run main.m to start the GUI if Matlab is already installed.
Alternatively if Matlab isn't installed, can run the installer from the build folder, which requires an internet connection to download the required files.

The input \alpha accepts values in the range 1 to 10.
The input \mu accepts integer values in the range 1 to 10.
The input \hat{r} accepts values in the range 0.5 to 2.5.

When running the program the intial window appears:

![ScreenShot](https://raw.github.com/Jonathan-Browning/Alpha-Mu-Fading-Matlab/main/docs/window.png)

Entering values for the \alpha, \mu and the root mean sqaure of the signal \hat{r}:

![ScreenShot](https://raw.github.com/Jonathan-Browning/Alpha-Mu-Fading-Matlab/main/docs/inputs.png)

The theoretical evenlope PDF is plotted to compare with the simulation and gives the execution time for the theoretical calculation and simulation together:

![ScreenShot](https://raw.github.com/Jonathan-Browning/Alpha-Mu-Fading-Matlab/main/docs/results.png)
