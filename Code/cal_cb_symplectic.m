% cal_cb_symplectic.m calculates sensitivity to uncertainties using the
% Fisher information matrix (FIM), with both standard eigenvalue and the
% new symplectic decomposition. 
% this code uses a simple cantilever beam as an example 

% the prerequisite: TEDS (https://github.com/longitude-jyang/TEDS-ToolboxEngineeringDesignSensitivity)

% 17/05/2022 @ JD1, Cambridge  [J Yang] 

% --------------------------------------------
% options 

    noCase = 1; 

    Ny = 50;             % length y vector for cdf and pdf estimation 
    isjpdf = 1;          % choose joint pdf or analyse indepenently 
    isNorm = 2;          % choose to normalise Fisher matrix (default == 1 for proportional normalization), 
    %  2 for mean/std normalization,3 for std/std normalization 


    Opts.funName ='design_cb';
    Opts.distType ='Normal';  
%     Opts.distType ='Gamma';  

% -------------------------------------------------------------------------
% (1)    
% -------------------------------------------------------------------------
    varName=[{'$E$'},{'$\rho$'},{'$L$'},{'$w$'},{'$t$'}]';

    RandV.nVar = numel(varName);
    RandV.vNominal =  [69e9 2700 0.45 2e-2 2e-3].';  % E, rho, L, w, t

    switch noCase
        case 1
            RandV.CoV = [1/200 1/80 1/100 1/60 1/80].';
            Opts.nSampMC = 10000;
        case 2
            RandV.CoV = [1/5 1/5 1/30 1/6 1/8].';
            Opts.nSampMC = 20000;
    end 


    [ListPar,parJ] = parList(Opts,RandV,isNorm);
    [nPar, ~] = size(ListPar);                                  % get size
    nS = Opts.nSampMC;                                          % No. of samples

    [xS,ListPar,ParSen] = parSampling (ListPar, nPar,nS);    

% -------------------------------------------------------------------------
% (2)    
% -------------------------------------------------------------------------
% with the generated random samples, evaluate the blackbox function h 

     disp('Monte Carlo Analysis Starts: ...')
     tic;  
     
        h_Results = cal_h (xS, Opts);
        y = h_Results.y;    
        
     elapseTime = floor(toc*100)/100; 
     disp(strcat('Analysis Completed: ',num2str(elapseTime),'[s]'))   
  
% -------------------------------------------------------------------------
% (3)    
% -------------------------------------------------------------------------
% with y, post process for FIM 
% first estimate the pdf of y and then form F matrix     
     disp('Estimating Fisher: ...')
     tic;   

         yjpdf = cal_jpdf_hist (y,xS,Ny);

         % compute fisher matrix (raw)
         Fraw = cal_jFisher (yjpdf,nPar);
         Fraw = Fraw(1:nPar*2,1:nPar*2);  % 3rd/4th parameters are not implemented     

     elapseTime = floor(toc*100)/100; 
     disp(strcat('Fisher EigenAnalysis Completed: ',num2str(elapseTime),'[s]'))

%%
% -------------------------------------------------------------------------
% (3b)  Normalise and get eigenvalues 
% -------------------------------------------------------------------------     

         % re-parameterization and normalization  - transformation 
         Fn = parTran(Fraw, ListPar,parJ,isNorm) ;

         % eigen analysis 
         [V_e,D_e] = eig(Fn); 
                  
         lambda = diag(D_e);
         [EigSorter,EigIndex] = sort(lambda,'descend');
         V_e = V_e(:,EigIndex);
         lambda = lambda(EigIndex);
         D_e = diag(lambda);

         % symplectic analysis
         [Vsp,Dsp] = decomSymplect (Fn);

         d_sp = diag(Dsp);
         [SymSorter,SymIndex] = sort(d_sp,'descend');

         Vsp_1 = Vsp(:,1:nPar);
         Vsp_2 = Vsp(:,nPar + 1 : end);
         Vsp = [Vsp_1(:,SymIndex) Vsp_2(:,SymIndex)];
         d_sp = d_sp(SymIndex);
         Dsp = diag(d_sp);
     


%%
% -------------------------------------------------------------------------
% (4) Display results    
% -------------------------------------------------------------------------


% plot Fisher matrix 
    figure 
    [xx, yy] = ndgrid([1:nPar*2], [1:nPar*2]);
    surf (xx , yy, Fn,'LineStyle','none')
    set(gca,'xtick',1:nPar*2,'xticklabel',[varName varName],'TickLabelInterpreter','latex');
    set(gca,'ytick',1:nPar*2,'yticklabel',[varName varName],'TickLabelInterpreter','latex');
   
    axis xy; axis tight; 
    shading interp
    colormap(flipud(hot)); 
    view(0,90);
    colorbar  

% plot sensitivity information 
    plot_cb_symplectic_paper; 
