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

* Database and Web Application - docker-compose.yml
```
version: '2.0'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/app
    depends_on:
      - "db"
    command: ["./wait-for-postgres.sh", "db", "flask", "run", "--host", "0.0.0.0", "--port", "5000"]
  db:
    image: postgres
    ports:
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: itversity
```