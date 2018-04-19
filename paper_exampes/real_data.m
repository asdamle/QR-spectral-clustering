clear
close all
clc

%seed for eigs
%From SNAP ca-AstroPh, largest connected component
%Citation: LESKOVEC, J. & KREVL, A. (2014) SNAP Datasets: Stanford Large Network Dataset Collection.
fname = 'AstroPh_connected.mat';
load(fname);
A = Ac;
k = 6;

n = size(A,1);
d = full(sum(A));
D = spdiags(1./sqrt(d'),0,n,n);
L = D*A*D;
[V, E] = eigs(L,k+5,'LA');
V = V(:,1:k);
e = diag(E);


%% 
rng(1)
trials = 50;
for j = 1:trials
    [Ik, Ck] = kmeans(V,k);
    Kd(j) = sum(comp_dist(V,Ik,Ck));
    Kc(j) = max(comp_cut(A,Ik));
end

U = lrcol(V,k,1);
[t, Iqr] = max(abs(U'));
QRd = sum(comp_dist(V,Iqr,[]));
QRc = max(comp_cut(A,Iqr));

% compute centers from QR based algorithm
Cqr = zeros(k,k);
for i = 1:k
    Cqr(i,:) = sum(V(Iqr==i,:))/sum(Iqr==i);
end

[Ikqr, Ckqr] = kmeans(V,k,'Start',Cqr);
KQRd = sum(comp_dist(V,Ikqr,[]));
KQRc = max(comp_cut(A,Ikqr));

% save RealData_cluster.mat Kd Kc QRd QRc KQRd KQRc k e fname

%% metric
disp('kmeans means')
[mean(Kd) mean(Kc)]

disp('kmeans medians')
[median(Kd) median(Kc)]

disp('kmeans min')
[min(Kd) min(Kc)]

disp('kmeans max')
[max(Kd) max(Kc)]

disp('QR metrics')
[QRd QRc]

disp('QR + kmeans metrics')
[KQRd KQRc]