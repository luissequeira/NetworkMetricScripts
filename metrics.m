%% Análisis de datos de tráfico

clear all

voz=csvread('voz.csv');
camara_4=csvread('camara_4.csv');
camara_13=csvread('camara_13.csv');
camara_16=csvread('camara_16.csv');
camara_50=csvread('camara_50.csv');
video_streaming=csvread('video_streaming.csv');
umbral_voz=0;
umbral_camara_4=0.032;
umbral_camara_13=0.04;
umbral_camara_16=0.1;
umbral_camara_50=0.1;
%umbral_streaming=;

%% Definir archivo

datos=camara_50;
umbral=umbral_camara_50;

%% Para streaming

% if datos==video_streaming
%     a=1;
%     for i=1:length(datos)
%         if ((datos(i,3)==0) && (datos(i,4)==1))
%             t_enviado(a)=datos(i,2);
%             a=a+1;
%         end
%     end
%     t_paquete_enviado=zeros(size(t_enviado));
%     for i=2: length(t_paquete_enviado)
%         t_paquete_enviado(i)=t_enviado(i)-t_enviado(i-1);
%     end
%     c=1;
%     for i=1:length(t_paquete_enviado)
%         if t_paquete_enviado(i)>umbral
%             t_rafaga_enviado(c)=t_paquete_enviado(i);
%             c=c+1;
%         end    
%     end
%     e=1;
%     for i=2:length(datos)
%         if ((datos(i,3)==0) && (datos(i,4)==1) && ((datos(i,2)-datos(i-1,2))>umbral))
%             tiempo_rafaga_enviado(e)=datos(i,2);
%             e=e+1;
%         end
%     end
%     media_paquetes_enviados=mean(t_paquete_enviado);
%     desviacion_std_paquetes_enviados=std(t_paquete_enviado);
%     media_rafaga_enviado=mean(t_rafaga_enviado);
%     desviacion_sdt_rafaga_enviado=std(t_rafaga_enviado);
%     probabilidad_paquetes_enviados=length(t_enviado)/length(datos)
%     probabilidad_rafagas_enviadas=length(t_rafaga_enviado)/length(t_enviado)
% end
        

%% Separar datos enviados y recibidos

a=1;
b=1;

for i=1:length(datos)
    if ((datos(i,3)==0) && (datos(i,4)==1))
        t_enviado(a)=datos(i,2);
        a=a+1;
    else
        t_recibido(b)=datos(i,2);
        b=b+1;
    end
end

%% Tiempos entre paquetes, medias y desviación

t_paquete_enviado=zeros(size(t_enviado));
t_paquete_recibido=zeros(size(t_recibido));

for i=2: length(t_paquete_enviado)
    t_paquete_enviado(i)=t_enviado(i)-t_enviado(i-1);
end

for i=2: length(t_paquete_recibido)
    t_paquete_recibido(i)=t_recibido(i)-t_recibido(i-1);
end

media_paquetes_enviados=mean(t_paquete_enviado);
media_paquetes_recibidos=mean(t_paquete_recibido);
desviacion_std_paquetes_enviados=std(t_paquete_enviado);
desviacion_std_paquetes_recibidos=std(t_paquete_recibido);

%% Tiempos entre ráfagas, media y desviación

c=1;
d=1;

for i=1:length(t_paquete_enviado)
    if t_paquete_enviado(i)>umbral
        t_rafaga_enviado(c)=t_paquete_enviado(i);
        c=c+1;  
    end    
end

for i=1:length(t_paquete_recibido)
    if t_paquete_recibido(i)>umbral
        t_rafaga_recibido(d)=t_paquete_recibido(i);
        d=d+1;  
    end    
end

media_rafaga_enviado=mean(t_rafaga_enviado);
media_rafaga_recibido=mean(t_rafaga_recibido);
desviacion_sdt_rafaga_enviado=std(t_rafaga_enviado);
desviacion_std_rafaga_recibido=std(t_rafaga_recibido);

%% Tiempo en el que se envió cada ráfaga

e=1;
f=1;

