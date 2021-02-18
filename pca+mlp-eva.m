#!/usr/bin/octave -qf

if (nargin!=8)
printf("Usage: mixgaussian-exp.m <trdata> <trlabels> <nHiddens> <k> <%%trper> <%%dvper>  <trdataY> <trlabelsY>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
nHiddens=str2num(arg_list{3});
k=str2num(arg_list{4});
trper=str2num(arg_list{5});
dvper=str2num(arg_list{6});
trdatay=str2num(arg_list{7});
trlabesy=str2num(arg_list{8});

load(trdata);
load(trlabs);
load(trdatay);
load(trlabelsy);

N=rows(X);
seed=23; rand("seed",seed); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

printf("\n  alpha dv-err");
printf("\n------- ------\n");
show=10;
seed=300;
[m,W]=pca(Xtr);
Xtrp=(Xtr-m)*W(:,1:k);
Xdvp=(Xdv-m)*W(:,1:k);
edv = mlp(Xtrp,xltr,Xdvp,xldv,Y,yl,nHiddens,epochs,show,seed);
printf("%3d %6.3f\n",nHiddens,edv);
