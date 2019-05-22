%% Ottengo i sistemi in equazioni di stato
% Suppongo di avere la variabile linsys1 nel sistema
if exist('linsys1') == 1
    sys_k1 = linsys1(:,:,1)
    sys_k32 = linsys1(:,:,2)
    sys_k2 = linsys1(:,:,3)
else
    % Suppongo di avere solo il file simulink
    clear;clc;
    % Creo i tre sistemi, con k=1; 3/2; 2
    k=1;
    sys_k1 = linearize("bogliolo_bozzi_simulink");
    k=3/2;
    sys_k32 = linearize("bogliolo_bozzi_simulink");
    k=2;
    sys_k2 = linearize("bogliolo_bozzi_simulink");
 end

%% Ottengo le funzioni di trasferimento
zpk_k1 = zpk(sys_k1);
zpk_k32 = zpk(sys_k32);
zpk_k2 = zpk(sys_k2);


%% Verifico stabilità, controllabilità, osservabilità per ognuno di essi
%%%%%%%%%TODO
