tablessides=generatetreeclassifiers;
Leftabside=tablessides.dLNa;
Righttabside=tablessides.dRIGHT;


bothtabsides.wind=table(Leftabside.wind.Var1, Leftabside.wind.Var2,Leftabside.wind.totaldata,Righttabside.wind.totaldata);
bothtabsides.odour=table(Leftabside.odour.Var1, Leftabside.odour.Var2,Leftabside.odour.totaldata,Righttabside.odour.totaldata);
bothtabsides.windoff=table(Leftabside.windoff.Var1, Leftabside.windoff.Var2,Leftabside.windoff.totaldata,Righttabside.windoff.totaldata);

bothtabsides.wind=table(Leftabside.wind.Var1, Leftabside.wind.Var2,Leftabside.wind.totaldata-Righttabside.wind.totaldata);
bothtabsides.odour=table(Leftabside.odour.Var1, Leftabside.odour.Var2,Leftabside.odour.totaldata-Righttabside.odour.totaldata);
bothtabsides.windoff=table(Leftabside.windoff.Var1, Leftabside.windoff.Var2,Leftabside.windoff.totaldata-Righttabside.windoff.totaldata);


LNatreewindside=fitctree(bothtabsides.wind,"Var1",'crossval','on');
LNatreeodourside=fitctree(bothtabsides.odour,"Var1",'crossval','on');
LNatreewindoffside=fitctree(bothtabsides.windoff,"Var1",'crossval','on');

winderrside=kfoldLoss(LNatreewindside,'Mode','individual');
odourerrside=kfoldLoss(LNatreeodourside,'Mode','individual');
windofferrside=kfoldLoss(LNatreewindoffside,'Mode','individual');


errLR.Lna.wind=winderrside;
errLR.Lna.odour=odourerrside;
errLR.Lna.windoff=windofferrside;

