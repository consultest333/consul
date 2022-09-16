#/bin/sh

cp config/secrets.yml.example config/secrets.yml
cp config/database-docker.yml.example config/database.yml

docker compose build
docker compose down
POSTGRES_PASSWORD=consul docker compose up -d

echo start building the database
docker exec -it consul-app-1 /bin/sh -c "bin/rake db:create; bin/rake db:migrate; bin/rake db:dev_seed; RAILS_ENV=test rake db:setup;"
