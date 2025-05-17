allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Set custom build directory for root project
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

// Set custom build directory for all subprojects
subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    layout.buildDirectory.set(newSubprojectBuildDir)

    // Ensure app project is evaluated before others
    evaluationDependsOn(":app")
}

// Register clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// Set NDK version
extra["ndkVersion"] = "27.0.12077973"
