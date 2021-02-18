function edv=mlp(Xtr,xltr,Xdv,xldv,Y,yl,nHiddens,epochs,show,seed)
	initNN = newff (minmax(Xtr),[nHiddens numel(unique(xl))],{"tansig","logsig"},"trainlm","","mse");
	initNN.trainParam.show = show;
	initNN.trainParam.epochs = epochs;
	
	[Xtrnorm,Xtrmean,Xtrstd] = prestd(Xtr);
	XdvNN.P = trastd(Xdv,Xtrmean,Xtrstd);
	XdvNN.T = onehot(xldv);
	
	rand("seed", seed);
	NN = train(initNN,Xtrnorm,onehot(xltr),[],[],XdvNN);
	Ynorm = trastd(Y,Xtrmean,Xtrstd);
	Yout = sim(NN,Ynorm);
	
	[prob, Yout] = max(Yout);
	edv = sum(Yout==yl);
end