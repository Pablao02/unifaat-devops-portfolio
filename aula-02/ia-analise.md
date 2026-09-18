\# Análise do uso de IA como copiloto — Aula 02



\## 1. Prompt utilizado



O seguinte prompt foi utilizado no Kiro:



> Estou realizando um trabalho de fixação de DevOps sobre Docker Compose e IA como copiloto.

>

> Preciso de um rascunho inicial de um arquivo docker-compose.yml para uma aplicação chamada TechNova, com 3 serviços:

>

> 1. api:

> - Aplicação Node.js/Express.

> - Deve ser construída a partir de um Dockerfile local.

> - Deve expor a porta 3000.

> - Deve utilizar variáveis de ambiente vindas de um arquivo .env, sem senhas ou valores sensíveis hardcoded.

> - Deve depender do PostgreSQL e do Redis usando depends\_on com condições de healthcheck.

> - Deve utilizar restart: unless-stopped.

>

> 2. postgres:

> - Utilizar a imagem postgres:15-alpine.

> - Utilizar volume nomeado para persistência dos dados.

> - Configurar banco, usuário e senha por meio de variáveis de ambiente.

> - Possuir healthcheck usando pg\_isready.

> - Utilizar restart: unless-stopped.

>

> 3. redis:

> - Utilizar a imagem redis:7-alpine.

> - Possuir healthcheck utilizando redis-cli ping.

> - Utilizar restart: unless-stopped.

>

> Requisitos adicionais:

> - Os três serviços devem estar conectados a uma rede bridge personalizada chamada technova-network.

> - O PostgreSQL deve utilizar um volume nomeado chamado postgres-data.

> - As configurações devem ser obtidas por interpolação de variáveis do arquivo .env.

> - O arquivo deve conter comentários explicativos em cada seção.

> - O compose deve ser compatível com Docker Compose atual, sem utilizar a propriedade version.

> - Considere as seguintes variáveis disponíveis no .env:

>   PORT

>   NODE\_ENV

>   POSTGRES\_DB

>   POSTGRES\_USER

>   POSTGRES\_PASSWORD

>   DB\_HOST

>   DB\_PORT

>   DB\_NAME

>   DB\_USER

>   DB\_PASSWORD

>   REDIS\_HOST

>   REDIS\_PORT

>

> IMPORTANTE:

> Não crie, altere ou execute nenhum arquivo do projeto.

> Não execute comandos.

> Apenas apresente aqui o conteúdo completo do seu rascunho inicial de docker-compose.yml, dentro de um bloco de código YAML, para que eu possa analisar e comparar posteriormente com a implementação manual.



\---



\## 2. Output original do Kiro



O Kiro gerou o seguinte rascunho inicial:



```yaml

\# =============================================================================

\# Docker Compose - TechNova Application

\# Compatível com Docker Compose V2+ (sem a propriedade 'version' deprecada)

\# =============================================================================



services:



&#x20; # ---------------------------------------------------------------------------

&#x20; # Serviço: api

&#x20; # Aplicação Node.js/Express — construída a partir do Dockerfile local

&#x20; # ---------------------------------------------------------------------------

&#x20; api:

&#x20;   build:

&#x20;     context: .

&#x20;     dockerfile: Dockerfile

&#x20;   ports:

&#x20;     # Mapeia a porta do container para o host usando a variável PORT do .env

&#x20;     - "${PORT}:3000"

&#x20;   env\_file:

&#x20;     # Carrega todas as variáveis de ambiente diretamente do arquivo .env

&#x20;     - .env

&#x20;   environment:

&#x20;     # Variáveis de conexão com o PostgreSQL

&#x20;     DB\_HOST: ${DB\_HOST}

&#x20;     DB\_PORT: ${DB\_PORT}

&#x20;     DB\_NAME: ${DB\_NAME}

&#x20;     DB\_USER: ${DB\_USER}

&#x20;     DB\_PASSWORD: ${DB\_PASSWORD}

&#x20;     # Variáveis de conexão com o Redis

&#x20;     REDIS\_HOST: ${REDIS\_HOST}

&#x20;     REDIS\_PORT: ${REDIS\_PORT}

&#x20;     # Ambiente de execução da aplicação

&#x20;     NODE\_ENV: ${NODE\_ENV}

&#x20;   depends\_on:

&#x20;     # A API só sobe após o PostgreSQL e o Redis passarem nos healthchecks

&#x20;     postgres:

&#x20;       condition: service\_healthy

&#x20;     redis:

&#x20;       condition: service\_healthy

&#x20;   networks:

&#x20;     - technova-network

&#x20;   restart: unless-stopped



&#x20; # ---------------------------------------------------------------------------

&#x20; # Serviço: postgres

&#x20; # Banco de dados relacional PostgreSQL 15 (Alpine — imagem leve)

&#x20; # ---------------------------------------------------------------------------

&#x20; postgres:

&#x20;   image: postgres:15-alpine

&#x20;   environment:

&#x20;     # Credenciais e nome do banco lidos do .env — nenhum valor hardcoded

&#x20;     POSTGRES\_DB: ${POSTGRES\_DB}

&#x20;     POSTGRES\_USER: ${POSTGRES\_USER}

&#x20;     POSTGRES\_PASSWORD: ${POSTGRES\_PASSWORD}

&#x20;   volumes:

&#x20;     # Volume nomeado para persistência dos dados entre reinicializações

&#x20;     - postgres-data:/var/lib/postgresql/data

&#x20;   healthcheck:

&#x20;     # Verifica se o PostgreSQL está pronto para aceitar conexões

&#x20;     test: \["CMD-SHELL", "pg\_isready -U ${POSTGRES\_USER} -d ${POSTGRES\_DB}"]

&#x20;     interval: 10s

&#x20;     timeout: 5s

&#x20;     retries: 5

&#x20;     start\_period: 30s

&#x20;   networks:

&#x20;     - technova-network

&#x20;   restart: unless-stopped



&#x20; # ---------------------------------------------------------------------------

&#x20; # Serviço: redis

&#x20; # Cache em memória Redis 7 (Alpine — imagem leve)

&#x20; # ---------------------------------------------------------------------------

&#x20; redis:

&#x20;   image: redis:7-alpine

&#x20;   healthcheck:

&#x20;     # Verifica se o Redis está respondendo a comandos

&#x20;     test: \["CMD", "redis-cli", "ping"]

&#x20;     interval: 10s

&#x20;     timeout: 5s

&#x20;     retries: 5

&#x20;     start\_period: 10s

&#x20;   networks:

&#x20;     - technova-network

&#x20;   restart: unless-stopped



\# =============================================================================

\# Volumes nomeados

\# Gerenciados pelo Docker para garantir persistência dos dados

\# =============================================================================

volumes:

&#x20; postgres-data:

&#x20;   driver: local



\# =============================================================================

\# Redes personalizadas

\# Bridge customizada para isolar e conectar os serviços da aplicação

\# =============================================================================

networks:

&#x20; technova-network:

&#x20;   driver: bridge

