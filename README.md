# 🛠️ ETL com Elixir + Phoenix + Docker

Este projeto implementa um pipeline de ETL utilizando Elixir + Phoenix + PostgreSQL, com suporte a leitura de CSV, normalização de dados e histórico de execuções. O projeto é dividido em duas partes separadas:

---

## 📦 Estrutura

```
etl_root/
├── etl_app/      # Módulo independente para leitura de CSV
├── etl_web/      # API Phoenix (normaliza, grava e expõe os dados)
└── docker-compose.yml
```

---

## 🚀 Como rodar

```bash
# Gere a chave secreta uma vez
cd etl_web
mix phx.gen.secret

# Copie a chave para o docker-compose.yml como SECRET_KEY_BASE
cd ..

# Suba os containers
docker-compose up --build

# Rode as migrations
docker-compose exec etl_web mix ecto.migrate
```

---

## 📁 CSV de entrada

O arquivo de entrada deve estar localizado em:

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

- ✅ Execução manual de ETL
- ✅ Upload de CSV via API
- ✅ Normalização de operadores e localizações (tabelas separadas)
- ✅ Validação linha a linha (linhas inválidas não quebram o processo)
- ✅ Registro de histórico de execuções (`etl_runs`)
- ✅ Exposição de dados via API com nomes legíveis (sem IDs)

---

## 📡 Endpoints

### 🔁 POST `/api/run_etl`

Executa o ETL com o CSV padrão (`data/input.csv`).

```bash
curl -X POST http://localhost:4000/api/run_etl
```

Retorno:

```json
{
  "status": "ok",
  "total": 100,
  "success": 97,
  "error": 3
}
```

---

### 📤 POST `/api/upload_csv`

Upload de um CSV para o servidor.

```bash
curl -X POST http://localhost:4000/api/upload_csv \
  -F "file=@etl_app/data/input.csv"
```

---

### 📥 GET `/api/readings`

Retorna os dados processados com nome de operador e localização.

```bash
curl http://localhost:4000/api/readings
```

---

### 📜 GET `/api/etl_runs`

Histórico de execuções do ETL.

```bash
curl http://localhost:4000/api/etl_runs
```

---

## 🧱 Estrutura de dados

- `sensor_readings`: leitura dos sensores
- `operators`: nomes únicos de operadores
- `locations`: nomes únicos de localizações
- `etl_runs`: log das execuções do ETL

---

## ✅ Próximos passos (opcionais)

- [ ] Exportar linhas com erro em um CSV separado (`etl_errors.csv`)
- [ ] Agendamento automático do ETL (via `Quantum`)
- [ ] Autenticação de API
- [ ] Dashboard visual com LiveView ou React

---

## 👨‍💻 Autor

Gustavo Correia dos Santos  
[LinkedIn](https://www.linkedin.com/in/gustavo-correia-dos-santos-6039641a6)

