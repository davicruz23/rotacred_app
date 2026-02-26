# 📱 RotaCred App

Aplicativo mobile desenvolvido com **Flutter + Dart** como cliente para o sistema *RotaCred*, consumindo APIs REST seguras desenvolvidas no back-end.

O app foi projetado para fornecer interface móvel funcional para interagir com os serviços de gestão, como autenticação, listagem de dados e operações principais conforme as rotas disponibilizadas pela API.

---

## 🧩 Tecnologias e Ferramentas

- 🧠 **Flutter** – Framework de UI multiplataforma  
- 🛠️ **Dart** – Linguagem principal de desenvolvimento  
- 📱 Suporte para Android (e facilmente adaptável para iOS)  
- 📦 Gerenciamento de dependências via **pubspec.yaml**  
- 📁 Estrutura de pastas organizada para escalabilidade

---

## 📌 Funcionalidades Principais

✔️ Interface mobile responsiva  
✔️ Integração com API REST para consumo de dados  
✔️ Autenticação de usuários (via backend)  
✔️ Navegação entre telas com **Navigator / Routes**  
✔️ Estrutura de widgets modular  
✔️ Assets estáticos (imagens) organizados

---

## 📁 Estrutura do Projeto

````bash
rotacred_app/
├── android
├── assets
├── lib
│ ├── main.dart # Ponto de entrada do app
│ ├── screens/ # Telas da aplicação
│ ├── services/ # Chamadas para a API
│ ├── models/ # Modelos de dados
│ ├── widgets/ # Widgets customizados
│ └── utils/ # Funções utilitárias
├── pubspec.yaml # Configura dependências
└── README.md
````
---

## 🚀 Como Rodar o Projeto

### 🔹 Pré-requisitos

Antes de tudo, instale:

- 👍 **Flutter SDK** (recomendado última versão estável)  
- ✔️ **Dart SDK** (instalado automaticamente com Flutter)  
- 📱 Emulador Android ou dispositivo físico

---

### 🔹 Passos para Executar

1) Clone o repositório:

```bash
git clone https://github.com/davicruz23/rotacred_app.git

2) Entrar na pasta do projeto:
cd rotacred_app

3)Instale as dependências
flutter pub get

4) Configurar Enviroments
colocar a URL da sua API

5) Execute o app
flutter run
