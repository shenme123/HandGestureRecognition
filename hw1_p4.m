function []= hw1_p4()
    % this is the main function to match password based on image input. 
    % cellx are potential image inputs to the system, and can be changed 
    % accordingly.
    
    % Message of if the password match succeed shown as popup windows.
    
    close all;
    % show a message to explain 
    password = 1234;
    waitfor(msgbox('please input 4-digit password with gestures (from 0 to 5 accepted, fist as 0. O to reset):'));
    
    % initialize input sequences
    cell1 = {'1.jpg', '2.jpg', '3.jpg', '4.jpg'};
    cell2 = {'1.jpg', '3.jpg', 'O.jpg', '1.jpg', '2.jpg', '3.jpg', '4.jpg'};
    cell3 = {'1.jpg', '0.jpg', '2.jpg', '3.jpg'};
    
    % initialize an empty input, will be used to concatenate each digit
    % from gestures.
    input = '';
    
    % loop through input images
    for i=1:length(cell3)
        img = imread(cell3{i});
        num = verify_gesture_p4(img);
        
        % if no skin detected, return
        if num==-1
            disp('No gesture detected. Please try again');
            return;
        % if hand not at the defined center, return
        elseif num==-2
            disp('Not at center. Please try again');
            return;
        % if 'O' is met in gestures, reset
        elseif num==-3
            waitfor(msgbox('Reset done.'));
            input = '';
            
        % concatenate 'input' with new digit
        else
            input = strcat(input, num2str(num));
        end                
    end
    
    disp('Your input:');
    disp(input);
    % pop up decisions
    if (strcmp(input, num2str(password)))
        msgbox('Password correct, system unlocked');
        return;
    else
        msgbox('Password incorrect, try again');
        return;
    end
        
end
