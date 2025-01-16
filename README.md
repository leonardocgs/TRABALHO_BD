# PostgreSQL com Docker Compose

Este projeto utiliza Docker Compose para configurar uma instância do PostgreSQL com criação automática de tabelas e população de dados iniciais. Além disso, inclui um script para realizar backup do banco de dados.

## Requisitos

Certifique-se de ter os seguintes itens instalados:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Estrutura do Projeto

```
projeto/
|-- docker-compose.yml
|-- scripts/
    |-- backup_naus.sh
    |-- init.sql
    |-- populate.sql
```

- **docker-compose.yml**: Configuração do Docker Compose.
- **scripts/init.sql**: Script SQL para criar tabelas,views e stored procedures no banco.
- **scripts/populate.sql**: Script SQL para popular o banco com dados iniciais.
- **scripts/backup_naus.sh**: Script para realizar backup do banco de dados.

## Como Usar

### 1. Subir o Container

1. Clone este repositório ou copie os arquivos para o seu ambiente local.
2. Certifique-se de que os scripts SQL e o script de backup estejam no diretório `scripts/`.
3. Execute o seguinte comando para iniciar o container:

   ```bash
   docker-compose up -d
   ```

4. O PostgreSQL será iniciado com:
   - Usuário: `myuser`
   - Senha: `mypassword`
   - Banco de dados: `mydatabase`

Os scripts `init.sql` e `populate.sql` serão executados automaticamente para criar e popular as tabelas.

### 2. Acessar o Banco de Dados

Você pode acessar o banco de dados usando qualquer cliente PostgreSQL (como [pgAdmin](https://www.pgadmin.org/) ou [DBeaver](https://dbeaver.io/)) com as seguintes credenciais:

- **Host**: `localhost`
- **Porta**: `5432`
- **Usuário**: `myuser`
- **Senha**: `mypassword`
- **Banco de Dados**: `mydatabase`

### 3. Realizar Backup

O projeto inclui o script `backup_naus.sh` para realizar backups do banco de dados. Este script está localizado no container em `/usr/local/bin/backup_naus.sh`.

#### Para executar o backup

1. Execute o seguinte comando:

   ```bash
   docker exec -it my_postgres_db /usr/local/bin/backup_naus.sh
   ```

2. O backup será salvo no diretório configurado dentro do script `backup_naus.sh`. Certifique-se de que o diretório existe e tem permissões apropriadas.

## Personalizações

- **Alterar credenciais**:
  Modifique as variáveis de ambiente `POSTGRES_USER`, `POSTGRES_PASSWORD` e `POSTGRES_DB` no arquivo `docker-compose.yml`.

- **Adicionar ou modificar scripts SQL**:
  Coloque novos scripts no diretório `scripts/` e referencie-os no arquivo `docker-compose.yml`.

## Parar o Container

Para parar e remover o container, execute:

```bash
docker-compose down
```

## Limpar Dados Persistentes

Se desejar remover todos os dados persistidos, apague o volume Docker associado:

```bash
docker volume rm projeto_db_data
```

## Observações

- Certifique-se de que o diretório `scripts/` tem os arquivos com permissão de leitura.
- Dê permissão de execução ao script `backup_naus.sh` antes de iniciar o container:

  ```bash
  chmod +x scripts/backup_naus.sh
  ```
