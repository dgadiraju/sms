* Web Application - docker-compose.yml
```
version: '2.0'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/app
    command: ["flask", "run", "--host", "0.0.0.0", "--port", "5000"]
```