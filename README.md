# PoC Connect to Google Cloud MySQL from Spring Boot Application

To test, point your browser to http://localhost:8080. This will insert two records into the MySQL database, 
followed by a query returning all records.

## Google Cloud Configuration

- Create a database in the SQL instance
- [Enable the Cloud SQL API](https://console.cloud.google.com/flows/enableapi?apiid=sqladmin)
- Create a Google Cloud Service Account following instructions [here](https://cloud.google.com/docs/authentication/production#obtaining_and_providing_service_account_credentials_manually) 

## Environment Variables

## CF_ORG, CF_PASSWORD, CF_SPACE, CF_USERNAME

These variables hold credentials to access Pivotal Web Services. They are used when setting up cf cli

```
cf auth "$CF_USERNAME" "$CF_PASSWORD"
cf target -o "$CF_ORG" -s "$CF_SPACE"
```

### DB_USER and DB_PASSWORD

MySQL username and password created in Google Cloud Console 

### DB_URL

Special database URL to use Google Cloud JDBC Socket Factory to connect to database

```
jdbc:mysql://google/db_test_01?cloudSqlInstance=test-mysql-public:us-east4:test-01&socketFactory=com.google.cloud.sql.mysql.SocketFactory
```

### GC_SVC_ACCT_CLIENT_CERT_URL
Use property `client_x509_cert_url` from Google Service Account json file

### GC_SVC_ACCT_CLIENT_EMAIL
Use property `client_email` from Google Service Account json file

### GC_SVC_ACCT_CLIENT_ID
Use property `client_id` from Google Service Account json file

### GC_SVC_ACCT_PRIVATE_KEY_BASE64
Base64-encode property `private_key` from Google Service Account json file. This value contains escaped 
new lines `\n` that cause problems in the CI/CD pipeline. Encoding this value in base64 works around 
these problems. To calculate encoded value use command below.

```
echo private_key | base64
```

### GC_SVC_ACCT_PRIVATE_KEY_ID
Use property `private_key_id` from Google Service Account json file

### GC_SVC_ACCT_PROJECT_ID
Use property `project_id` from Google Service Account json file

## Java Dependencies

There are different mechanisms to connect to a MySQL database in Google Cloud. Some methods are more complicated 
to configure than others. 

For a Spring application, an easy way to connect is by using [Google's Cloud SQL Socket Factory for JDBC drivers](https://github.com/GoogleCloudPlatform/cloud-sql-jdbc-socket-factory) 

Gradle Configuration:

```
runtimeOnly 'mysql:mysql-connector-java:8.0.19'
runtimeOnly 'com.google.cloud.sql:mysql-socket-factory-connector-j-8:1.0.15'
```
