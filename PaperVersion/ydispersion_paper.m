load('./CleanBehaviourdata/CXactivation/FB5AB_chrimactivation.mat');
load('./CleanBehaviourdata/CXactivation/13B10ADvt041421DB_chrimactivation');
load('./CleanBehaviourdata/CXactivation/65C03_chrimactivation');
load('./CleanBehaviourdata/CXactivation/12D12_chrimactivation');
load('./CleanBehaviourdata/MBLHactivation/MB077B_chrimactivation.mat');
load('./CleanBehaviourdata/MBLHactivation/MB082C_chrimactivation.mat');
load('./CleanBehaviourdata/MBLHactivation/MB052B_chrimactivation.mat');
load('./CleanBehaviourdata/MBLHactivation/lh1396_chrimactivation.mat');

colours={[54/255, 75/255, 154/255],[74/255,123/255,183/255],[110/255,166/255,205/255],[152/255,202/255,225/255],[253/255,179/255,102/255],[246/255,126/255,75/255],[221/255,61/255,45/255],[165/255,0,38/255]};
%make timecourse plots of y dispersion 
figure; hold on;
[mb052bmaxdisp,mb052bhalftime,mb052bcourses,avgpostdispmb052b]=ydispersionflybyfly(preparedata(RMB052B,[30 35],0.3,0),1,colours{8});
[mb077bmaxdisp,mb077bhalftime,mb077bcourses,avgpostdispmb077b]=ydispersionflybyfly(preparedata(RMB077B,[30 35],0.3,0),1,colours{7});
[mb082cmaxdisp,mb082chalftime,mb082ccourses,avgpostdispmb082c]=ydispersionflybyfly(preparedata(RMB082C,[30 35],0.3,0),1,colours{6});
[lh1396maxdisp,lh1396halftime,lh1396courses,avgpostdisplh1396]=ydispersionflybyfly(preparedata(Rlh1396,[30 35],0.3,0),1,colours{5});
[maxdisp65c03,halftime65c03,courses65c03,avgpostdisp65c03] = ydispersionflybyfly(preparedata(R65C03,[30 35],0.3,0),1,colours{4});
[maxdispvfb,halftimevfb,coursesvfb,avgpostdispvfb] = ydispersionflybyfly(preparedata(R13B10ADvt041421DB,[30 35],0.3,0),1,colours{3});
[maxdisp21d07,halftime21d07,courses21d07,avgpostdisp21d07] = ydispersionflybyfly(preparedata(RFB5AB,[30 35],0.3,0),1,colours{2});
[maxdisp12d12,halftime12d12,courses12d12,avgpostdisp12d12] = ydispersionflybyfly(preparedata(R12D12,[30 35],0.3,0),1,colours{1});

clear R*