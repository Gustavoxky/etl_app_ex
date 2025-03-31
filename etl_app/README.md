# 🛠️ ETL com Elixir + Phoenix + Docker

Este projeto implementa um pipeline de ETL utilizando Elixir + Phoenix para ler arquivos CSV, processar e persistir os dados em PostgreSQL. Todo o processo é orquestrado com Docker.

---

## 📁 Estrutura

```
etl_root/
├── etl_app/      # Módulo do ETL (leitura, parsing, insert)
├── etl_web/      # API Phoenix (executa o ETL e expõe os dados)
└── docker-compose.yml
```

---

## 🚀 Como rodar

```bash
# 1. Gere uma chave secreta
cd etl_web
mix phx.gen.secret

# 2. Copie a chave para o docker-compose.yml como SECRET_KEY_BASE

# 3. Volte pra raiz
cd ..

# 4. Suba os containers
docker-compose up --build

# 5. Rode a migration
docker-compose exec etl_web mix ecto.migrate
```

---

## 🧾 CSV de entrada

O arquivo deve estar em:

```
etl_app/data/input.csv
```

Formato esperado:

```csv
sensor_id,timestamp,temperature,voltage,is_active,location,operator
101,2025-03-29T08:00:00Z,36.5,220.1,true,Substation A,João Silva
```

---

## ✅ Funcionalidades

- ✅ Upload de CSV via API
- ✅ Execução manual do ETL
- ✅ Registro de histórico de execuções (`etl_runs`)
- ✅ Validação de cada linha (erros são ignorados, mas contabilizados)
- ✅ Estatísticas por execução: total, sucesso e falha
- ✅ Exposição de dados e histórico via API

---

## 📡 Endpoints

### 🔁 POST `/api/run_etl`

Executa o ETL com o arquivo `data/input.csv`.

```bash
curl -X POST http://localhost:4000/api/run_etl
```

---

### 📤 POST `/api/upload_csv`

Envia um CSV para ser processado.

```bash
curl -X POST http://localhost:4000/api/upload_csv \
  -F "file=@etl_app/data/input.csv"
```

---

### 📥 GET `/api/readings`

Retorna os dados processados.

```bash
curl http://localhost:4000/api/readings
```

---

### 📜 GET `/api/etl_runs`

Retorna o histórico de execuções:

```bash
curl http://localhost:4000/api/etl_runs
```

Exemplo de resposta:

```json
[
  {
    "id": 1,
    "source": "manual",
    "status": "ok",
    "message": "Processado com sucesso",
    "file_path": "data/input.csv",
    "total_rows": 100,
    "success_count": 97,
    "error_count": 3,
    "inserted_at": "...",
    "updated_at": "..."
  }
]
```

---

## ✅ Próximos passos (opcionais)

- [ ] Salvar os erros de leitura em CSV separado (`etl_errors.csv`)
- [ ] Normalizar entidades como `operator` e `location`
- [ ] Implementar autenticação
- [ ] Criar dashboard com Phoenix LiveView

---

## 👨‍💻 Autor

Gustavo Correia dos Santos  
[LinkedIn](https://www.linkedin.com/in/gustavo-correia-dos-santos-6039641a6)

