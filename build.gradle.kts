plugins {
    id("com.citi.helm") version "2.2.0"
    id("com.citi.helm-releases") version "2.2.0"
}


group = "org.alterbit"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

helm {
    charts {
        create("kafka") {
            sourceDir = layout.projectDirectory.dir("kafka-chart")
            version = "0.0.1"
        }
    }

    releases {
        create("kafka") {
            from(chart("kafka"))
            version = "0.0.1"
            namespace = "default"
            kubeContext = "minikube"
            wait = true
        }
    }
}
