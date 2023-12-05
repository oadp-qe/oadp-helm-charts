import sys
import ruamel.yaml

def modify_yaml(yaml_file, new_bucket, new_provider, new_s3_url):
    # Load the YAML with preservation of formatting
    yaml = ruamel.yaml.YAML()
    yaml.default_flow_style = False  # Maintain block style for dictionaries and lists
    with open(yaml_file, 'r') as file:
        data = yaml.load(file)

    # Modify the 'bucket' and 'provider' and s3 url values
    if 'bsl' in data and 'bsls' in data['bsl']:
        for item in data['bsl']['bsls']:
            if 'bucket' in item:
                item['bucket'] = new_bucket
            if 's3' in item:
                item['s3']['url'] = new_s3_url
            if 'provider' in item:
                item['provider'] = new_provider

    # Save the modified YAML back to the file with preserved formatting
    with open(yaml_file, 'w') as file:
        yaml.dump(data, file)
        file.write('\n')  # Adds a new line at the end of the file

if __name__ == "__main__":
    # Ensure proper number of arguments
    if len(sys.argv) != 5:
        print("Usage: python modify_yaml.py <YAML_FILE> <NEW_BUCKET> <NEW_PROVIDER> <NEW_S3_URL>")
        sys.exit(1)

    yaml_file = sys.argv[1]
    new_bucket = sys.argv[2]
    new_provider = sys.argv[3]
    new_s3_url = sys.argv[4]

    modify_yaml(yaml_file, new_bucket, new_provider, new_s3_url)