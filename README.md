# labdig-jpk
labdig-jpk created by GitHub Classroom

Este repositório é relativo ao projeto 34 da disiciplina de Laboratório Digital A de 2023

Objetivo: Projetar um sistema iterativo de controle de temperatura baseado no sensor DS18B20, em VHDL

Entidades criadas: Divisor de Clock, Decoder, Shift Register, UC, HMI

1. Divisor de clock: altera a frequência de clock conforme necessário
2. Decoder: responsável pelo protocolo de comunicação entre o Arduíno e a FPGA
3. Shift Register: armazena os dados de temperatura bit-a-bit e os retorna por completor
4. UC: implementa os estados de funcionalidade do sistema
5. HMI: Respossável pela interface humano-máquina
