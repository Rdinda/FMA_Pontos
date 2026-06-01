# Estágio 1: Compilação do site estático
FROM node:20-alpine AS build
WORKDIR /app

# Instala as dependências de forma otimizada
COPY package*.json ./
RUN npm ci

# Copia os arquivos do projeto e realiza o build
COPY . .
RUN npm run build

# Estágio 2: Servidor web leve em Nginx para produção
FROM nginx:alpine

# Copia a configuração personalizada do Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia os arquivos compilados do estágio anterior
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
