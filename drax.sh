#!/bin/bash

# Função para gerar um IP aleatório que não seja igual ao IP anterior
generate_random_ip() {
    while true; do
        new_ip=$(echo $((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)))
        if [ "$new_ip" != "$previous_ip" ]; then
            echo "$new_ip"
            return
        fi
    done
}

# Função para escolher um fuso horário aleatório
choose_random_timezone() {
    timezones=( $(timedatectl list-timezones) )
    random_timezone="${timezones[RANDOM % ${#timezones[@]}]}"
    echo "$random_timezone"
}

# Armazenar o IP e fuso horário originais
original_ip=$(ifconfig eth0 | grep 'inet addr' | awk '{print $2}' | cut -d ':' -f 2)
original_timezone=$(timedatectl show --property=Timezone --value)

# Gerar um novo IP que não seja igual ao IP original
new_ip=$(generate_random_ip)
new_timezone=$(choose_random_timezone)

# Alterar o IP
sudo ifconfig eth0 $new_ip

# Alterar o fuso horário
sudo timedatectl set-timezone $new_timezone

echo "IP alterado para $new_ip, Fuso horário alterado para $new_timezone"

# Solicitar confirmação para reverter as alterações
read -p "Pressione Enter para reverter as alterações e encerrar o script..."

# Reverter as alterações para o IP e fuso horário originais
sudo ifconfig eth0 $original_ip
sudo timedatectl set-timezone $original_timezone

echo "Alterações revertidas. Script encerrado."