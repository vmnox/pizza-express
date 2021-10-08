FROM node:8.4.0-alpine

# Specify working directory
WORKDIR /pizza-express

# Copy Application source code
COPY --chown=node:node server.js package*.json /pizza-express/
COPY --chown=node:node lib /pizza-express/lib
COPY --chown=node:node views /pizza-express/views

# Install Application dependencies
RUN npm install

# Override default Application port
ENV PORT=8081

# Expose Application on a non-default port 
EXPOSE 8081

# Run Application as a non-root user
USER node

# Container entry
CMD ["node", "server.js"]
