plugins {
    id("com.citi.helm") version "2.2.0"
    id("com.citi.helm-releases") version "2.2.0"
}


group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

helm {
    charts {
        create("kafkachart") {
            sourceDir = layout.projectDirectory.dir("kafkachart")
            version = "0.0.1"
        }
    }

    releases {
        create("kafka") {
            from(chart("kafkachart"))
            version = "0.0.1"
            namespace = "default"
            kubeContext = "minikube"
            wait = true
        }
    }
}
