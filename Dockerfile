# Usa uma imagem leve do Python
FROM python:3.10-slim

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Seta variáveis de ambiente
ENV account="AKGVXQZ-NA33433"
ENV user="LELE7070"
ENV password="Laranjalima163*"
ENV role="ACCOUNTADMIN"
ENV warehouse="COMPUTE_WH"
ENV database="SP_TRANS"
ENV schema="STATIC"
ENV GOOGLE_APPLICATION_CREDENTIALS="${GOOGLE_APPLICATION_CREDENTIALS}"

# Copia os arquivos do projeto
COPY requirements.txt /app/requirements.txt
COPY src/ /app/

# Instala dependências
RUN pip install --no-cache-dir -r /app/requirements.txt
RUN echo "$GOOGLE_APPLICATION_CREDENTIALS" > /app/credentials.json

# Comando padrão do container
CMD ["python", "/app/main.py"]