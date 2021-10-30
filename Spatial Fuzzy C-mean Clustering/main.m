%% reading the real MRI, resizing, generating synthetic images
clc
close all
clear
%MRI image
image = double(rgb2gray(imread('Capture','png')));
T1 = image(2:598,2:598);
T2 = image(2:598,620:1216);
original_size = size(T1);
T2 = imresize(T2,[512,512]);
T1 = imresize(T1,[512,512]);
figure;
subplot(1, 2, 1);
imshow(T1,[]);impixelinfo;title('T1-weighted image');
subplot(1, 2, 2);
imshow(T2,[]);impixelinfo;title('T2-weighted image');

% synthetic images 
rec_image1 = 50*ones(512,512);
rec_image1(256:512,256:512) = 200;
rec_image1(257:512,1:256) = 150;
rec_image1(1:256,257:512) = 100;

rec_image2 = rec_image1;
rec_image2(257:512,1:256) = 100;
rec_image2(1:256,257:512) = 150;
figure;
subplot(1, 2, 1);
imshow(rec_image1,[]);impixelinfo;title('synthetic T1');
subplot(1, 2, 2);
imshow(rec_image2,[]);impixelinfo;title('synthetic T2');
%% adding noise and plots
%uniform random noise
rng('default')
uniform_random_noise = 2*(rand(size(T1,1),size(T1,2)) - 0.5)*10;

T1_noisy = T1 + uniform_random_noise;
T2_noisy = T2 + uniform_random_noise;

noisy_rec_image1 = rec_image1 + uniform_random_noise;
noisy_rec_image2 = rec_image2 + uniform_random_noise;

% uniform random noise with magnitude: 3.5*sqrt(pixel intensity)for each
% pixel
for p=1:size(rec_image1(:))
    noise_image1(p) = 3.5*sqrt(rec_image1(p));
end
for p=1:size(rec_image2(:))
    noise_image2(p) = 3.5*sqrt(rec_image2(p));
end
noise_image1 = imresize(noise_image1,[512,512]);
noise_image2 = imresize(noise_image2,[512,512]);
% noisy_rec_image1 = rec_image1 + noise_image1;
% noisy_rec_image2 = rec_image2 + noise_image2;

% figure;
% subplot(1, 2, 1);
% imshow(T1_noisy,[]);impixelinfo;title('noisy T1');
% subplot(1, 2, 2);
% imshow(T2_noisy,[]);impixelinfo;title('noisy T2');
%%
data = [T1(:),T2(:)];
%data = [noisy_rec_image1(:),noisy_rec_image2(:)];
%% sFCM (spatial FCM)
% parameter setup
p = 1; %centre pixel contribution
q = 1; %neighborhood contribution
m = 2; %fuzziness
w = 5; %window size
k = 6; %number of clusters
Max_iter = 1e+16; %maximum iterations if the threshold is never reached
threshold = 2e-08; %threshold for checking the convergence

