[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Node.js](https://img.shields.io/badge/Node.js-18.x-green.svg)](https://nodejs.org/)
[![Expo](https://img.shields.io/badge/Expo-48.0-black.svg)](https://expo.dev)
[![Platform](https://img.shields.io/badge/platform-Android-green.svg)](https://www.android.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# KyonEye

**KyonEye** é uma aplicação mobile desenvolvida para o monitoramento e gerenciamento do ciclo de vida de containers.  
O projeto consome uma API REST por meio de requisições HTTP. Para acessos externos à rede local, recomenda-se o uso de uma VPN como camada adicional de segurança.


---


## Funcionalidades

### Implementadas
- Monitoramento de recursos do sistema:
  - Uso de CPU
  - Consumo de RAM
  - Temperatura do sistema
  - Status dos containers

### Planejadas
- Gerenciamento do ciclo de vida dos containers (start, stop, restart, etc.)
- Conexão segura via SSH


---


## Requisitos

- **Servidor:** Homelab ou qualquer máquina com acesso remoto.
- **API:** O servidor deve estar executando a [KyonEye_API](https://github.com/Nicolas-MZ/KyonEye_API).
- **Porta padrão:** Tanto o aplicativo quanto a API utilizam a porta `3201`.  
  Para alterá-la:
  1. Acesse o arquivo `./config/IPs.ts`
  2. Modifique o valor da constante `PORT` para a porta desejada
  3. Certifique-se de que a API também esteja configurada para escutar na mesma porta


---


## Utilização

1. Instale o arquivo `.apk` no dispositivo Android.
2. Informe o **IP local** do servidor (pode ser obtido no painel administrativo do roteador).
3. No segundo campo, opcionalmente, insira o **IPv4 do servidor na rede VPN** para acesso remoto.


---


## Desenvolvimento

Caso deseje compilar sua própria versão do aplicativo, siga os passos abaixo.


### Pré‑requisitos

- [Node.js](https://nodejs.org/)
- [npm](https://www.npmjs.com/) ou [yarn](https://yarnpkg.com/)
- [Expo Go](https://expo.dev/go) (para testes no dispositivo)


### Passo a Passo

1. **Clone o repositório**
   git clone https://github.com/Nicolas-MZ/KyonEye
   cd KyonEye

2. **Instale as Dependencias**
   npm install

3. **inicie o servidor expo para test**
   npx expo start -c

4. ** Acessando o app**
   Entre no app Expo Go e Esacneie o QR-Code do Terminal
