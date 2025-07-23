# Этап сборки с компиляцией (регистр исправлен)
FROM python:3.12-slim AS builder

WORKDIR /app

# Установка системных зависимостей для сборки
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

# Копируем и устанавливаем зависимости
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Финальный образ
FROM python:3.12-slim
WORKDIR /app

# Копируем только необходимое из builder
COPY --from=builder /root/.local /root/.local
COPY --from=builder /app/requirements.txt .

# Копируем остальные файлы проекта
COPY . .

# Настраиваем окружение
ENV PATH=/root/.local/bin:$PATH
ENV PYTHONUNBUFFERED=1

# Очищаем кэш pip
RUN rm -rf /root/.cache/pip

EXPOSE 5000
CMD ["python", "app.py"]