% computing the cluster centers N times with different random initilization to reduce the sensitivity of the output to noise
N = 1;
average_centers = zeros(k,2);
for iter = 1:N
    [C1 , out1] = Spatial_Cmeans(data,k,Max_iter,m,w,p,q,threshold,size(T1,2),size(T1,1));
    [~,sorted] = sort(vecnorm([C1]'));
    C1 = C1(sorted,:);
    average_centers = average_centers + C1;
end
%%
% calculating the average of all cluster centers to obtain the final
% cluster centers
C = average_centers/N;
% calculate the membership values based on the new cluster centers
out = membership_calculation(data,C,k,m,w,p,q,size(T1,2),size(T1,1));
% defuzzifying and assiging an intensity between 0 and 1 to each cluster
maxU = max(out,[],2);
index1 = find(out(:,1) == maxU);
index2 = find(out(:,2) == maxU);
index3 = find(out(:,3) == maxU);
index4 = find(out(:,4) == maxU);
index5 = find(out(:,5) == maxU);
index6 = find(out(:,6) == maxU);

% visualization
fcmImage(1:512*512)=0;
fcmImage(index1)= 0.8;
fcmImage(index2)= 0.6;
fcmImage(index3)= 0.4;
fcmImage(index4)= 0.2;
fcmImage(index5)= 0;
fcmImage(index6)= 1;
imagNew = reshape(fcmImage,512,512);
imagNew = imresize(imagNew,[original_size(1),original_size(2)]);
figure;imshow(imagNew,[]);impixelinfo;title('spatial cmeans');

%% built-in FCM
% parameter setup
k = 6;
m = 2;
% computing cluster centers and membership vaues
[center_fcm,U_fcm,obj_fcn_fcm] = fcm(data,k,[2,1000000000,0.000002,false]);

% defuzzifying and assiging an intensity between 0 and 1 to each cluster
maxU_fcm = max(U_fcm);
index1_fcm = find(U_fcm(1,:) == maxU_fcm);
index2_fcm = find(U_fcm(2,:) == maxU_fcm);
index3_fcm = find(U_fcm(3,:) == maxU_fcm);
index4_fcm = find(U_fcm(4,:) == maxU_fcm);
index5_fcm = find(U_fcm(5,:) == maxU_fcm);
index6_fcm = find(U_fcm(6,:) == maxU_fcm);
% visualization
fcmImage_fcm(1:512*512)=0; 
fcmImage_fcm(index1_fcm)= 1;
fcmImage_fcm(index2_fcm)= 0.8;
fcmImage_fcm(index3_fcm)= 0.6;
fcmImage_fcm(index4_fcm)= 0.4;
fcmImage_fcm(index5_fcm)= 0.0;
fcmImage_fcm(index6_fcm)= 0.1;
imagNew_fcm = reshape(fcmImage_fcm,512,512);
imagNew_fcm = imresize(imagNew_fcm,[original_size(1),original_size(2)]);
figure;imshow(imagNew_fcm,[]);impixelinfo;title('built-in FCM');
%% plotting sFCM vs FCM
figure;
subplot(1, 2, 1);
imshow(imagNew,[]);impixelinfo;title('sFCM');
subplot(1, 2, 2);
imshow(imagNew_fcm,[]);impixelinfo;title('built-in FCM');
%% evaluation based on partition coefficient (Vpc), partition entropy (Vpe), and Xie-Beni index (Vxb)
%sFCM
Vpc_sFCM = Vpc(out)
Vpe_sFCM = Vpe(out)
Vxb_sFCM = Vxb(out, data, C)
%biult-in FCM
Vpc_FCM = Vpc(U_fcm')
Vpe_FCM = Vpe(U_fcm')
Vxb_FCM = Vxb(U_fcm', data, center_fcm)
%% paired-sample t-test for vpc
%these values were computed previously in the evaluation step and are
%presented in the report table
xpc_FCM = [0.8724,0.8411,0.7108,0.6981,0.9609,0.7338,0.6444,0.6789];
ypc_FCM11 = [0.9396,0.9368,0.8205,0.7821,0.9991,0.9628,0.7649,0.7160];
ypc_FCM02 = [0.9243,0.9213,0.6056,0.4732,0.9950,0.9628,0.6654,0.4146];
[h_pc,p_pc,ci_pc,stats_pc] = ttest(ypc_FCM11,xpc_FCM,'Tail','right')
%% paired-sample t-test for vpc
%these values were computed previously in the evaluation step and are
%presented in the report table
xpe_FCM = [0.8724,0.3438,0.5706,0.6112,0.1038,0.5309,0.6665,0.6086];
ype_FCM11 = [0.1133,0.1195,0.3197,0.4118,0.0035,0.1045,0.4287,0.5195];
ype_FCM02 = [0.1402,0.1471,0.6177,0.8451,0.0098,0.1045,0.6500,1.0846];
[h_pe,p_pe,ci_pe,stats_pe] = ttest(ype_FCM11,xpe_FCM,'Tail','left')
%% paired-sample t-test for vxb
%these values were computed previously in the evaluation step and are
%presented in the report table
xxb_FCM = [0.1043,0.1473,0.3132,0.1747,0.0144,0.1307,0.1133,0.1188];
yxb_FCM11 = [0.0954,0.1234,0.2041,0.2363,0.0151,0.1593,0.1090,0.1004];
yxb_FCM02 = [0.1287,0.1595,2.6552,3.1690,0.0169,0.1593,0.5684,1.9083];
[h_xb,p_xb,ci_xb,stats_xb] = ttest(yxb_FCM11,yxb_FCM02,'Tail','left')