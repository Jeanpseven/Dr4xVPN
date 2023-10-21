import subprocess
import random
import time
import pytz

# Função para gerar um IP aleatório
def generate_random_ip():
    ip_parts = [str(random.randint(0, 255)) for _ in range(4)]
    return ".".join(ip_parts)

# Função para escolher um fuso horário aleatório
def choose_random_timezone():
    timezones = pytz.all_timezones
    return random.choice(timezones)

# Loop para alterar o IP e o fuso horário a cada 5 segundos
while True:
    new_ip = generate_random_ip()
    new_timezone = choose_random_timezone()

    # Alterar o IP
    subprocess.run(["ifconfig", "eth0", new_ip])

    # Alterar o fuso horário
    subprocess.run(["timedatectl", "set-timezone", new_timezone])

    print(f"IP alterado para {new_ip}, Fuso horário alterado para {new_timezone}")

    # Aguarde 5 segundos antes da próxima alteração
    time.sleep(5)
