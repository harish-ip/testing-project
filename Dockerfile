FROM openjdk:8-jdk-windowsservercore-1809

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD /installers/apache-maven-3.6.3 C:/ProgramData/Maven
ADD /installers/ZAP C:/ZAP
RUN mkdir installers
RUN mkdir testing
COPY /installers/ChromeSetup.exe /installers
COPY /installers/insight68taf.jar /testing
ENV MAVEN_HOME C:/ProgramData/Maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2" 
RUN ["c:/installers/ChromeSetup.exe", "/silent", "/install"]
# COPY mvn-entrypoint.ps1 C:/ProgramData/Maven/mvn-entrypoint.ps1
# COPY settings-docker.xml C:/ProgramData/Maven/Reference/settings-docker.xml

RUN setx /M PATH $('{0};{1}' -f $env:PATH,'C:\ProgramData\Maven\bin') | Out-Null

USER ContainerUser
ENV JAVA_HOME=${JAVA_HOME}

#ENTRYPOINT ["powershell.exe", "-f", "C:/ProgramData/Maven/mvn-entrypoint.ps1"]
#CMD ["mvn"]
