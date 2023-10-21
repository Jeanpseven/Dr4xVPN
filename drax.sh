#!/bin/bash

# Função para gerar um IP aleatório
generate_random_ip() {
    ip_parts=()
    for _ in {1..4}; do
        ip_parts+=($((RANDOM % 256)))
    done
    echo "${ip_parts[0]}.${ip_parts[1]}.${ip_parts[2]}.${ip_parts[3]}"
}

# Função para escolher um fuso horário aleatório
choose_random_timezone() {
    timezones=("America/New_York" "Europe/London" "Asia/Tokyo")
    random_timezone=${timezones[$((RANDOM % ${#timezones[@]}))]}
    echo "$random_timezone"
}

# Loop para alterar o IP e o fuso horário a cada 5 segundos
while true; do
    new_ip=$(generate_random_ip)
    new_timezone=$(choose_random_timezone)

    # Alterar o IP
    sudo ifconfig eth0 "$new_ip"

    # Alterar o fuso horário
    sudo timedatectl set-timezone "$new_timezone"

    echo "IP alterado para $new_ip, Fuso horário alterado para $new_timezone"

    # Aguarde 5 segundos antes da próxima alteração
    sleep 5
done
