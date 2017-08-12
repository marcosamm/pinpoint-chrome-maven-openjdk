# pinpointagent-chrome-maven-openjdk
Pinpoint agent, Chrome, Maven and OpenJDK Dokerfile

### Add the pinpoint-agent configuration to your project's pom.xml file
```
...
<build>
  <plugins>
    ...
    <plugin>
	  <artifactId>maven-failsafe-plugin</artifactId>
	  <configuration>
	    <argLine>-javaagent:/opt/pinpoint-agent/pinpoint-bootstrap.jar -Dpinpoint.agentId=YOURAGENTID -Dpinpoint.applicationName=YOURAPPNAME</argLine> 
	  </configuration>
	  <executions>
	    <execution>
	      <goals>
	        <goal>integration-test</goal>
	        <goal>verify</goal>
	      </goals>
	    </execution>
	  </executions>
	</plugin>
    ...
  </plugins>
</build>
...
```
See an example of complete [pom.xml](https://github.com/marcosamm/joinfaces-example/blob/master/pom.xml) file.

### To run container
```
docker run -it --rm \
   -e COLLECTOR_IP="192.168.0.18" \
   -e PROFILER_APPLICATIONSERVERTYPE="TOMCAT" \
   -e PROFILER_TOMCAT_CONDITIONAL_TRANSFORM="false" \
   -v /PATH/TO/YOUR/JAVA/MAVEN/APP/:/opt/app/ \
   -v /home/marcosamm/.m2/repository:/root/.m2/repository \
   marcosamm/pinpointagent-chrome-maven-openjdk \
   /bin/sh -c "cd /opt/app/; xvfb-run mvn clean install verify"
```
See another example using [Dockerfile](https://github.com/marcosamm/docker-pinpoint/tree/master/examples/joinfaces-example-with-selenium-test)

### Notes
* The following environment variables can be used to set pinpoint-agent configuration properties (pinpoint.config):
   - COLLECTOR_IP
   - PROFILER_APPLICATIONSERVERTYPE
   - PROFILER_TOMCAT_CONDITIONAL_TRANSFORM
   - PROFILER_SAMPLING_RATE
   - PROFILER_JSON_JSONLIB
   - PROFILER_JSON_JACKSON
   - PROFILER_JSON_GSON
* You can map a custom configuration file as a volume with the option: -v /path/to/pinpoint.config:/opt/pinpoint-agent/pinpoint.config:rw
* If the pinpoint.config file is mapped only with read permission (ro), do not use any environment variable to modify pinpoint-agent configuration parameters, this will cause errors.