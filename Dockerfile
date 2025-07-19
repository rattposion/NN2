# Dockerfile para n8n (Railway)
FROM n8nio/n8n:latest

# Definir diretório de trabalho
WORKDIR /home/node/.n8n

# Instalar dependências adicionais se necessário
RUN apk add --no-cache \
    curl \
    && rm -rf /var/cache/apk/*

# Copiar configurações customizadas
COPY n8n-config.json /home/node/.n8n/config.json

# Expor porta
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# Comando de inicialização
CMD ["n8n", "start"] 