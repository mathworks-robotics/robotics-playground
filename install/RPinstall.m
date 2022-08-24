
%% Install toolbox

matlab.addons.install(which('Robotics Playground.mltbx'));
matlab.apputil.run('RoboticsPlaygroundAppAPP');
uiwait(msgbox('The Robotics Playground has been succesfully installed! You can now close the MATLAB project and access files and lessons through the provided MATLAB APP in the ''APPS'' tab of the toolbar.','Installation Complete - Robotics Playground','modal'));
