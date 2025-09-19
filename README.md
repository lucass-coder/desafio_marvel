# Desafio Técnico - Marvel App

Este projeto é uma aplicação mobile desenvolvida em Flutter como parte de um desafio técnico para a vaga de Desenvolvedor Flutter. 
-
O aplicativo consome a API REST da Marvel para buscar e exibir uma lista de personagens, permitindo ao usuário visualizar detalhes sobre cada um deles, com uma interface baseada em um design pré-definido.

## 📋 Funcionalidades Implementadas

O app cumpre todos os requisitos funcionais solicitados: 

* **Busca e Listagem de Personagens:** Exibe uma lista paginada de personagens da Marvel em ordem alfabética. 
* **Busca por Nome:** Permite ao usuário buscar personagens pelo início do nome.
* **Scroll Infinito:** Carrega mais personagens automaticamente conforme o usuário rola a tela.
* **Pull to Refresh:** Permite ao usuário "puxar" a lista para recarregá-la.
* **Tela de Detalhes:** Apresenta uma tela dedicada com a imagem e a biografia do personagem selecionado. 
* **Efeito de Carregamento (Shimmer):** Mostra um placeholder animado enquanto os dados estão sendo carregados, melhorando a experiência do usuário.
* **Cache de Imagens:** Utiliza cache local para as imagens, otimizando a performance e o uso de dados.
* **Tratamento de Erros:** Exibe mensagens de erro claras e uma opção para tentar novamente em caso de falha na comunicação com a API. 
* **Analytics Nativo (Diferencial):** Integra-se nativamente com o Google Analytics para rastrear eventos importantes, como a visualização de telas e a seleção de personagens, através de um `MethodChannel`. 

## 🏛️ Arquitetura e Tecnologias

**Clean Architecture**, dividindo o projeto em camadas bem definidas (Data, Domain, Presentation) para garantir o baixo acoplamento entre as classes. 
* **Princípios de Código:** Foram aplicados os conceitos de **SOLID, DRY e KISS**. 
* **Versionamento:** O histórico de commits segue o padrão de **Commits Semânticos** para maior clareza e organização. 

### Justificativa dos Pacotes Utilizados

 A escolha dos pacotes foi baseada na robustez, popularidade na comunidade e adequação aos requisitos do desafio. 
* **`flutter_bloc` (`Cubit`):** Escolhido para o gerenciamento de estado por sua simplicidade e baixo boilerplate, mais famliaridade com o time (vulgou eu), sendo ideal para a complexidade do projeto. Ele segrega a lógica da UI de forma clara e facilita a testabilidade ainda mais com o bloc_test. 
* **`equatable`:** Utilizado em conjunto com `Cubit` para facilitar a comparação de estados, reduzindo a necessidade de escrever código boilerplate para `props` e garantindo maior legibilidade e manutenção. 
* **`crypto`:** Necessário para realizar a encriptação em **MD5**, exigida pela API da Marvel para geração do `hash` de autenticação. 
* **`flutter_native_splash`:** Ajudou na criação da splash screen inicial, automatizando parte da configuração. Contudo, foi necessário realizar ajustes nativos adicionais para adequar ao design esperado. 
* **`flutter_modular` - Recomendação do desafio:** Utilizado para Injeção de Dependência e Gerenciamento de Rotas. 
* **`dio` - Recomendação do desafio:** Um cliente HTTP poderoso e flexível. -Foi essencial para a implementação de `Interceptors`, que permitiram adicionar os parâmetros de autenticação da API da Marvel (`ts`, `hash`, `apikey`) dinamicamente a cada requisição. 
* **`flutter_dotenv`:** Para o gerenciamento seguro das chaves de API, garantindo que as chaves não sejam expostas no código-fonte, conforme solicitado no desafio. 
* **`cached_network_image`:** Melhora a performance e a experiência do usuário ao fazer cache de imagens, evitando downloads repetidos e exibindo placeholders de carregamento customizados.
* **`shimmer_animation`:** Proporciona um efeito de loading (esqueleto) elegante, superior a um simples indicador de progresso circular, melhorando a percepção de performance.
* **`mocktail` - Recomendação do desafio -**  Utilizado amplamente pela comunidade devido a sua facilidade e seu poder para criar os mocks, além de ter bastante conteúdo para consumo.
**`bloc_test`:** Ferramentas padrão da comunidade para a criação de mocks e testes de unidade para as camadas de `datasource` e `presentation`, como solicitado. 
* **`integration_test`:** O pacote oficial do Flutter para testes End-to-End (E2E), garantindo que os fluxos completos do usuário funcionem como esperado.

## 🚀 Como Configurar e Rodar o Projeto

#### Pré-requisitos
* Flutter SDK (versão 3.35.4 ou compatível)
* Um editor de código (VS Code ou Android Studio)
* Um emulador Android ou iOS, ou um dispositivo físico

## 1. Clonar o Repositório

git clone <https://github.com/lucass-coder/desafio_marvel>

## 2. Obter as Chaves da API da Marvel
É necessário criar uma conta de desenvolvedor na Marvel para obter suas chaves.  

- Crie sua conta [neste link](https://developer.marvel.com/).  
- Gere suas chaves de API (pública e privada) [neste link](https://developer.marvel.com/account).  

---

## 3. Configurar as Variáveis de Ambiente (.env)
Para manter suas chaves seguras, o projeto utiliza um arquivo `.env`.  `

Na raiz do projeto, crie um arquivo chamado `.env`.  

Dentro deste arquivo, adicione suas chaves no seguinte formato:

.env

MARVEL_PUBLIC_KEY="SUA_CHAVE_PUBLICA_AQUI"      
MARVEL_PRIVATE_KEY="SUA_CHAVE_PRIVADA_AQUI"

> **Importante**: O arquivo `.env` já está incluído no `.gitignore` e não será enviado para o repositório.  
---

## 4. Instalar as Dependências
```bash
flutter pub get
```

---

## 5. Rodar o Aplicativo
```bash
flutter run
```

---

## 🧪 Testes
O projeto conta com uma suíte de testes que cobre as principais camadas da aplicação, conforme solicitado, e tem ao menos um teste em cada camada de testes (unitários, de widgets e E2E).  

- **Testes de Unidade (Domain, Data, Presentation)**: Validam a lógica de negócio e o comportamento de cada classe de forma isolada.  
- **Testes de Widget**: Verificam a renderização e a interação de componentes de UI individuais.  
- **Testes End-to-End (E2E)**: Simulam a interação real do usuário em um dispositivo ou emulador.  

### Para rodar todos os testes:
```bash
flutter test
```

### Para rodar os testes de integração especificamente:
Na Raiz do projeto utilize o seguinte comando:
```bash
flutter test integration_test/app_flow_test.dart
```
Caso tenha problemas, verifique se o seu emulador ja esta aberto e sua IDE apontando para ele. Mas o teste ainda pode ser rodado clicando em **RUN** contido em **integration_test/app_flow_test.dart**


---

## 📊 Versões Utilizadas
- **Flutter**: 3.35.4  
- **Dart**: 3.9.2  
- **cupertino_icons**: ^1.0.8  
- **flutter_modular**: ^6.3.4  
- **dio**: ^5.1.1  
- **flutter_bloc**: ^9.1.0  
- **equatable**: ^2.0.5  
- **flutter_dotenv**: ^6.0.0  
- **crypto**: ^3.0.3  
- **flutter_native_splash**: ^2.4.6  
- **shimmer_animation**: ^2.2.2  
- **cached_network_image**: ^3.4.1  
- **mocktail**: ^1.0.4  
- **bloc_test**: ^10.0.0  
