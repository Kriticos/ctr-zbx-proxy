# Zabbix Proxy com Docker Compose

Este repositório contém a configuração para subir um container Zabbix Proxy utilizando MySQL como backend.

## Pré-requisitos

- [Docker e Docker Compose](https://docs.docker.com/engine/install/)
- Rede Docker network-share.
- Container Zabbix Server rodando.

## Estrutura de arquivos

```bash
.
├── .env                # variáveis de ambiente
├── .env.example        # Exemplo de variáveis de ambiente
├── .gitignore
├── docker-compose.yml  # Definição dos serviços Docker
├── prepare.sh          # Script para criação das pastas e rede
└── README.md           # Documentação do serviço
```

## Configuração das variáveis de ambiente

Acesse a pasta do container

```bash
cp .env.example .env
```

## Preparando o ambiente

Acesse a pasta do container

```bash
chmod +x prepare.sh
```

```bash
./prepare.sh
```

## Subindo o container

```bash
docker compose up -d
```

## Verifique os logs

```bash
docker logs -f ctr-zbx-proxy
```

## Adicionando o Proxy no Zabbix

1. Acesse a interface do Zabbix Server.
2. Vá em Administration → Proxies → Create proxy.
3. Preencha os campos:
   - Proxy name: igual ao valor de ZBX_HOSTNAME do .env (ex.: ctr-zbx-proxy).
   - Proxy mode: Active (ou Passive, se configurado).
   - Proxy address: IP ou DNS do container (ex.: 172.18.0.12 ou o IP do host com porta 10051).
   - Description: opcional.
   - Clique em Add.

## Testando comunicação

No host do servidor Zabbix:

>OBS: colocar o nome do proxy conforme configurado no .env

```bash
docker exec -it ctr-zbx-proxy zabbix_proxy -T
```

Retorno esperado se tudo estiver OK:

```bash
Validating configuration file "/etc/zabbix/zabbix_proxy.conf"
Validation successful
```

Se a comunicação estiver OK, o proxy aparecerá na interface do Zabbix em alguns minutos.