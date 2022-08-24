function RoboticsPlaygroundInstall
% This funciton installs the toolbox into MATLAB sodocumentation and
% applications are available.

addons = matlab.addons.installedAddons;
if any(find(strcmp(addons.Name,'Robotics Playground')))
    uiwait(msgbox('Previous version already installed. To update your Robotics Playground version first uninstall using the Add-Ons explorer','Already Installed','modal'));
    matlab.apputil.run('RoboticsPlaygroundAppAPP');
    closeNoPrompt(matlab.desktop.editor.getActive);
else
    matlab.addons.install(which('Robotics Playground.mltbx'));
    matlab.apputil.run('RoboticsPlaygroundAppAPP');
    uiwait(msgbox('The Robotics Playground has been succesfully installed! You can now access files and lessons through the provided MATLAB APP in the ''APPS'' tab of the toolbar.','Installation Complete','modal'));
    closeNoPrompt(matlab.desktop.editor.getActive);
end