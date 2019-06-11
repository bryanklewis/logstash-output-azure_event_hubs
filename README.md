# Logstash Output Plugin for Azure Event Hubs

This is a plugin for [Logstash](https://github.com/elastic/logstash). It is fully free and open source. The license is Apache 2.0.
This plugin enables you to send events from Elastic Logstash to an Azure [Event Hubs](https://azure.microsoft.com/en-us/services/event-hubs/) entity. The Azure Event Hubs [Java SDK](https://docs.microsoft.com/en-us/java/api/com.microsoft.azure.eventhubs.eventhubclient.sendsync?view=azure-java-stable) is used to send events via synchronous class methods over AMQP.

## Requirements

- Java 11 JDK or JRE. Recommend the [Azul Zulu](https://www.elastic.co/guide/en/logstash/current/installing-logstash.html) OpenJDK builds.
- Logstash version 7+. [Installation instructions](https://www.elastic.co/guide/en/logstash/current/installing-logstash.html) 
- Azure Event Hubs namespace and hub.
  - Read [Create an Event Hub](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-create) for more information.
- Credentials with permission to write data into Azure Event Hubs.
  - [Create a SAS Policy Key](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-get-connection-string) for more information on viewing your connection screen or where to create a new key.

## Installation

To make the Azure Event Hubs output plugin available in your Logstash environment, run the following command:
```sh
bin/logstash-plugin install logstash-output-azure_event_hubs
```

## Configuration

Information about configuring Logstash can be found in the [Logstash configuration guide](https://www.elastic.co/guide/en/logstash/current/configuration.html).

You will need to configure this plugin before sending events from Logstash to Azure Event Hubs. The following example shows the minimum you need to provide:

```yaml
output {
    azure_event_hubs {
        service_namespace => "myeventnamespace" #Exclude .servicebus.windows.net
        event_hub => "logs"
        sas_key_name => "myeventnamespace-write"
        sas_key => '...'
    }
}
```

### Available Configuration Keys

| Parameter Name | Description | Notes |
| --- | --- | --- |
| service_namespace | Azure Service Namespace or Endpoint. | Required.
| service_uri | Use a national Azure Cloud. | 
| event_hub | Azure Event Hub (Entity) Path. | Required
| sas_key_name | Azure Shared Access Signature (SAS) Key Name. | Required
| sas_key | Azure Shared Access Signature (SAS) Key. | Required
| connection_retry_count | Number of times to retry a failed Event Hubs connection. | Default: 3
| properties_bag | Event metadata key=value pairs to set in the user-defined property bag. See [EventData](https://docs.microsoft.com/en-us/java/api/com.microsoft.azure.eventhubs.eventdata?view=azure-java-stable) class for more information. This config can be used to route events dynamically for [Azure Data Explorer]() by setting properties: <br>```"Table" => "%{[adx_table_name]}" "Format" => "json" "IngestionMappingReference" => "adx_ingest_map"``` | Format: ```properties_bag => { "key1" => "value1" "key2" => "%{[event_field]}" }```
| client_threads | Total threads used by Azure Event Hubs client to handle events. This value is used when creating the Java Concurrency Executor pool size. | Default: 4

## Development

- Jruby 9.2.6.0+
- Java 11 JDK
- Logstash version 7+. 
- Azure Event Hubs namespace, hub, and credential to test against.
- [Gradle](https://gradle.org/install/) is used to download the .jar dependencies and generate the classpath file by running:

1. Install Dependencies
```shell
rake vendor
bundle install
```
or
```shell
gradle vendor --info
bundle install
```

2. Running your unpublished Plugin in Logstash
Run in a local Logstash clone. Edit the Logstash Gemfile and add the local plugin path at the top of the Gemfile, for example:
```
gem 'logstash-output-azure_event_hubs', :path => '/path/to/logstash-output-azure_event_hubs'
```

## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports, and complaints. For more information about contributing, see the [CONTRIBUTING](https://github.com/elastic/logstash/blob/master/CONTRIBUTING.md) file.
