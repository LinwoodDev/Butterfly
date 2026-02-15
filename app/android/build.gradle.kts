allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    afterEvaluate {
        if (project.extensions.findByName("android") != null) {
            project.extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                if (compileSdkVersion == "android-31" || compileSdkVersion == "android-33" || compileSdkVersion == "android-34") {
                    val appProject = rootProject.project(":app")
                    val appAndroid = appProject.extensions.findByType(com.android.build.gradle.BaseExtension::class.java)
                    if (appAndroid != null && appAndroid.compileSdkVersion != null) {
                        println("Setting compileSdkVersion to ${appAndroid.compileSdkVersion} for ${project.name}")
                        compileSdkVersion = appAndroid.compileSdkVersion
                    } else {
                        println("Could not find compileSdkVersion from app project for ${project.name}")
                    }
                }
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
