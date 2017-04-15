function [] = block_pplot(a_grid,b_grid,T,theory,str)
a_range = a_grid(:,1)';
b_range = b_grid(1,:);
Na = length(a_range);
figure('Name',str);
imagesc(a_range,b_range,T')
set(gca,'YDir','normal')
colormap gray
colorbar
axis square
hold on;
if ~isempty(theory)
    plot3(a_range,theory,1.1*ones(1,Na),'r','LineWidth',3)
end
axis([min(a_range) max(a_range) min(b_range) max(b_range)]);
set(gca,'FontSize',24);
xlabel('\alpha','FontSize',36)
ylabel('\beta','FontSize',36)
