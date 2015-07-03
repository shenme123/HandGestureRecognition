% show a message to explain 
% waitfor(msgbox('To unlock, please first place your hand with a closed fist in the center of the first image, followed by a flat palm in the center with fingers outwardly splayed'));
clear('cam');
cam = webcam;
preview(cam);
figure;
while 1
    img = snapshot(cam);
    [num, out] = verify_gesture_real(img);
    imshow(out);
    pause(.01);
end
% disp('1. Place your hand with a closed fist in the center of the first image:');
% img1 = imread('I:\W4735-VI\hw1\generate_skinmap\fist_1.jpg');
% num = verify_gesture(img1);
% if num==-1
%     disp('No hand detected. Please try again');
%     exit;
% elseif num == -2
%     disp('Not at center. Please try again');
%     exit;
% end
% if num~=0
%     disp('Not closed fist. Please try again');
%     exit;
% end
% 
% disp('Fist detected.');
% disp('2. Place your hand as a flat palm in the center with fingers outwardly splayed:');
% img2 = imread('palm_1.jpg');
% num = verify_gesture(img2);
% if num==-1
%     disp('No hand detected. Please try again');
%     exit;
% elseif num == -2
%     disp('Not at center. Please try again');
%     exit
% end
% if num~=5
%     sprintf('%d splayed fingers detected. Please try again', num);
%     exit;
% end
% disp('System unlocked!');
