%% Lista 02
% Mestrado em Automação e Controle de Processos
% Aluno: Bruno Godoi Eilliar
% Prontuário: 1580825
% Disciplina: Tópicos de Controle
% Professor: Alexandre Brincalepe Campo
% Data: 01/12/2015
% Notas:


%% Exercício 01
clc
close all
clear all

num1 = [1 2]; 
den1 = [1 2 1 0];
disp('Sistema: ');
sys1 = tf(num1, den1)
[A, B, C, D] = tf2ss(num1, den1);

disp('Pólos Desejados: ');
p = [-20 -1-i -1+i]
disp('Ganhos (place): ')
K = place(A,B,p)

disp('Ganhos (ackerman): ');
Kack = acker(A, B, p)

% Malha fechada
sys1_cl = ss(A-B*K,B,C,0);
% Simular degrau unitários
figure;
step(sys1_cl)
xlabel('Tempo'); ylabel('Output'); 
title('Reposta ao Degrau Unitário - SEM ajuste de ganho');

% Ajuste de ganho
[Nbar] = rscale(A,B,C,D,K);
figure;
step(Nbar*sys1_cl)
xlabel('Tempo'); ylabel('Output'); 
title('Reposta ao Degrau Unitário - COM ajuste de ganho');

%% Exercício 02
clc
clear all; close all;

A = [0 1; 0 -5];
B = [0 1]';
C = [2 1];
D = 0;

sys2 = ss(A,B,C,D)

% Controlabilidade
Co2 = ctrb(A, B)

if (rank(Co2) == 2)
    disp('O sistema é Controlável. Possui rank(Co2) = 2');
else
    disp('O sistema não é Controlável. Possui rank(Co2) != 2');
end

% Observabilidade
Ob2 = obsv(A, C)

if (rank(Ob2) == 2)
    disp('O sistema é Observável. Possui rank(Ob2) = 2');
else
    disp('O sistema não é Observável. Possui rank(Ob2) != 2');
end

%% Exercício 03
clc
clear all; close all;
A1 = [0 1; -2 -3]; B1 = [0 1]'; C1 = [3 1]; D1 = 0;
A2 = [0 -2; 1 -3]; B2 = [3 1]'; C2 = [0 1]; D2 = 0;
A3 = [-1 0; 0 -2]; B3 = [1 1]'; C3 = [2 -1]; D3 = 0;
% a) Autovalores
disp('Autovalores de 1: ')
auto1 = eig(A1)
disp('Autovalores de 2: ')
auto2 = eig(A2)
disp('Autovalores de 3: ')
auto3 = eig(A3)

% Função de Transferência
disp('Função de transferência de 1:');
[num1, den1] = ss2tf(A1, B1, C1, D1);
tf1 = tf(num1, den1)
disp('Função de transferência de 2:');
[num2, den2] = ss2tf(A2, B2, C2, D2);
tf2 = tf(num2, den2)
disp('Função de transferência de 3:')
[num3, den3] = ss2tf(A3, B3, C3, D3);
tf3 = tf(num3, den3)

%% Exercício 04
clc
clear all; close all;
A = [0 1 0; 0 0 1; 0 2 -1];
B = [0 1; 1 0; 0 0];
C = [1 0 1];
D = 0;

sys4 = ss(A, B, C, D)

% a) Controlabilidade
Co4 = ctrb(A, B)
if (rank(Co4) == 3)
    disp('O sistema é Controlável. Possui rank(Co2) = 3');
else
    disp('O sistema não é Controlável. Possui rank(Co2) != 3');
end

% b) Observabilidade
Ob4 = obsv(A, C)

if (rank(Ob4) == 3)
    disp('O sistema é Observável. Possui rank(Ob2) = 3');
else
    disp('O sistema não é Observável. Possui rank(Ob2) != 3');
end

% c) Pólos do Sistema
disp('Pólos do Sistema (Autovalores de A):');
polos4 = eig(A)

% d) Funções de Transferência do Sistema
disp('FT para 1ª entrada:');
[num4_1,den4_1] = ss2tf(sys4.A, sys4.B, sys4.C, sys4.D, 1);
transferFunction1 = tf(num4_1, den4_1)
disp('FT para 2ª entrada: ');
[num4_2,den4_2] = ss2tf(sys4.A, sys4.B, sys4.C, sys4.D, 2);
transferFunction2 = tf(num4_2, den4_2)

%% Exercício 05
clc
clear all; close all;

A = [2 3; -2 -5];
B = [0 2]';
C = [3 1];
D = 0;

sys5 = ss(A, B, C, D);
[num5, den5] = ss2tf(sys5.A, sys5.B, sys5.C, sys5.D);
sys5_tf = 2*tf(num5, den5)

closed_sys5 = feedback(sys5_tf, 1)

disp('Pólos do sistema:')
figure;
pzmap(closed_sys5);

%% Exercício 06
clc
clear all; close all;

A = [2 3; -2 -5]; 
D = 0;
% Controlabilidade
delta = -1: 0.01: 1;
CoRanks = zeros(size(delta));
for d = 1: length(delta)
    B = [0 2+delta(d)]';
    Co = ctrb(A, B);
    CoRanks(d) = rank(Co);
end
figure;
plot(delta, CoRanks, 'o');
title('Análise de Controlabilidade: |delta| <=1');
xlabel('Delta'); ylabel('Rank da matriz de Controlabilidade');

% Observabilidade
gama = -1: 0.01: 1;
ObRanks = zeros(size(gama));
for o = 1: length(delta)
    C = [3+gama(o) 1];
    Ob = obsv(A, C);
    ObRanks(d) = rank(Ob);
end
figure;
plot(gama, ObRanks, 'rs')
title('Análise de Observabildiade: |gama| <=1');
xlabel('Gama'); ylabel('Rank da matriz de Observabilidade');