# Базовый образ Python
FROM python:3.12

# Установка рабочей директории
WORKDIR /app

# Копируем зависимости
COPY requirements.txt .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем все файлы проекта
COPY . .

# Создаем папки для базы данных и статики
RUN mkdir -p instance static

# Открываем порт Flask
EXPOSE 5000

# Команда запуска (debug=False для production)
CMD ["python", "app.py"]