FROM python:3.11-slim

# Встановлення змінних середовища
ENV APP_HOME=/app
ENV POETRY_HOME=/etc/poetry
ENV PATH=$POETRY_HOME/bin:$PATH

# Встановлення системних залежностей
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl build-essential \
    && rm -rf /var/lib/apt/lists/*

# Встановлення Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Створення робочої директорії
WORKDIR $APP_HOME

# Копіювання файлів
COPY . .

# Встановлення залежностей
RUN poetry install --no-root

# Відкриття порту
EXPOSE 5000

# Запуск програми
ENTRYPOINT ["poetry", "run", "python", "main.py"]
