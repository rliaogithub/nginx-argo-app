FROM nginx:alpine

# Copy custom html content
COPY html/ /usr/share/nginx/html/

# Copy nginx configuration if needed
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]