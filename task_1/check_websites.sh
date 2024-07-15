#!/bin/bash

# Визначення списку вебсайтів
websites=(
    "https://google.com"
    "https://facebook.com"
    "https://twitter.com"
)

# Ім'я файлу для логування
log_file="website_status.log"

# Видаляємо старий файл логів, якщо він існує
if [ -f "$log_file" ]; then
    rm "$log_file"
fi

# Функція для перевірки доступності сайту
check_website() {
    local url="$1"
    echo "Перевірка: $url"

    local response=$(curl -L -o /dev/null --silent --write-out '%{http_code}\n' "$url")

    if [ "$response" -eq 200 ]; then
        echo "$url is UP" | tee -a "$log_file"
    else
        echo "$url is DOWN" | tee -a "$log_file"
    fi
}

# Працюємо з кожним сайтом у списку
for site in "${websites[@]}"; do
    check_website "$site"
done

# Повідомлення після виконання скрипту
echo "Результати записано у файл $log_file"