# placehold-website

![Release](https://github.com/elnebuloso/amber/workflows/Release/badge.svg)
[![Docker Pulls](https://img.shields.io/docker/pulls/elnebuloso/placehold-website.svg)](https://hub.docker.com/r/elnebuloso/placehold-website)
[![GitHub](https://img.shields.io/github/license/elnebuloso/docker-ansible.svg)](https://github.com/elnebuloso/placehold-website)

amber

## environment variables

- APP_NAME
- APP_TEXT_LEAD

## development
```
docker-compose up --build --remove-orphans -d
docker-compose down --remove-orphans
```