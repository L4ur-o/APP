# 🎮 CLICKER - Flutter

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)

> **Um jogo com base em incrementos de cliques em que o usuário acumula pontos e upa seu starter apenas clicando!**  

---

## 📌 **Índice**  
1. [Visão Geral](#-visão-geral)  
2. [Funcionalidades](#✨-funcionalidades)  
3. [Tecnologias Usadas](#🛠️-tecnologias-usadas)  
4. [Estrutura do Projeto](#📂-estrutura-do-projeto)  
5. [Como Executar](#🚀-como-executar)  
6. [Contribuição](#🤝-contribuição)  
7. [Licença](#📜-licença)  

---

## 🌟 **Visão Geral**  
Um jogo simples de clicker desenvolvido em Flutter com:  
✔ **Clique manual** para ganhar pontos  
✔ **Autoclickers** (ganho automático de pontos)  
✔ **Sistema de upgrades** para melhorar eficiência  
✔ **Estatísticas** para acompanhar progresso  

---

## ✨ **Funcionalidades**  

### 🕹️ **Jogo Principal**  
| Feature | Descrição |  
|---------|-----------|  
| **Clique Manual** | Ganhe pontos tocando no botão |  
| **Autoclickers** | Ganhe pontos automaticamente e vá upando |  
| **Upgrades** | Melhore seu poder de clique e compre mais autoclickers |  

### 📊 **Telas**  
| Tela | Descrição |  
|------|-----------|  
| **GameScreen** | Contador de pontos + botão de clique |  
| **UpgradesScreen** | Compre melhorias para avançar mais rápido |  
| **StatsScreen** | Veja seu progresso e estatísticas |  

---

## 🛠️ **Tecnologias Usadas**  
- **Flutter** (Framework UI)  
- **Dart** (Linguagem)  
- **AnimationController** (Animações de clique)  
- **Timer** (Autoclickers)  

---

## 📂 **Estrutura do Projeto**  
clicker_flutter/
├── lib/
│ ├── main.dart # Ponto de entrada
│ ├── screens/ # Telas do app
│ │ ├── game_screen.dart
│ │ ├── upgrades_screen.dart
│ │ └── stats_screen.dart
│ └── widgets/ # Componentes reutilizáveis
│ └── upgrade_tile.dart
└── pubspec.yaml # Dependências e configurações

---

## 🚀 **Como Executar**  
1. **Tenha o Flutter instalado**:  
   ```sh
   flutter --version  # Verifique se está instalado
2. **Clone o Repositório**
   ```sh
   git clone https://github.com/L4ur-o/APP.git
   cd clicker-flutter
3. **Instale as dependências e execute:**
   ```sh
   flutter pub get
   flutter run
