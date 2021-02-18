#!/usr/bin/octave -qf

if (nargin!=7)
printf("Usage: svm-exp.m <trdata> <trlabels> <C> <T> <D> <%%trper> <%%dvper>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
C=str2num(arg_list{3});
T=str2num(arg_list{4});
D=str2num(arg_list{5});
trper=str2num(arg_list{6});
dvper=str2num(arg_list{7});

load(trdata);
load(trlabs);

N=rows(X);
seed=23; rand("seed",seed); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

for c = C
	for t = T
        for d = D
            ar = ['-t ',num2str(t),' -c ', num2str(c),' -d ', num2str(d), ' -q']
            svm = svmtrain(xltr,Xtr,ar);
            cl = svmpredict(xldv,Xdv,svm,'-q');
            edv =  1 - mean(cl == xldv);
            d
            c
            edv
        endfor
    endfor
endfor