for i=2:length(datos)
    if ((datos(i,3)==0) && (datos(i,4)==1) && ((datos(i,2)-datos(i-1,2))>umbral))
        tiempo_rafaga_enviado(e)=datos(i,2);
        e=e+1;
    else
        if ((datos(i,3)==1) && (datos(i,4)==0) && ((datos(i,2)-datos(i-1,2))>umbral))
            tiempo_rafaga_recibido(f)=datos(i,2);
            f=f+1;
        end
    end
end

%% Resumen estadístico

media_paquetes_enviados
desviacion_std_paquetes_enviados
media_paquetes_recibidos
desviacion_std_paquetes_recibidos

media_rafaga_enviado
desviacion_sdt_rafaga_enviado
media_rafaga_recibido
desviacion_std_rafaga_recibido

probabilidad_paquetes_enviados=length(t_enviado)/length(datos)
probabilidad_paquetes_recibidos=length(t_recibido)/length(datos)
probabilidad_rafagas_enviadas=length(t_rafaga_enviado)/length(t_enviado)
probabilidad_rafagas_recibidas=length(t_rafaga_recibido)/length(t_recibido)


%% Figuras
 
%Voz
% figure(1);plot(t_enviado,t_paquete_enviado,'r',t_recibido,t_paquete_recibido,'b')
% figure(1);xlabel('Tiempo de transmisión (s)')
% figure(1);ylabel('Duración del paquete (s)')
% figure(1);title('Variación del tiempo de paquetes para el tráfico de voz')
% figure(1);legend('Tráfico enviado','Tráfico recibido')
% figure(2);hist(t_paquete_enviado)
% figure(2);xlabel('Duración del paquete (s)')
% figure(2);ylabel('Cantidad de paquetes')
% figure(2);title('Distribusión de paquetes para el tráfico de voz')
% figure(2);legend('Tráfico enviado')
% figure(3);hist(t_paquete_recibido)
% figure(3);xlabel('Duración del paquete (s)')
% figure(3);ylabel('Cantidad de paquetes')
% figure(3);title('Distribusión de paquetes para el tráfico de voz')
% figure(3);legend('Tráfico recibido')
  
% Cámara 50
% figure(1);subplot(2,1,1);plot(t_enviado,t_paquete_enviado,'r',t_recibido,t_paquete_recibido,'b')
% figure(1);subplot(2,1,1);xlabel('Tiempo de transmisión (s)')
% figure(1);subplot(2,1,1);ylabel('Duración del paquete (s)')
% figure(1);subplot(2,1,1);title('Variación de la duración de paquetes')
% figure(1);subplot(2,1,1);legend('Tráfico enviado','Tráfico recibido')
% figure(1);subplot(2,1,2);plot(tiempo_rafaga_enviado,t_rafaga_enviado)
% figure(1);subplot(2,1,2);xlabel('Tiempo de transmisión (s)')
% figure(1);subplot(2,1,2);ylabel('Duración de la ráfaga (s)')
% figure(1);subplot(2,1,2);title('Variación de la duración de ráfagas')
% figure(1);subplot(2,1,2);legend('Tráfico enviado')
% figure(2);subplot(2,1,1);hist(t_paquete_enviado)
% figure(2);subplot(2,1,1);xlabel('Duración del paquete (s)')
% figure(2);subplot(2,1,1);ylabel('Cantidad de paquetes')
% figure(2);subplot(2,1,1);title('Distribusión de paquetes enviados')
% figure(2);subplot(2,1,1);legend('Tráfico enviado')
% figure(2);subplot(2,1,2);hist(t_paquete_recibido)
% figure(2);subplot(2,1,2);xlabel('Duración del paquete (s)')
% figure(2);subplot(2,1,2);ylabel('Cantidad de paquetes')
% figure(2);subplot(2,1,2);title('Distribusión de paquetes recibidos')
% figure(2);subplot(2,1,2);legend('Tráfico recibido')

