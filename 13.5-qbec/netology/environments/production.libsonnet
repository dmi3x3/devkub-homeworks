local production = import './stage.libsonnet';

production {
  components +: {
    back +: {
      replicas: 3,
    },
    front +: {
      replicas: 3,
    },
    db +: {
      replicas: 3,
    },
    endpoint: {
      address: "10.168.1.158"
    }
  }
}
