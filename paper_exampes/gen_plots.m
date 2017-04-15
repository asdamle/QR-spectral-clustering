%% plotting
a_range = a_grid(:,1)';
b_range = b_grid(1,:);
p_range = p_grid(:,1)';
q_range = q_grid(1,:);
Na = length(a_range);
Nb = length(b_range);

if k == 2
    theory_line = a_range + 2 - sqrt(8*a_range);
    corrected_theory = [];
else
    theory_line = (sqrt(a_range)-1).^2;
    corrected_theory = [];
end


if length(m) > 1
   theory_line = []; 
   corrected_theory = [];
end

%%
block_pplot(a_grid,b_grid,success,theory_line,'QR Normalized')
hold on
if ~isempty(corrected_theory)
    plot3(a_range,corrected_theory,1.1*ones(1,Na),'--b','LineWidth',3)
end
fname = [num2str(k) '_block_normalized.pdf'];
save2pdf(fname,gcf,600);
%%
block_pplot(a_grid,b_grid,success2,theory_line,'QR A')
if ~isempty(corrected_theory)
    plot3(a_range,corrected_theory,1.1*ones(1,Na),'--b','LineWidth',3)
end
fname = [num2str(k) '_block_A.pdf'];
save2pdf(fname,gcf,600);
%%
block_pplot(a_grid,b_grid,fiedler,theory_line,'K-means++')
if ~isempty(corrected_theory)
    plot3(a_range,corrected_theory,1.1*ones(1,Na),'--b','LineWidth',3)
end
fname = [num2str(k) '_block_kmeans.pdf'];
save2pdf(fname,gcf,600);
%%
block_pplot(a_grid,b_grid,qr_kmeans,theory_line,'CPQR seeded K-means')
if ~isempty(corrected_theory)
    plot3(a_range,corrected_theory,1.1*ones(1,Na),'--b','LineWidth',3)
end
fname = [num2str(k) '_block_QRkmeans.pdf'];
save2pdf(fname,gcf,600);
%%
block_pplot(a_grid,b_grid,comp_true,theory_line,'Cut metric better than truth')
if ~isempty(corrected_theory)
    plot3(a_range,corrected_theory,1.1*ones(1,Na),'--b','LineWidth',3)
end
fname = [num2str(k) '_block_comp_true.pdf'];
save2pdf(fname,gcf,600);
%%
block_pplot(a_grid,b_grid,MLE,theory_line,'MLE better than truth')
if ~isempty(corrected_theory)
    plot3(a_range,corrected_theory,1.1*ones(1,Na),'--b','LineWidth',3)
end
fname = [num2str(k) '_block_mle.pdf'];
save2pdf(fname,gcf,600);
