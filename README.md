# flutter_github_actions
Workaround on github actions

# Generate config.json.enc
openssl enc -aes-256-cbc -salt -in ./ci/config.json -out config.json.enc -base64 -pass pass:"<Encryption_key>"

