#!/bin/bash

# Shell script to chain Packer output into Terraform
# Packer builds image against wordpress.json, tagging AMI artifact with a UUID
# AWS is queried for this tag, returning the AMI ID
# Terraform is run with this AMI ID as an agrument against a variable

# Generate UUID
if hash uuid 2>/dev/null; then
    UUID=$(uuid -v4)
else
    UUID=$(date +"%Y%m%d%H%M%S")
fi

# Pass UUID to Packer when building image, overriding `packer_uuid` variable
(cd packer/ && exec packer build -var packer_uuid=${UUID} wordpress.json)

# Query AWS for image with same UUID tag
AMI_ID=$(aws ec2 describe-images --filters Name=tag:packer_uuid,Values=${UUID} --output text --query 'Images[0].ImageId')

# Run Terraform with new AMI ID
(cd terraform/ && exec terraform apply -var ubuntu-ami=${AMI_ID})