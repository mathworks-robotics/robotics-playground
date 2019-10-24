% Create virtual robot
myRobot=mlrobot;

% Start running the virtual environment simulation
mlrobotstart(myRobot);

% Fill in the for loop in order to read the robot's angle

for i=1:30
    mlrobotsetmotorvoltage(myRobot,'left',5);
    mlrobotsetmotorvoltage(myRobot,'right',5);
    
    % Assign the output of a "mlrobotreadcompassangle" to a variable
    % named "angle"
  
    angle(i)=mlrobotreadcompassangle(myRobot);
    
    % Wait for 0.1 seconds before reading the next robot angle
    pause(0.1);
end

% Stop simulation
mlrobotstop(myRobot);

% Create a time array to plot against
time=0.1:0.1:3;

% Use the "plot" command to plot the robot angle vs time
plot(time,angle)

title('Robot Orientation vs Time');
xlabel('Time (s)')
ylabel('Robot Orientation (Degrees)')