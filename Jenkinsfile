try {
	 timeout(time: 20, unit: 'MINUTES') {
		def appName="${APP_NAME}"
		def project=""
		node {
		  stage("Initialize") {
			project = env.PROJECT_NAME
		  }
		}
		node("maven") {
		  stage("Checkout") {
			git url: "${GIT_SOURCE_URL}", branch: "${GIT_SOURCE_REF}"
		  }
		  stage("Build JAR") {
			sh "mvn clean package"
			stash name:"jar", includes:"target/${appName}.jar"
		  }
		}
		node {
		  stage("Build Image") {
			unstash name:"jar"
			sh "oc start-build ${appName}-docker --from-file=target/${appName}.jar -n ${project}"
			openshiftVerifyBuild bldCfg: "${appName}-docker", namespace: project, waitTime: '20', waitUnit: 'min'
		  }
		  stage("Deploy") {
			openshiftDeploy deploymentConfig: appName, namespace: project
		  }
		}
	 }
} catch (err) {
	 echo "in catch block"
	 echo "Caught: ${err}"
	 currentBuild.result = 'FAILURE'
	 throw err
}
