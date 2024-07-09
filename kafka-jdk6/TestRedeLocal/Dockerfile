# Use uma imagem base do Python
FROM python:3.9-slim

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie os requisitos do projeto
COPY requirements.txt requirements.txt

# Instale as dependências
RUN pip install -r requirements.txt

# Copie o código do aplicativo
COPY . .

# Comando para rodar o aplicativo
CMD ["python", "app.py"]
