function [S,D] = decomSymplect (F)
% input: SPD matrix
% output: S - Symplectic eigenvectors 
%         D - Symplectic eigenvalues 

% form the canonical symplectic matrix J     
[N , ~] = size(F); % square matrix, N is even number 
n = N/2;
J = [zeros(n) eye(n) ;...
    -eye(n)  zeros(n)]; 

% form skew-symmetric matrix Mt
M = F;
Ms = sqrtm(M); % sqrt of the matrix 
Mt = Ms*J*Ms; 

% Schur decomposition 
[K,T] = schur(Mt);   % Q is orthogonal, T contains eigenvalues 

% form permutation matrix 
I = eye(N);
P = [I(:,1:2:2*n-1) I(:,2:2:2*n)]; 

% reshuffle the eigenvalue matrix 
D2 = P.'*T*P; 
D = abs(D2(1:n,n+1:2*n)); % diagonal

% form the symplectic matrix S
B = [zeros(n) -inv(sqrtm(D)) ; ...
    inv(sqrtm(D)) zeros(n)];
S = J*Ms*K*P*B;

% check that S is symplectic eigenvectors of F
% S'*J*S = J % symplecity 
% S'*F*S = D % diagonal 
