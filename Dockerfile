FROM node:14

WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

COPY . .

# Expose port 3000
EXPOSE 3000

CMD ["npm", "start"]