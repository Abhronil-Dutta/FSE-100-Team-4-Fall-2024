% Team 4 - Abhronil Dutta, Siddharth Chowdhury, Sumukh Gowda, Harshil
%          Amithineni, Omar Albaker
global key

% w - forward
% a - left
% d - right
% s - back
% i - pulley up
% k - pulley down
% q - quit

frontspeed = 50;
backspeed = 50;
sidespeed = 50;
pickupspeed = 15;

brick.SetColorMode(1, 2);
InitKeyboard();

while 1
    pause(0.1);
    %keyboard control 
    switch key
        case 'w'
            disp("W is pressed");
            brick.MoveMotor('AD', frontspeed);
        case 's'
            disp("S is pressed");
            brick.MoveMotor('AD', -backspeed);
        case 'a'
            disp("A is pressed");
            brick.MoveMotor('A', -sidespeed);
            brick.MoveMotor('D', sidespeed);
        case 'd'
            disp("D is pressed");
            brick.MoveMotor('D', -sidespeed);
            brick.MoveMotor('A', sidespeed);
        case 0
            disp('No key pressed');
            brick.StopMotor('ADC', 'Brake');
        case 'q'
            disp("Quit");
            brick.StopMotor('ADB', 'Brake');
            run("Automatic.m");
            break;
                
        % pickup
        case 'i' 
            disp("UP");
            brick.MoveMotor('B', -pickupspeed);
            pause(0.1);
            brick.StopMotor('B', 'Brake');
        case 'k'
            disp("DOWN");
            brick.MoveMotor('B', pickupspeed);
            pause(0.1);
            brick.StopMotor('B', 'Brake');
    end
end
CloseKeyboard();
   
