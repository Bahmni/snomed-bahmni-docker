use openmrs;
update global_property set property_value='http://snowstorm-lite:8080/fhir/' where property='ts.fhir.baseurl';