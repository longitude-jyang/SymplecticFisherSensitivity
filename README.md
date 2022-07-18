# SymplecticFisherSensitivity
a symplectic variant of the eigenvalue decomposition for the Fisher information matrix and extract the sensitivity information with respect to two-parameter conjugate pairs

## Abstract 
The eigenvalues and eigenvectors of the Fisher information matrix (FIM) can reveal the most and
least sensitive directions of a system and it has wide application across science and engineering. We
present a symplectic variant of the eigenvalue decomposition for the FIM and extract the sensitivity
information with respect to two-parameter conjugate pairs. The symplectic approach decomposes
the FIM onto an even dimensional symplectic basis. This symplectic structure can reveal additional
sensitivity information between two-parameter pairs, otherwise concealed in the orthogonal basis from
the standard eigenvalue decomposition. The proposed sensitivity approach can be applied to natural
paired two-parameter distribution parameters, or decision-oriented pairing via a re-parameterization of
the FIM. It can be utilised in tandem with the standard eigenvalue decomposition and offer additional
insight into the sensitivity analysis at negligible extra cost.

## Method 
Consider a general function $\bf y=h(x)$, the probabilistic sensitivity analysis characterise the uncertainties of the output $\bf y$ that is induced by the random input $\bf x$. When the input can be described by parametric probability distributions, i.e., $x \sim p(\mathbf{x|b})$, the FIM can then be estimated as the variance of the random gradient vector ${\partial p(\mathbf{y|b})}/{\partial \mathbf b}$, with the $jk^{\text{th}}$ entry of the Fisher Information Matrix (FIM) as:

$F_{jk}=\int \frac {\partial p(\mathbf{y|b})}{\partial b_j} \frac {\partial p(\mathbf{y|b})}{\partial b_k} \frac {1}{p} d\mathbf y = \mathbb E_Y\left[ \frac { b_j\partial \ln p}{\partial b_j} \frac {b_k\partial \ln p}{\partial b_k} \right]$

The eigenvalues of the FIM represent the magnitudes of the sensitivities with respect to simultaneous variations of the parameters $\mathbf{b}$, and the relative magnitudes and directions of the variations are given by the corresponding eigenvectors.  In this paper, we propose a new approach using the symplectic decomposition to extract the Fisher sensitivity information. The symplectic decomposition utilises Williamson’s theorem which is a key theorem in Gaussian quantum information theory. Originated from Hamiltonian mechanics, the symplectic transformations preserve Hamilton’s equations in phase space. In analogy to the conjugate coordinates for the phase space, i.e. position and momentum, we regard the input parameters as conjugate pairs and use symplectic matrix for the decomposition of the Fisher information matrix (FIM). The resulted symplectic eigenvalues of large magnitude, and the corresponding symplectic eigenvectors of the FIM, then reveal the most sensitive two-parameter pairs. 

The Williamson’s theorem provides us with a symplectic variant of the standard eigenvalue decomposition. Let $\mathbf{F \in \mathbb{R}^{2n \times 2n}}$ be a symmetric and positive definite matrix, the Williamson’s theorem says that $\mathbf{F}$ can be diagonalized using symplectic matrices: 
 
$\bf S^{\mathsf{T}}FS = \hat{D} = \text{diag} ( \mathbf{D},  \mathbf{D})$
  
where $\mathbf{D} = \text{diag}(d_1,d_2,\dots,d_n)$ is a diagonal matrix with positive entries ($d_j$ maybe zero if $\mathbf{F}$ is semidefinite). The $d_j, \: j=1,2,\dots,n$ are said to be the symplectic eigenvalues of matrix $\mathbf{F}$. The symplectic eigenvectors cannot be solved using the standard eigenvalue algorithms directly. One approach uses the Schur form of skew-symmetric matrices and this is coded in the script [decomSymplect.m](/code/decomSymplect.m). 

## Example
A numerical example with a cantilever beam subject to a white noise excitation is considered. It is assumed that five input variables are random, $\mathbf{x} =(E,\rho,L,w,t)$, and can be described by Normal distributions, $\mathbf{b} = (\mu_m,\: \sigma_m ), \: m=1,2,\dots,5$.
<img src="doc/beam.png" width="500">

## The code
To implement the numerical case studies, you need to download the sensitivity code of [TEDS](/../../../../longitude-jyang/TEDS-ToolboxEngineeringDesignSensitivity) from a different repository. The main code to reproduce the paper results is the [cal_cb_symplectic.m](/code/cal_cb_symplectic.m) which calls TEDS for forming the FIM. 
