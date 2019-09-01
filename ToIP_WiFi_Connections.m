%% Cálculo de cantidad de conversaciones de ToIP que se pueden establecer en un determinado ancho de banda para WiFi

clear all;
%% Constantes

difs=52e-6;
sifs=10e-6;
slot=15.5; % Backoff media 15,5 slots
cp_media=20e-6*slot; 
preamb=96e-6; % Corto, 2Mbps
%preamb=192e-6; % Largo, 1Mbps
bw_max=54e6;
g729=10e-3;
m=2;
ip=20;
udp=8;
rtp=12;
mac_wifi=34;

%% Cálculos

for i=1:bw_max
    bw(i)=i;
end

for i=1:length(bw)
    l=(m*10+ip+udp+rtp+mac_wifi)*8; % Longitud del paquete en bits
    t_ack(i)=(14*(8/bw(i)))+preamb;
    t_ack_media(i)=cp_media+difs+sifs+t_ack(i); % Tiempo de ACK medio sin coliciones
    num_ow(i)=m*g729/(t_ack_media(i)+preamb+(l/bw(i))); % Número de conexiones en un sentido
    num_rt(i)=m*g729/(2*(t_ack_media(i)+preamb+(l/bw(i)))); % Número de conexiones bidireccionales
end

figure(1);plot(bw,num_rt,'b',bw,num_ow,'r')
figure(1);xlabel('Ancho de banda (bps)')
figure(1);ylabel('Número de conecxiones')
%figure(1);title('Cantidad de conexiones de VoIP para un enlace WiFi en modo ad-hoc en función del ancho de banda del canal')
figure(1);legend('Round trip','One way')
