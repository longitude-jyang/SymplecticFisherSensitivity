figNo = {'(1) ', '(2) ', '(3) ', '(4) '};
varName=[{'E'},{'\rho'},{'L'},{'w'},{'t'}]';


for ii = 1 : numel(varName)

    labelName{1,ii} = strcat('$$','\mu_',varName{ii},'$$');
    labelName{2,ii} = strcat('$$','\sigma_',varName{ii},'$$');
    tickName{1,ii} = strcat('$$',varName{ii},'$$');
end


%
% re-sort the parameter to pair them togther

for ii = 1 : nPar
   
    V_e_N ( 2*ii - 1  : 2*ii  , :) = V_e ([ii ii + nPar],:);
    Vsp_N ( 2*ii - 1  : 2*ii  , :) = Vsp ([ii ii + nPar],:);

end

%% 
%  plot eigenvalues/vectors

     fig1 = figure;

     for ii = 1 : 2 

         subplot(2,1,ii)

         if ii == 1
             bar([1:nPar*2].',lambda)
    
             ylim_max = max(lambda)+ max(lambda)/10;
             ylim ([0 ylim_max])

             title([figNo{ii}, 'Fisher EigValue'],'Interpreter','latex')

         elseif ii == 2       %  Symplectic eigenvalues/vectors   

             bar([1:nPar].',diag(Dsp))

             ylim_max = max(diag(Dsp)) + max(diag(Dsp))/10;
             ylim ([0 ylim_max])             
             title([figNo{ii}, 'Fisher S-EigValue'],'Interpreter','latex')
             xlabel('Index')
         end

             set(gca,'TickLabelInterpreter','latex','FontSize',18)
             
             ax = gca;
             ax.TitleHorizontalAlignment = 'left'; 

     end

    figuresize(16, 12, 'centimeters');
    movegui(fig1, [50 40])
    set(gcf, 'Color', 'w');

%%
% plot eigenvectors
     fig2 = figure;
     for ii = 1 : 4
        subplot(4,1,ii)
         b=bar([1:nPar*2]',V_e_N(:,ii));      
         
         if ii <= 3
             set(gca,'xtick',[],'TickLabelInterpreter','latex','FontSize',18);
         else
             set(gca,'xtick',[1:2:nPar*2-1]/2 + [2:2:nPar*2]/2,'xticklabel',tickName,'TickLabelInterpreter','latex','FontSize',18);
         end

         xtips = b.XData;
         ytips = b.YData;
         ytips = ytips.*double(ytips>0);
         labels = reshape(labelName,nPar*2,1);
         text(xtips,ytips,labels,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom','FontSize',16,'Interpreter','latex')


         ylim_range = max(V_e_N(:,ii)) - min(V_e_N(:,ii));
         ylim_min = min(V_e_N(:,ii)) - ylim_range/5;
         ylim_max = max(V_e_N(:,ii)) + ylim_range/5;
         ylim ([ylim_min ylim_max])


         title([figNo{ii}, 'EigVector ','[$$ \lambda_',num2str(ii),'$$','=',num2str(round(lambda(ii)*10)/10,'% 1.1e'),']'],...
             'Interpreter','latex','FontSize',16)
         ax = gca;
         ax.TitleHorizontalAlignment = 'left'; 

     end

        ha=get(gcf,'children');
        for ii = 1 : 4
            set(ha(ii),'position',[.1 .1 + 0.22*(ii - 1) .8 .17])  % four-element vector of the form [left bottom width height].
        end

        figuresize(18, 28, 'centimeters');
        movegui(fig2, [50 20])
        set(gcf, 'Color', 'w');


%%
% plot Symplectic Eigenvectors
     fig3 = figure;
     
     index = [0  nPar  1  nPar+1];
     strT  = [{'u1'};  {'v1'}; {'u2' };{'v2'} ];
     for ii = 1 : 4
                  
         subplot(4,1,ii)
         b=bar([1:nPar*2]',Vsp_N(:,1 + index(ii)));  
         
         if ii <= 3
             set(gca,'xtick',[],'TickLabelInterpreter','latex','FontSize',18);
         else
             set(gca,'xtick',[1:2:nPar*2-1]/2 + [2:2:nPar*2]/2,'xticklabel',[tickName],'TickLabelInterpreter','latex','FontSize',18);
         end

         xtips = b.XData;
         ytips = b.YData;
         ytips = ytips.*double(ytips>0);
         labels = reshape(labelName,nPar*2,1);
         text(xtips,ytips,labels,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom','FontSize',16,'Interpreter','latex')        
         

         ylim_range = max(Vsp_N(:,1 + index(ii))) - min(Vsp_N(:,1 + index(ii)));
         ylim_min = min(Vsp_N(:,1 + index(ii))) - ylim_range/5;
         ylim_max = max(Vsp_N(:,1 + index(ii))) + ylim_range/5;
         ylim ([ylim_min ylim_max])

         if ii == 1 || ii == 2
             title([figNo{ii},'S-EigVector-','$$ \mathbf{', strT{ii},'}','[d_1','$$','=',num2str(round(d_sp(1)*10)/10,'% 1.1e'),']'],...
                 'Interpreter','latex','FontSize',16)
         elseif ii == 3 || ii == 4
             title([figNo{ii},'S-EigVector-','$$ \mathbf{', strT{ii},'}','[d_2','$$','=',num2str(round(d_sp(2)*10)/10,'% 1.1e'),']'],...
                 'Interpreter','latex','FontSize',16)
         end

         ax = gca;
         ax.TitleHorizontalAlignment = 'left'; 
     end

        ha=get(gcf,'children');
        for ii = 1 : 4
            set(ha(ii),'position',[.1 .1 + 0.22*(ii - 1) .8 .165])  % four-element vector of the form [left bottom width height].
        end

        figuresize(18, 28, 'centimeters');
        movegui(fig3, [50 20])
        set(gcf, 'Color', 'w');