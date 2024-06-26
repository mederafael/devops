Docker Compose: configuração dos serviços Kafka e Zookeeper.
.env: arquivo de variáveis de ambiente.
Criação de Tópicos: script para criar tópicos.
Carga de Dados: script para carregar dados de teste.
Testes Automatizados: script para realizar testes nos tópicos.

kafka-cluster/
├── docker-compose.yml
├── .env
├── scripts/
│   ├── create_topics.sh
│   ├── load_data.sh
│   ├── run_tests.sh
├── data/
│   ├── transactions.csv
