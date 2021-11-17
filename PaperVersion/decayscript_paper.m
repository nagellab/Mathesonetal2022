decayMB052B=decayslope_paper(pwd,'MB052B',1);
decaylh1396=decayslope_paper(pwd,'lh1396',1);
decayMB082C=decayslope_paper(pwd,'MB082C',2);
decayMB077B=decayslope_paper(pwd,'MB077B',2);
decay65C03=decayslope_paper(pwd,'65C03',1);
decay12D12=decayslope_paper(pwd,'12D12',2);
decay21D07=decayslope_paper(pwd,'21D07',1);
decayvFB=decayslope_paper(pwd,'vFB',1);

figure; hold on;

colours={[54/255, 75/255, 154/255],[74/255,123/255,183/255],[110/255,166/255,205/255],[152/255,202/255,225/255],[253/255,179/255,102/255],[246/255,126/255,75/255],[221/255,61/255,45/255],[165/255,0,38/255]};

figure; hold on;
shadedErrorBar([1 2 3 4 5],[nanmean(decayMB052B.first),nanmean(decayMB052B.second),nanmean(decayMB052B.third),nanmean(decayMB052B.fourth),nanmean(decayMB052B.fith)]/nanmean(decayMB052B.first),[std((decayMB052B.first)/nanmean(decayMB052B.first))/sqrt(numel(decayMB052B.first)),std((decayMB052B.second)/nanmean(decayMB052B.second))/sqrt(numel(decayMB052B.second)),std((decayMB052B.third)/nanmean(decayMB052B.third))/sqrt(numel(decayMB052B.third)),std((decayMB052B.fourth)/nanmean(decayMB052B.fourth))/sqrt(numel(decayMB052B.fourth)),std((decayMB052B.fith)/nanmean(decayMB052B.fith)/sqrt(numel(decayMB052B.fith)))],{'color',colours{8}},0);
shadedErrorBar([1 2 3 4 5],[nanmean(decayMB077B.first),nanmean(decayMB077B.second),nanmean(decayMB077B.third),nanmean(decayMB077B.fourth),nanmean(decayMB077B.fith)]/nanmean(decayMB077B.first),[std((decayMB077B.first)/nanmean(decayMB077B.first))/sqrt(numel(decayMB077B.first)),std((decayMB077B.second)/nanmean(decayMB077B.second))/sqrt(numel(decayMB077B.second)),std((decayMB077B.third)/nanmean(decayMB077B.third))/sqrt(numel(decayMB077B.third)),std((decayMB077B.fourth)/nanmean(decayMB077B.fourth))/sqrt(numel(decayMB077B.fourth)),std((decayMB077B.fith)/nanmean(decayMB077B.fith))/sqrt(numel(decayMB077B.fith))],{'color',colours{7}},0);
shadedErrorBar([1 2 3 4 5],[nanmean(decayMB082C.first),nanmean(decayMB082C.second),nanmean(decayMB082C.third),nanmean(decayMB082C.fourth),nanmean(decayMB082C.fith)]/nanmean(decayMB082C.first),[std((decayMB082C.first)/nanmean(decayMB082C.first))/sqrt(numel(decayMB082C.first)),std((decayMB082C.second)/nanmean(decayMB082C.second))/sqrt(numel(decayMB082C.second)),std((decayMB082C.third)/nanmean(decayMB082C.third))/sqrt(numel(decayMB082C.third)),std((decayMB082C.fourth)/nanmean(decayMB082C.fourth))/sqrt(numel(decayMB082C.fourth)),std((decayMB082C.fith)/nanmean(decayMB082C.fith))/sqrt(numel(decayMB082C.fith))],{'color',colours{6}},0);
shadedErrorBar([1 2 3 4 5],[nanmean(decaylh1396.first),nanmean(decaylh1396.second),nanmean(decaylh1396.third),nanmean(decaylh1396.fourth),nanmean(decaylh1396.fith)]/nanmean(decaylh1396.first),[std((decaylh1396.first)/nanmean(decaylh1396.first))/sqrt(numel(decaylh1396.first)),std((decaylh1396.second)/nanmean(decaylh1396.second))/sqrt(numel(decaylh1396.first)),std((decaylh1396.third)/nanmean(decaylh1396.third))/sqrt(numel(decaylh1396.third)),std((decaylh1396.fourth)/nanmean(decaylh1396.fourth))/sqrt(numel(decaylh1396.fourth)),std((decaylh1396.fith)/nanmean(decaylh1396.fith))/sqrt(numel(decaylh1396.fith))],{'color',colours{5}},0);
shadedErrorBar([1 2 3 4 5],[nanmean(decay65C03.first),nanmean(decay65C03.second),nanmean(decay65C03.third),nanmean(decay65C03.fourth),nanmean(decay65C03.fith)]/nanmean(decay65C03.first),[std((decay65C03.first)/nanmean(decay65C03.first))/sqrt(numel(decay65C03.first)),std((decay65C03.second)/nanmean(decay65C03.second))/sqrt(numel(decay65C03.second)),std((decay65C03.third)/nanmean(decay65C03.third))/sqrt(numel(decay65C03.third)),std((decay65C03.fourth)/nanmean(decay65C03.fourth))/sqrt(numel(decay65C03.fourth)),std((decay65C03.fith)/nanmean(decay65C03.fith))/sqrt(numel(decay65C03.fith))],{'color',colours{4}},0);
shadedErrorBar([1 2 3 4 5],[nanmean(decayvFB.first),nanmean(decayvFB.second),nanmean(decayvFB.third),nanmean(decayvFB.fourth),nanmean(decayvFB.fith)]/nanmean(decayvFB.first),[std((decayvFB.first)/nanmean(decayvFB.first))/sqrt(numel(decayvFB.first)),std((decayvFB.second)/nanmean(decayvFB.second))/sqrt(numel(decayvFB.second)),std((decayvFB.third)/nanmean(decayvFB.third))/sqrt(numel(decayvFB.third)),std((decayvFB.fourth)/nanmean(decayvFB.fourth))/sqrt(numel(decayvFB.fourth)),std((decayvFB.fith)/nanmean(decayvFB.fith))/sqrt(numel(decayvFB.fith))],{'color',colours{3}},0);
shadedErrorBar([1 2 3 4 5],[nanmean(decay21D07.first),nanmean(decay21D07.second),nanmean(decay21D07.third),nanmean(decay21D07.fourth),nanmean(decay21D07.fith)]/nanmean(decay21D07.first),[std((decay21D07.first)/nanmean(decay21D07.first))/sqrt(numel(decay21D07.first)),std((decay21D07.second)/nanmean(decay21D07.second))/sqrt(numel(decay21D07.second)),std((decay21D07.third)/nanmean(decay21D07.third))/sqrt(numel(decay21D07.third)),std((decay21D07.fourth)/nanmean(decay21D07.fourth))/sqrt(numel(decay21D07.fourth)),std((decay21D07.fith)/nanmean(decay21D07.fith))/sqrt(numel(decay21D07.fith))],{'color',colours{2}},0);
shadedErrorBar([1 2 3 4 5],[nanmean(decay12D12.first),nanmean(decay12D12.second),nanmean(decay12D12.third),nanmean(decay12D12.fourth),nanmean(decay12D12.fith)]/nanmean(decay12D12.first),[std((decay12D12.first)/nanmean(decay12D12.first))/sqrt(numel(decay12D12.first)),std((decay12D12.second)/nanmean(decay12D12.second))/sqrt(numel(decay12D12.second)),std((decay12D12.third)/nanmean(decay12D12.third))/sqrt(numel(decay12D12.third)),std((decay12D12.fourth)/nanmean(decay12D12.fourth))/sqrt(numel(decay12D12.fourth)),std((decay12D12.fith)/nanmean(decay12D12.fith))/sqrt(numel(decay12D12.fith))],{'color',colours{1}},0);

ylabel('Normalized odor response');
xticks([1 2 3 4 5]);
xlabel('trial block');




