%% Lista 01
% Mestrado em Automação e Controle de Processos
% Aluno: Bruno Godoi Eilliar
% Prontuário: 1580825
% Disciplina: Tópicos de Controle
% Professor: Alexandre Brincalepe Campo
% Data: 01/12/2015
% Notas:


%% Exercício 01
clc
close all; clear all;
% a) 
disp('Item a:');
Ti = .1;
G = tf([Ti 1], [Ti 0])

pol1 = [1 20 101];
pol2 = [1 2 2];
denF = conv(pol1, pol2);
F = tf([10], denF)

% Malha Fechada
GF = series(G, F)
figure;
pzmap(GF);
title('a) Poles-Zeros for Gc(s)F(s)')

Kp = 0:.1:10000;
figure;
rlocus(feedback(GF, 1), Kp);    %Dúvida: GF ou feedback(GF,1) ?
title('a) Root Locus for Gc(s)F(s)');

% b)
disp('Item b:');
num2 = conv([1 20], [1 20]);
den2 = conv([1 200], [1 200]);
G2 = tf(num2, den2)

GGF = series(G2, GF)
figure;
pzmap(feedback(GGF, 1));
title('b) Poles-Zeros for Gc2(s)Gc(s)F(s)');

figure;
rlocus(GGF);    % Dúvida: GGF ou feedback(GGF,1) ?
title('b) Root Locus for Gc2(s)Gc(s)F(s)');

% c)
disp('Item c:');
figure;hold on;
for k = 1: 5: 50
    MF = feedback(k*GGF, 1);
    step(MF, 250);
end
grid on;