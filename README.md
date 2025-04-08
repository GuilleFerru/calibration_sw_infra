# 🛠️ Calibration & Control Infrastructure

Este proyecto define una infraestructura local con **Docker** y **Terraform** que levanta automáticamente tres servicios esenciales para un entorno de calibración y control:

- **Node-RED** con plugin Siemens S7 e InfluxDB instalados
- **InfluxDB 2.7** para almacenar datos de proceso
- **Grafana** listo para conectar a InfluxDB en http://influxdb:8086

---

## 📦 Tecnologías utilizadas

- [Terraform](https://www.terraform.io/)
- [Docker](https://www.docker.com/)
- [Node-RED](https://nodered.org/)
- [Grafana](https://grafana.com/)
- [InfluxDB](https://www.influxdata.com/)

---

## ⚙️ Requisitos

- Windows 10/11 con Docker Desktop instalado
- Terraform instalado y en el PATH
- Git instalado
- WSL2 o Hyper-V habilitado (dependiendo de tu versión de Windows)

---

## 🚀 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/calibration-infra.git
cd calibration-infra
```

### 2. Usar el script automático

```bash
./deploy.sh