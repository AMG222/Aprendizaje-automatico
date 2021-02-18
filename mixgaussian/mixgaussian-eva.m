#!/usr/bin/octave -qf

if (nargin!=6)
printf("Usage: gaussian-eva.m <trdata> <trlabels> <tedata> <telabels> <k> <alpha>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};
k=str2num(arg_list{5});
alpha=str2num(arg_list{6});

% Loading data
load(trdata);
load(trlabs);
load(tedata);
load(telabs);

[ete] = mixgaussian(X,xl,Y,yl,k,alpha);

printf("\n  alpha te-err");
printf("\n------- ------\n");
printf("%.1e %6.3f\n",alpha,ete);
