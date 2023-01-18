{
  components: {

    "back": {
      "replicas": 1,
      "name": "backend",
      "image": "dmi3x3/13-kubernetes-config_backend:latest",
      "ports": {
        "containerPort": 9000
      },
      "service": {
        "port": 9000
      }
    },

    "front": {
      "replicas": 1,
      "name": "frontend",
      "image": "dmi3x3/13-kubernetes-config_frontend:latest",
      "ports": {
         "containerPort": 80
      },
      "service": {
         "port": 80
      },
      "endpoint": false
    },

    "db": {
      "replicas": 1,
      "name": "db",
      "image": "postgres:13-alpine",
      "ports": {
         "containerPort": 5432
      },
      "service": {
         "port": 5432
      }
    },
  }
}
