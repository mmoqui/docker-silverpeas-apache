A Docker image of the Apache web server dedicated to serve as a reverse-proxy some Silverpeas instances.
It listens for incoming HTTPS request against one of the Silverpeas instances to serve and redirect them to the Docker container in which the targeted Silverpeas is running.

For instance, the Apache web server is configured to serve two Silverpeas instances:
* _silverpeas-main_ which should be the current next version of Silverpeas in development;
* _silverpeas-stable_ which should be the current stable version of Silverpeas (for which the fix versions are in development).

The image includes a fake root CA certificate to sign and validate certificates for _silverpeas_main_ and _silverpeas_master_. In order the web browser to access the Silverpeas instances in HTTPS through the Apache reverse-proxy, the root certificate (in the src/ directory) should be explicitly set among the root CA of the browser.