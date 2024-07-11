## Week 1: Docker and Terraform

### Download data
- Download data from
  - `https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz`

### Create development stack
- From root project folder run `docker compose -p de-zoomcamp-stack up -d --build`
- Connect to DB through **pgAdmin**
  - Register > Server with:
    - General Name: `server_name`
    - Connection Host Name: `local_pgdb` (container name)
    - Connection Port: 5432
    - Maintenance database: `ny_taxi`
    - Username: `root`
    - Password: `root`

### Data Ingestion

#### Dockerize ingestion script
- Create image `docker build -t load_taxi_data:v001 .`
- Start container
```
docker run -it
  --name taxi-ingestion
  --network de-zoomcamp-stack_default
  load_taxi_data:v001
  --user root
  --password root
  --db ny_taxi
  --table_nameny_taxi
  --host local_pgdb
  --port 5432
  --url 01-docker-terraform/yellow_tripdata_2021-01.csv.gz
```

#### Connecting to DB from CLI
- Install `pgcli`
  - `pip install pgcli`
- Connect to db through CLI
  - `pgcli -h localhost -p 5432 -u root -d ny_taxi`

#### Running Python script manually
- Run python script to load data
```shell
python .\01-docker-terraform\ingest_data.py
  --user root
  --password root
  --db ny_taxi
  --table_name ny_taxi
  --host localhost
  --port 5432
  --url C:\Users\lpeve\Documents\Github\DE-ZoomCamp\01-docker-terraform\yellow_tripdata_2021-01.csv.gz
```

#### Check
- Open pgAdmin client and check if all records were loaded
  - `SELECT COUNT(*) FROM ny_taxi`
    - There should be `1,369,765` records

### Tearing down development stack
- `docker compose -p de-zoomcamp-stack down`
  - **Note:** Do not use the flag `--volumes`, that way data is persisted regardless if you tear up and restore containers.