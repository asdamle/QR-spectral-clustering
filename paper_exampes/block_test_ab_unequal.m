clear
close all
clc
rng(1)
k = 7;
m =  [70 80 90 100 110 120 130];
n = sum(m);
Na = 80;
Nb = 40;
success = zeros(Na,Nb);
success2 = zeros(Na,Nb);
qr_kmeans = zeros(Na,Nb);
fiedler = zeros(Na,Nb);
MLE = zeros(Na,Nb);
theory = zeros(Na,Nb);
comp_true = zeros(Na,Nb);
a_grid =  zeros(Na,Nb);
b_grid =  zeros(Na,Nb);
p_grid =  zeros(Na,Nb);
q_grid =  zeros(Na,Nb);
a_range = linspace(2,20,Na);
b_range = linspace(1,10,Nb);

noise = 0;

trials = 50;
for t = 1:trials
    t
    a_count = 0;
    for a = a_range
        a_count = a_count+1;
        b_count = 0;
        for b = b_range
            b_count = b_count+1;
            
            p = a*log(m(1))/m(1);
            q = b*log(m(1))/m(1);
           
            % only when this makes sense (just for testing faster)
            if p > q
                valid = 0;
                while ~valid
                    A = tril(rand(n) < q);
                    truth = [];
                    idx_start = 1;
                    for j = 1:k;
                        idx_end = idx_start + m(j)-1;
                        idx = idx_start:idx_end;                
                        A(idx,idx) = tril(rand(m(j)) < p);
                        truth = [truth j*ones(1,m(j))];
                        idx_start = idx_end+1;
                    end
                 
                    A = A + A';
                    
                    if noise > 0
                        An = tril(rand(n)<noise);
                        An = An + An';
                        A(A==0) = An(A==0);
                    end
                    
                    
                    A = A - diag(diag(A));
                    
                    
                    
                    d = sum(A);
                    if min(d) > 0
                        valid = 1;
                    end
                end
                
                D = diag(d);
                Ds = diag(sqrt(1./d));
                Lhat = Ds*A*Ds;

                
                [V e] = eigs(Lhat,k);
                
                if norm(V'*V - eye(k)) > 1e-12
                    disp('eigs issue');
                    [V e] = eig(Lhat);
                    V = V(:,n-k+1:end);
                end
                
                [Vloc piv] = lrcol_rand(V,k,1,5);
                [throw, set] = max(abs(Vloc'));
                if verify_true(set,truth)
                    success(a_count,b_count) = success(a_count,b_count)+1;
                end
                
                %seed kmeans with the localization clusters
                Cqr = zeros(k,k);
                for i = 1:k
                    Cqr(i,:) = sum(Vloc(set==i,:))/sum(set==i);
                end
                F = kmeans(Vloc,k,'Start',Cqr);
                if verify_true(F',truth)
                    qr_kmeans(a_count,b_count) = qr_kmeans(a_count,b_count)+1;
                end
                
                
                % this only makes sense in the two block case, Fiedler
                % vector test
                if k == 2
                    F = V(:,2);
                    F(F>=0) = 1;
                    F(F<0) = 2;
                    if verify_true(F',truth)
                        fiedler(a_count,b_count) = fiedler(a_count,b_count)+1;
                    end
                else
                    F = kmeans(V,k);
                    if verify_true(F',truth)
                        fiedler(a_count,b_count) = fiedler(a_count,b_count)+1;
                    end
                end
                
                
                [V e] = eigs(A,k);
                if norm(V'*V - eye(k)) > 1e-12
                    disp('eigs issue');
                    [V e] = eig(A);
                    V = V(:,n-k+1:end);
                end
                
                [Vloc piv] = lrcol_rand(V,k,1,5);
                [throw, set] = max(abs(Vloc'));
                if verify_true(set,truth)
                    success2(a_count,b_count) = success2(a_count,b_count)+1;
                end
                
                if max(comp_cut(A,set)) <= max(comp_cut(A,truth))
                    comp_true(a_count,b_count) = comp_true(a_count,b_count) + 1;
                end
                if comp_mle(A,set) >= comp_mle(A,truth)
                    MLE(a_count,b_count) = MLE(a_count,b_count) + 1;
                end
                
                
            end
            a_grid(a_count,b_count) = a;
            b_grid(a_count,b_count) = b;
            p_grid(a_count,b_count) = p;
            q_grid(a_count,b_count) = q;
            if k == 2
                theory(a_count,b_count) = (a+b)/2-sqrt(a*b);
            else
                theory(a_count,b_count) = sqrt(a)-sqrt(b);
            end
 
        end
    end
end
success = success/trials;
success2 = success2/trials;
fiedler = fiedler/trials;
qr_kmeans = qr_kmeans/trials;
comp_true = comp_true/trials;
MLE = MLE/trials;
theory(theory<1) = 0;
theory(theory>1) = 1;

save backup_block_test_unequal.mat a_grid b_grid success fiedler success2 qr_kmeans theory qr_kmeans p_grid q_grid k m n trials comp_true MLE
fname = [num2str(k) '_block_test_unequal.mat'];
save(fname,'a_grid','b_grid','success','fiedler','comp_true','MLE',...
    'success2','qr_kmeans','theory','qr_kmeans','p_grid','q_grid','k','m','n','trials');

