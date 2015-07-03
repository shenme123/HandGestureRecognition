function []= hw1()
    % this is the main function to make decision based on image input. img1 
    % and img2 are the two input images, and can be changed accordingly.
    % Message of if the input pass the test is printed in then console.
    close all;
    % show a message to explain 
    waitfor(msgbox('To unlock, please first place your hand with a closed fist in the center of the first image, followed by a flat palm in the center with fingers outwardly splayed'));
    
    % 1st step: fist
    disp('1. Place your hand with a closed fist in the center of the first image:');
    img1 = imread('unknown_4.jpg');
    
    % verify gesture to see if it is a fist based on the assumptions. if
    % yes, go to next step. if not, faile the test and return.
    num = verify_gesture(img1);
    if num==-1
        disp('No hand detected. Please try again');
        return;
    elseif num == -2
        disp('Not at center. Please try again');
        return;
    end
    if num~=0
        disp('Not closed fist. Please try again');
        return;
    end
    
    % verify gesture to see if it is a palm based on the assumptions. if
    % yes, pass the test. if not, fail the test and return.
    disp('Fist detected.');
    disp('2. Place your hand as a flat palm in the center with fingers outwardly splayed:');
    img2 = imread('unknown_1.jpg');
    num = verify_gesture(img2);
    if num==-1
        disp('No hand detected. Please try again');
        return;
    elseif num == -2
        disp('Not at center. Please try again');
        return
    end
    if num~=5
        disp(sprintf('%d splayed fingers detected. Please try again', num));
        return;
    end
    disp('System unlocked!');
end
