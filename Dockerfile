# ESTÁGIO 1: Compilação (Build)
# Usamos uma imagem com Maven e Java 21 para gerar o arquivo final
FROM maven:3.9.6-eclipse-temurin-21 AS build

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo de configuração do Maven e as dependências primeiro (otimiza o cache)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copia o código fonte do projeto
COPY src ./src

# Compila o projeto e gera o arquivo .war (ou .jar) ignorando os testes para ser mais rápido
RUN mvn clean package -DskipTests

# ESTÁGIO 2: Execução (Runtime)
# Usamos uma imagem apenas com o Java 21 (mais leve) para rodar a aplicação
FROM eclipse-temurin:21-jdk

WORKDIR /app

# Copia o arquivo gerado no estágio anterior para o novo container
# Nota: O comando abaixo busca por qualquer arquivo .war ou .jar na pasta target
COPY --from=build /app/target/*.war app.war

# Expõe a porta 8080 (porta padrão do Spring Boot)
EXPOSE 8080

# Comando para iniciar a aplicação
ENTRYPOINT ["java", "-jar", "app.war"]