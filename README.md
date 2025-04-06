# Calibration & Control Software Infrastructure

Este proyecto define una arquitectura de monitoreo y adquisición de datos basada en contenedores Docker, orquestada mediante Terraform.

## 🧩 Servicios incluidos

- **Node-RED**: con el plugin `node-red-contrib-s7` instalado para comunicarse con PLC Siemens S7-1200
- **InfluxDB 2.7.11**: almacenamiento de series temporales
- **Grafana**: visualización de datos desde InfluxDB

## 🚀 Cómo desplegar

1. Asegurate de tener instalados:

   - [Docker Desktop](https://www.docker.com/products/docker-desktop)
   - [Terraform](https://developer.hashicorp.com/terraform/downloads)
   - PowerShell (incluido en Windows)

2. Ejecutá el siguiente script:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
.\deploy.ps1
