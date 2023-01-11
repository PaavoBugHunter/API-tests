import json
import jsonschema

def get_json_reference(reference_schema_path):
    #Fetches the reference-json schema file that we've made and returns it for the program
    try:
        with open(reference_schema_path) as json_file:
            data = json.load(json_file)
        return data
    except json.decoder.JSONDecodeError as json_err:
        raise json.decoder.JSONDecodeError(f'Can\'t parse the schema from the json-schema file {reference_schema_path}. Error: {json_err}')
    except FileNotFoundError as file_err:
        raise FileNotFoundError(f'Reference-file does not exist at {reference_schema_path}. Error: {file_err}')
    except Exception as Ex:
        raise Exception(f'Something went terribly wrong. Error: {Ex}')

def compare_schemas(reference_schema_path, input_schema):
    #Executes the reference-schema function and validates the schema in the api-response against it.
    try:
        reference_schema = get_json_reference(reference_schema_path)
        jsonschema.validate(instance=input_schema, schema=reference_schema)
    except jsonschema.SchemaError as schema_err:
        raise jsonschema.SchemaError(f'Schema on path {reference_schema_path} is not a json-schema. Error: {schema_err}')
    except jsonschema.ValidationError as val_err:
        raise jsonschema.ValidationError(f'Validation went wrong. Error is {val_err}')
    except Exception as Ex:
        raise Exception(f'Something went terribly wrong. Error: {Ex}')