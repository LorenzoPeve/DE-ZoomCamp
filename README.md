## Week 1: Docker and Terraform

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
- Install `pgcli`
  - `pip install pgcli`
- Connect to db through CLI
  - `pgcli -h localhost -p 5432 -u root -d ny_taxi`

### Download and load data
- Downloaded data
  - `https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz`
- Run python script to load data
```shell
python .\01-docker-terraform\ingest_data.py --user root --password root --db ny_taxi --table_name ny_taxi --host localhost --port 5432 --url C:\Users\lpeve\Documents\Github\DE-ZoomCamp\01-docker-terraform\yellow_tripdata_2021-01.csv.gz
```
- After executing script, you can check all records were loaded
  - `SELECT COUNT(*) FROM ny_taxi`
    - There should be `1,369,765` records


### Tearing down development stack
- `docker compose -p de-zoomcamp-stack down`
  - **Note:** Do not use the flag `--volume`, that way data is persisted regardless if you tear up and restore containers.