#!/usr/bin/octave -qf

if (nargin!=6)
printf("Usage: gaussian-exp.m <trdata> <trlabels> <C> <D> <%%trper> <%%dvper>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
C=str2num(arg_list{3});
D = str2num(arg_list{4});
trper=str2num(arg_list{5});
dvper=str2num(arg_list{6});

load(trdata);
load(trlabs);

N=rows(X);
seed=23; rand("seed",seed); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);


addpath("svm_apr");
printf("\n c 	d	 err");
printf("\n------- ------- -------\n");
for d = D
	for c = C
		param = ['-t ','1 ', '-d ', num2str(d) ' -c ',num2str(c) ,' -q'];
		res = svmtrain(xltr,Xtr, param)
		clas = svmpredict(xldv,Xdv,res,'-q');
		err =  1 - mean(clas == xldv);
		printf("%6.3f %6.3f %6.3f\n", c, d, err);
	end
end


