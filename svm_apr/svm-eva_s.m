#!/usr/bin/octave -qf

if (nargin!=4)
printf("Usage: gaussian-exp.m <trdata> <trlabels> <t10kdata> <t10labels>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
t10kdata = arg_list{3};
t10labs = arg_list{4};

load(trdata);
load(trlabs);
load(t10kdata);
load(t10labs);

addpath("svm_apr");
printf("\n c 	d	 err");
printf("\n------- ------- -------\n");
param1 = ['-t ','1 ','-d ','4 ','-c ','1 ','-q'];
res = svmtrain(xl,X, param1);
clas = svmpredict(yl,Y,res,'-q');
err =  1 - mean(clas == yl);
printf("%6.3f %6.3f %6.3f\n", 1, 4, err);
param2 = ['-t ','1 ','-d ','5 ','-c ','1 ','-q'];
res = svmtrain(xl,X, param2);
clas = svmpredict(yl,Y,res,'-q');
err =  1 - mean(clas == yl);
printf("%6.3f %6.3f %6.3f\n", 1, 5, err);



