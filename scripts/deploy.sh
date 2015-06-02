#! /bin/bash -e

service_name=$1
build_hash=$2


dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
out_dir=/opt/scripts/out
service_unit="${service_name}-${build_hash}"
service_file="$out_dir/$service_unit@.service"
topic_unit="${service_name}-topics-${build_hash}.service"

# Create fleet/ systemd service file
echo "Creating service file: $service_file"
${dir}/service_template.sh ${service_name} ${build_hash} > ${service_file}

# create topics via container
${dir}/service_topics_template.sh ${service_name}  > ${out_dir}/${topic_unit}

# roll out
## setup ssh
eval `ssh-agent -s`

file="/opt/scripts/coreos_ssh_key"
if [ ! -f "$file" ]; then
echo "ssh key required! Use docker mount:`-v <PATH_TO_THE_KEY_FILE>:/opt/scripts/coreos_ssh_key:ro`"
exit 1
fi

ssh-add ${file}

## push to server
cd ${out_dir}
echo "Starting create topic job"
fleetctl start ${topic_unit}

echo "Starting ${service_name} service"
fleetctl start ${service_unit}@1

