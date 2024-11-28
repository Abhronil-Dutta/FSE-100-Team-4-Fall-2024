% Automatic Maze Solver
% Team 4 - Abhronil Dutta, Siddharth Chowdhury, Sumukh Gowda, Harshil
%          Amithineni, Omar Albaker

brick.SetColorMode(1, 2);  % Set color mode for the color sensor
sidespeedl = 50 ;  % Speed for turning
forwardSpeed = 50;  % Speed for forward motion


global key;
InitKeyboard();

while 1
    pause(0.1);  % Short pause for system stability
    brick.MoveMotor('A', forwardSpeed + 3);
    brick.MoveMotor('D', forwardSpeed);

    % Read distance from the left ultrasonic sensor
    distanceLeft = brick.UltrasonicDist(3);
    disp(['Ultrasonic Distance Left: ', num2str(distanceLeft)]);
    
    % Color handling
    color = brick.ColorCode(1);
    disp(['Color Detected: ', num2str(color)]);

    % Detects Goal block
    if color == 2 || color == 4 || color == 3  % Green, Blue, or Yellow
        disp('Goal Color Detected - Stopping');
        brick.StopMotor('ADC', 'Brake');
        run("Keyboard.m"); % runs manual control
        break;  % Exit loop when goal is reached
    end

    if color == 5  % Red stripe detection
        disp('Red Stripe Detected');
        brick.StopMotor('ADC', 'Coast');
        pause(3); % pauses for 3 seconds
    end

    % Left open navigation
    if distanceLeft > 50  

        disp('Open Space Detected')
        disp('Making an Exploratory Left Turn');

        % For detecting red stripe while turning

        color = brick.ColorCode(1);
        if color == 5  % Red stripe detection
            disp('Red Stripe Detected');
            brick.StopMotor('ADC', 'Coast');
            pause(3); 
        end
        
        pause(0.3); % going forward untill tere is completely no wall on left (to avoid collisions)

        % For detecting red stripe while turning
        color = brick.ColorCode(1);
        if color == 5  % Red stripe detection
            disp('Red Stripe Detected');
            brick.StopMotor('ADC', 'Coast');
            pause(3); 
        end

        % turning 

        brick.MoveMotor('A', -sidespeedl); 
        brick.MoveMotor('D', sidespeedl);
        pause(0.51);  % Adjust for a 90-degree turn

        brick.StopMotor('AD', 'Brake');

        % For detecting red stripe while turning
        color = brick.ColorCode(1);
        if color == 5  % Red stripe detection
            disp('Red Stripe Detected');
            brick.StopMotor('ADC', 'Coast');
            pause(3); 
        end

        % Move forward to avoid going back
        brick.MoveMotor('A', forwardSpeed + 3);
        brick.MoveMotor('D', forwardSpeed);

        % For detecting red stripe while turning
        color = brick.ColorCode(1);
        if color == 5  % Red stripe detection
            disp('Red Stripe Detected');
            brick.StopMotor('ADC', 'Coast');
            pause(3); 
        end

        pause(2.0);
        continue;  % Skip to the next loop iteration
    end

    % Touch Sensor Logic
    touch = brick.TouchPressed(2);
    if touch
        disp('Touch Detected');
        brick.StopMotor('ADC', 'Brake');
        pause(1);
        brick.MoveMotor('AD', -50);  % Reverse
        pause(0.75);
        brick.StopMotor('ADC', 'Brake');
        pause(2);
        
        % Decide turn based on ultrasonic sensor
        distanceLeft = brick.UltrasonicDist(3);
        if distanceLeft > 50  % If left side is clear
            disp('Turning Left');
            brick.MoveMotor('A', -sidespeedl);  % Left wheel reverse
            brick.MoveMotor('D', sidespeedl - 1);   % Right wheel forward
            pause(0.51);  % Adjust for 90-degree turn
            brick.StopMotor('AD', 'Brake');
        else
            disp('Turning Right');
            brick.MoveMotor('A', sidespeedl + 1);   % Left wheel forward
            brick.MoveMotor('D', -sidespeedl);  % Right wheel reverse
            pause(0.51);  % Adjust for 90-degree turn
            brick.StopMotor('AD', 'Brake');
        end
        continue;  % Skip to the next loop iteration
    end
    

    % Quit Command Handling
    switch key
        case 'q'
            disp('Quit Command Detected - Exiting');
            brick.StopMotor('AD', 'Brake');
            break;
    end
end

CloseKeyboard();
disp('Maze Navigation Complete');
