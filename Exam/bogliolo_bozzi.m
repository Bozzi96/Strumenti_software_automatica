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

% k=1
fprintf("k=1\n\t");
Ak1 = sys_k1.A; Bk1 = sys_k1.B; Ck1 = sys_k1.C;
stab_k1 = isstable(sys_k1);
poles_k1 = eig(Ak1);
contr_k1 = rank(ctrb(Ak1,Bk1)) == max(size(Ak1));
obsv_k1 = rank(obsv(Ak1,Ck1)) == max(size(Ak1));
if stab_k1
    fprintf("Sistema stabile\n\t");
end
if contr_k1
    fprintf("Sistema controllabile\n\t");
end
if obsv_k1
    fprintf("Sistema osservabile\n");
end
% k=3/2
fprintf("k=3/2\n\t");
Ak32 = sys_k32.A; Bk32 = sys_k32.B; Ck32 = sys_k32.C;
stab_k32 = isstable(sys_k32);
poles_k32 = eig(Ak32);
contr_k32 = rank(ctrb(Ak32,Bk32)) == max(size(Ak32));
obsv_k32 = rank(obsv(Ak32,Ck32)) == max(size(Ak32));
if stab_k32
    fprintf("Sistema stabile\n\t");
end
if contr_k32
    fprintf("Sistema controllabile\n\t");
end
if obsv_k32
    fprintf("Sistema osservabile\n");
end

% k=2;
fprintf("k=2\n\t");
Ak2 = sys_k2.A; Bk2 = sys_k2.B; Ck2 = sys_k2.C;
stab_k2 = isstable(sys_k2);
poles_k2 = eig(Ak2);
contr_k2 = rank(ctrb(Ak2,Bk2)) == max(size(Ak2));
obsv_k2 = rank(obsv(Ak2,Ck2)) == max(size(Ak2));
if stab_k2
    fprintf("Sistema stabile\n\t");
end
if contr_k2
    fprintf("Sistema controllabile\n\t");
end
if obsv_k2
    fprintf("Sistema osservabile\n");
end

%% Per k=1 plotto risposta all'impulso e verifico la validità del teorema del valor iniziale

[y,t] = impulse(sys_k1);
plot(t,y);
% Lunga divisione
[num,den] = tfdata(sys_k1,'v');
long_div = ldiv(num,den,4)
% Verifica della validità del teorema del valor iniziale
f0 = y(1)
f0dot = (y(2)-y(1))/(t(2)-t(1))

