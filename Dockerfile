FROM node:14

# Variables imported from host environment such as defined env variables
# It has a default value but it can be easily replaced by using --build-arg key=value at runtime
ARG PORT=3000

# Environment vars
ENV PORT=${PORT}

# Create and move to app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./

#Install app dependencies
RUN npm install 

#Copy folder files to docker directory
COPY . .

#Run the app onto this port
EXPOSE ${PORT}

CMD ["node", "server.js"]
