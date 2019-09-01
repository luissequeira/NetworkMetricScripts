%% Cálculo de cantidad de conversaciones de ToIP que se pueden establecer en un determinado ancho de banda para WiFi

clear all;
%% Constantes

difs=52e-6;
sifs=10e-6;
slot=0; % Backoff media 15,5 slots
cp_media=20e-6*slot; 
preamb=96e-6; % Corto, 2Mbps
%preamb=192e-6; % Largo, 1Mbps
bw=54e6;
g729=10e-3;
m=30;
ip=20;
udp=8;
rtp=12;
mac_wifi=34;

%% Cálculos

l=(m*10+ip+udp+rtp+mac_wifi)*8; % Longitud del paquete en bits
t_ack=(14*8/bw)+preamb;
t_ack_media=cp_media+difs+sifs+t_ack; % Tiempo de ACK medio sin coliciones
num_ow=m*g729/(t_ack_media+preamb+(l/bw)) % Número de conexiones en un sentido
num_rt=m*g729/(2*(t_ack_media+preamb+(l/bw))) % Número de conexiones bidireccionales
