import subprocess
import random
import pytz

# Função para gerar um IP aleatório que não seja igual ao IP anterior
def generate_random_ip(previous_ip):
    while True:
        new_ip = ".".join(str(random.randint(0, 255)) for _ in range(4))
        if new_ip != previous_ip:
            return new_ip

# Função para escolher um fuso horário aleatório
def choose_random_timezone():
    timezones = pytz.all_timezones
    return random.choice(timezones)

# Armazenar o IP e fuso horário originais
original_ip = subprocess.getoutput("ifconfig eth0 | grep 'inet addr' | awk '{print $2}'")
original_timezone = subprocess.getoutput("timedatectl show --property=Timezone --value")

# Gerar um novo IP que não seja igual ao IP original
new_ip = generate_random_ip(original_ip)
new_timezone = choose_random_timezone()

try:
    # Alterar o IP
    subprocess.run(["ifconfig", "eth0", new_ip])

    # Alterar o fuso horário
    subprocess.run(["timedatectl", "set-timezone", new_timezone])

    print(f"IP alterado para {new_ip}, Fuso horário alterado para {new_timezone}")

    # Solicitar confirmação para reverter as alterações
    user_input = input("Pressione Enter para reverter as alterações e encerrar o script...")

    # Reverter as alterações para o IP e fuso horário originais
    subprocess.run(["ifconfig", "eth0", original_ip])
    subprocess.run(["timedatectl", "set-timezone", original_timezone])

    print("Alterações revertidas. Script encerrado.")
except Exception as e:
    print(f"Erro: {e}")