% Cámara 16
% figure(1);bar(t_enviado,t_paquete_enviado,'r',t_recibido,t_paquete_recibido,'b')
% figure(1);xlabel('Tiempo de transmisión (s)')
% figure(1);ylabel('Duración del paquete (s)')
% figure(1);title('Variación del tiempo de paquetes para el tráfico de cámara_16')
% figure(1);legend('Tráfico enviado','Tráfico recibido')
% figure(2);plot(tiempo_rafaga_enviado,t_rafaga_enviado)
% figure(2);xlabel('Tiempo de transmisión (s)')
% figure(2);ylabel('Duración de la ráfaga (s)')
% figure(2);title('Variación del tiempo ráfagas para el tráfico enviado de cámara_16')
% figure(2);legend('Tráfico enviado')
% figure(3);hist(t_paquete_enviado)
% figure(3);xlabel('Duración del paquete (s)')
% figure(3);ylabel('Cantidad de paquetes')
% figure(3);title('Distribusión de paquetes para el tráfico de cámara_16')
% figure(3);legend('Tráfico enviado')
% figure(4);hist(t_paquete_recibido)
% figure(4);xlabel('Duración del paquete (s)')
% figure(4);ylabel('Cantidad de paquetes')
% figure(4);title('Distribusión de paquetes para el tráfico cámara_16')
% figure(4);legend('Tráfico enviado')

% Cámara 13
% figure(1);plot(t_enviado,t_paquete_enviado,'r',t_recibido,t_paquete_recibido,'b')
% figure(1);xlabel('Tiempo de transmisión (s)')
% figure(1);ylabel('Duración del paquete (s)')
% figure(1);title('Variación del tiempo de paquetes para el tráfico de cámara_13')
% figure(1);legend('Tráfico enviado','Tráfico recibido')
% figure(2);plot(tiempo_rafaga_enviado,t_rafaga_enviado)
% figure(2);xlabel('Tiempo de transmisión (s)')
% figure(2);ylabel('Duración de la ráfaga (s)')
% figure(2);title('Variación del tiempo ráfagas para el tráfico enviado de cámara_13')
% figure(2);legend('Tráfico enviado')
% figure(3);hist(t_paquete_enviado)
% figure(3);xlabel('Duración del paquete (s)')
% figure(3);ylabel('Cantidad de paquetes')
% figure(3);title('Distribusión de paquetes para el tráfico de cámara_13')
% figure(3);legend('Tráfico enviado')
% figure(4);hist(t_paquete_recibido)
% figure(4);xlabel('Duración del paquete (s)')
% figure(4);ylabel('Cantidad de paquetes')
% figure(4);title('Distribusión de paquetes para el tráfico cámara_13')
% figure(4);legend('Tráfico recibido')

% Cámara 4
% figure(1);plot(t_enviado,t_paquete_enviado,'r',t_recibido,t_paquete_recibido,'b')
% figure(1);xlabel('Tiempo de transmisión (s)')
% figure(1);ylabel('Duración del paquete (s)')
% figure(1);title('Variación del tiempo de paquetes para el tráfico de cámara_4')
% figure(1);legend('Tráfico enviado','Tráfico recibido')
% figure(2);plot(tiempo_rafaga_enviado,t_rafaga_enviado)
% figure(2);xlabel('Tiempo de transmisión (s)')
% figure(2);ylabel('Duración de la ráfaga (s)')
% figure(2);title('Variación del tiempo ráfagas para el tráfico enviado de cámara_4')
% figure(2);legend('Tráfico enviado')
% figure(3);hist(t_paquete_enviado)
% figure(3);xlabel('Duración del paquete (s)')
% figure(3);ylabel('Cantidad de paquetes')
% figure(3);title('Distribusión de paquetes para el tráfico de cámara_4')
% figure(3);legend('Tráfico enviado')
% figure(4);hist(t_paquete_recibido)
% figure(4);xlabel('Duración del paquete (s)')
% figure(4);ylabel('Cantidad de paquetes')
% figure(4);title('Distribusión de paquetes para el tráfico cámara_4')
% figure(4);legend('Tráfico recibido')

% figure(2);hist(t_paquete_enviado)
% figure(4);hist(t_paquete_recibido)
% figure(5);plot(tiempo_rafaga_enviado,t_rafaga_enviado)
% figure(6);hist(t_rafaga_enviado)
% figure(7);plot(tiempo_rafaga_recibido,t_rafaga_recibido)
% figure(8);hist(t_rafaga_recibido)
