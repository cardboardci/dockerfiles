
image_digest_default=$(curl -sSL "https://registry.hub.docker.com/v2/repositories/library/ubuntu/tags/" | \
	jq -r -c '.results | .[] | select( .name == "focal") | .images | .[] | select( .architecture == "amd64") | .digest'
)
echo $image_digest_default
image_digest=$(curl -sSL "https://${REGISTRY_URL}/v2/repositories/${REGISTRY_IMAGE}/tags/" | \
	jq -r -c ".results | .[] | select( .name == \"${REGISTRY_TAG}\") | .images | .[] | select( .architecture == \"${REGISTRY_ARCH}\") | .digest"
)
echo $image_digest
if [[ -z "$image_digest" ]]; then
	echo "Unable to find an image by the expected name."
	exit 101
fi

echo "Change the file with buildifier"