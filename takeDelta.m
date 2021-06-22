function [dfG,dfR]=takeDelta(CinGreen,CinRed,FrameRate)
%normally start at 2 but try moving to 10 because sometimes it messes up
%the normalization I think?

baseG=mean(CinGreen(:,2:5*FrameRate),2);%skip the first frame since it's sometimes messed up
dfG=CinGreen./baseG;
baseR=mean(CinRed(:,2:5*FrameRate),2);% same skip the first frame since sometimes the top of the image is missing
dfR=CinRed./baseR;
end

