# Используем базовый образ Python
FROM python:3.10

# Устанавливаем poetry
RUN pip install --no-cache-dir --upgrade poetry

# Копируем файлы poetry для установки зависимостей
COPY pyproject.toml ./

# Устанавливаем зависимости с poetry
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-interaction --no-ansi

# Копируем приложение
COPY api /opt/api

# Устанавливаем рабочую директорию
WORKDIR /opt/

# Указываем команду для запуска приложения
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "80"]
