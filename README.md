# labdig-jpk
labdig-jpk created by GitHub Classroom

Este repositório é relativo ao projeto 34 da disiciplina de Laboratório Digital A de 2023

Objetivo: Projetar um sistema iterativo de controle de temperatura baseado no sensor DS18B20, em VHDL

Entidades criadas: Divisor de Clock, Decoder, Shift Register, UC, HMI

1. Divisor de clock: altera a frequência de clock conforme necessário
2. Decoder: responsável pelo protocolo de comunicação entre o Arduíno e a FPGA
3. Shift Register: armazena os dados de temperatura bit-a-bit e os retorna por completo
4. UC: implementa os estados de funcionalidade do sistema
5. HMI: Respossável pela interface humano-máquina

**Modo de uso**
O sistema monitora a temperatura do ambiente com precisão de 1 grau Celsius. A temperatura é amostrada e lida pelo arduino, que por sua vez codifica um sinal de 32 bits a ser transmitido serialmente para a FPGA.
O usuário dispõe de 3 switches e 3 botões, sendo eles: SW9, SW8, SW7 e Key3, Key2, Key1. 
O primeiro switch é responsável por escolher a unidade de temperatura de interesse (Celsius, Fahrenheit e Kelvin). A seleção é feita através dos dois primeiros botões citados, variando em sentidos opostos. Selecionada a unidade, o terceiro botão deve ser apertado para a configuração definitiva.
O segundo switch é responsável pela exposição da faixa tolerável de temperatura do dispositivo, definida como padrão de fábrica.
O Terceiro, por fim, seleciona a ação frente a um cenário em que a temperatura medida é maior que a máxima tolerável ou menor que a mínima tolerável. Inicialmente, há duas possibilidades: o acionamento de um Led ou de um Buzzer, configuradas da mesma forma que o primeiro switch.
