# PoC Connect to Google Cloud MySQL from Spring Boot Application

To test, point your browser to http://localhost:8080. This will insert two records into the MySQL database, 
followed by a query returning all records.

## Google Cloud Configuration

- Create a database in the SQL instance
- [Enable the Cloud SQL API](https://console.cloud.google.com/flows/enableapi?apiid=sqladmin)
- Create a Google Cloud Service Account following instructions [here](https://cloud.google.com/docs/authentication/production#obtaining_and_providing_service_account_credentials_manually) 

## Environment Variables

### DB_URL

```
jdbc:mysql://google/db_test_01?cloudSqlInstance=test-mysql-public:us-east4:test-01&socketFactory=com.google.cloud.sql.mysql.SocketFactory
```

### DB_USER and DB_PASSWORD

Create database user in Google Cloud Console and copy values to use in these environment variables. 

### GOOGLE_APPLICATION_CREDENTIALS

Create a Google Cloud Service Account following instructions [here](https://cloud.google.com/docs/authentication/production#obtaining_and_providing_service_account_credentials_manually) 

```
/path/to/google/credentials/file.json
```

## Java Dependencies

There are different mechanisms to connect to a MySQL database in Google Cloud. Some methods are more complicated 
to configure than others. 

For a Spring application, an easy way to connect is by using [Google's Cloud SQL Socket Factory for JDBC drivers](https://github.com/GoogleCloudPlatform/cloud-sql-jdbc-socket-factory) 

Gradle Configuration:

```
runtimeOnly 'mysql:mysql-connector-java:8.0.19'
runtimeOnly 'com.google.cloud.sql:mysql-socket-factory-connector-j-8:1.0.15'
```
