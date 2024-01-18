%% Generation of block bootstrap time series%%% INPUT% X: matrix N x M, N=nsamples, M=number of series; block bootstrap is the same for all the M series% chunklength=round(nsamples/k): length of the blocks, play with the value k% nboot: number of iterations (to build bootstrap distributions)%%% OUTPUT% X_boot: bootstrap time seriesfunction X_boot = sir_block_bootstrap(X,chunklength,nboot)    [n] = size(X,1); % length of the time series    X_boot = cell(1,nboot); % init    for i = 1:nboot        idx = zeros(n,1);        indstart = randsample(n-chunklength+1,n,1);        nchunks = floor(n/chunklength);        indstart = indstart(1:nchunks);        for istart = 1:nchunks            idx(1+(istart-1)*chunklength:istart*chunklength) = ...                indstart(istart):indstart(istart)+chunklength-1;        end        % last elements are zero if n is not a multiple of chuncklength;        % fill the gap:        nullpos=find(idx==0);        if ~isempty(nullpos)            l_nullpos=length(nullpos);            for ii = 1:l_nullpos                idx(nullpos(ii)) = indstart(end)+ii;            end        end        X_boot{i}=X(idx,:);    end   end