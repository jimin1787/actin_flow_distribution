%% Testing
clear; close all;
velocityMap = load('/Users/jmshin/Desktop/FromDaichi/Synergid_STICS/1-1.newroi2/STICSOutputs\VelocityMapF-actin Flow.mat').velocityMap;
finalAngleVel = [];
for veli =1:size(velocityMap,2)
newVx = reshape(velocityMap{1,veli}.vx,[1,169]);
newVy = reshape(velocityMap{1,veli}.vy,[1,169]);
goodVectors = velocityMap{1,veli}.goodVectors;

gi  = 0;
for i=1:size(goodVectors,2)
    if(goodVectors(1,i) == 1)
        gi = gi+1;
        refinedVx (gi,1) = newVx(1,i);
        refinedVy (gi,1) = newVy(1,i);
        angleVel(gi,1) = rad2deg(atan(newVy(1,i)/newVy(1,i)));
    end
end
angleVel = (atan2d(refinedVy,refinedVx));
indx = find(angleVel<0);
newAngle = 360 + angleVel(indx);
angleVel(indx) = newAngle;
allFrameAngle{1,veli} = angleVel; %Angle Values of all the frames
finalAngleVel = [finalAngleVel angleVel']; %After merging
end

%% Polar Histogram Plot
fileName = ['merged histogram polar plot' num2str(veli)];
th = 1:360;
th = deg2rad(th);
radFinal = deg2rad(finalAngleVel);
figure();
h = polarhistogram(radFinal,100,'Normalization','probability','LineWidth',1.2);
h.DisplayStyle = 'stairs';
title('Radar Plot of Actin Flow')
saveas(gca,[fileName,'.fig']);

% 
% figure()
% polarscatter(th,values,'MarkerFaceColor','blue')
